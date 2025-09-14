import dotenv from "dotenv";
dotenv.config();

import cors from "cors";
import express from "express";
import { Readable } from "node:stream";
import { pipeline } from "node:stream/promises";
import { mcpToolsList } from "./mcp/mcp-tools.js";
import { setupAgents } from "./orchestrator/llamaindex/index.js";
import { McpToolsConfig } from "./orchestrator/llamaindex/tools/index.js";

const app = express();
const PORT = process.env.PORT || 4000;
const CHUNK_END = "\n\n";

// Middleware
app.use(cors());
app.use(express.json());

const apiRouter = express.Router();

// Add request body logging middleware for debugging
apiRouter.use((req, res, next) => {
  if (req.path === "/chat" && req.method === "POST") {
    const contentType = req.headers["content-type"]?.replace(/\n|\r/g, "");
    const body =
      typeof req.body === "string"
        ? req.body.replace(/\n|\r/g, "")
        : JSON.stringify(req.body).replace(/\n|\r/g, "");
    console.log("Request Content-Type:", contentType);
    console.log("Request body:", body);
  }
  next();
});

// Health check endpoint
apiRouter.get("/health", (req, res) => {
  res.status(200).json({ status: "OK" });
});

// MCP tools
apiRouter.get("/tools", async (req, res) => {
  try {
    const tools = await mcpToolsList(Object.values(McpToolsConfig()));
    console.log("Available tools:", tools);
    res.status(200).json({ tools });
  } catch (error) {
    console.error("Error fetching MCP tools:", error);
    res.status(500).json({ error: "Error fetching MCP tools" });
  }
});

// Chat endpoint with Server-Sent Events (SSE) for streaming responses
// @ts-ignore - Ignoring TypeScript errors for Express route handlers
apiRouter.post("/chat", async (req, res) => {
  req.on("close", () => {
    console.log("Client disconnected, aborting...");
  });

  if (!req.body) {
    console.error(
      "Request body is undefined. Check Content-Type header in the request."
    );
    return res.status(400).json({
      error:
        "Request body is undefined. Make sure to set Content-Type to application/json.",
    });
  }

  const message = req.body.message;
  const tools = req.body.tools;
  console.log("Tools to use:", JSON.stringify(tools, null, 2));

  if (!message) {
    return res.status(400).json({ error: "Message is required" });
  }

  res.setHeader("Content-Type", "text/event-stream");
  res.setHeader("Cache-Control", "no-cache");
  res.setHeader("Connection", "keep-alive");

  try {
    const agents = await setupAgents(tools);
    const context = agents.run(message);

    const readableStream = new Readable({
      async read() {
        try {
          for await (const event of context) {
            const { displayName, data } = event;
            const serializedData = JSON.stringify({
              type: "metadata",
              agent: (data as any)?.currentAgentName || null,
              event: displayName,
              data: data ? JSON.parse(JSON.stringify(data)) : null,
            });
            this.push(serializedData + CHUNK_END);
            console.log("Pushed event:", serializedData);
          }
          this.push(null); // Close the stream
        } catch (error: any) {
          console.error("Error during streaming:", error?.message);
          // this.push(
          //   JSON.stringify({
          //     type: "error",
          //     message: "Serialization error",
          //     error,
          //   }) + CHUNK_END
          // );
        }
      },
    });

    await pipeline(readableStream, res);
  } catch (error) {
    console.error("Error occurred:", error);
    if (!res.headersSent) {
      res.status(500).json({ error: (error as any).message });
    } else {
      res.write(
        `${JSON.stringify({
          type: "error",
          message: (error as any).message,
        })}` + CHUNK_END
      );
      res.end();
    }
  }
});

// Mount the API router with the /api prefix
app.use("/api", apiRouter);

// Add a root route for API information
app.get("/", (req, res) => {
  res.json({
    message: "KT Sales Agents API",
    version: "1.0.0",
    endpoints: {
      health: "/api/health",
      chat: "/api/chat",
    },
  });
});

// Start the server
app.listen(PORT, () => {
  console.log(`API server running on port ${PORT}`);
  console.log(`API endpoints:`);
  console.log(`  - Health check: http://localhost:${PORT}/api/health (GET)`);
  console.log(`  - MCP Tools: http://localhost:${PORT}/api/tools (GET)`);
  console.log(`  - Chat: http://localhost:${PORT}/api/chat (POST)`);
});
