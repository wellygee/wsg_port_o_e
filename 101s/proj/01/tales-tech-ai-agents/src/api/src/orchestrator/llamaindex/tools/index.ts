import { McpServerDefinition } from "../../../mcp/mcp-tools.js";

export type McpServerName =
  | "echo-ping"
  | "customer-query"
  | "research-planning"
  | "topic-recommendation";

export const McpToolsConfig = (): {
  [k in McpServerName]: McpServerDefinition;
} => ({
  "echo-ping": {
    config: {
      url: process.env["TOOL_ECHO_PING_URL"] as string,
      verbose: true,
    },
    id: "echo-ping",
    name: "Echo Test",
  },
  "customer-query": {
    config: {
      url: process.env["TOOL_CUSTOMER_QUERY_URL"] as string,
      verbose: true,
    },
    id: "customer-query",
    name: "Customer Query",
  },
  "research-planning": {
    config: {
      url: process.env["TOOL_RESEARCH_PLANNING_URL"] as string,
      verbose: true,
    },
    id: "research-planning",
    name: "Research Planning",
  },
  "topic-recommendation": {
    config: {
      url: process.env["TOOL_TOPIC_RECOMMENDATION_URL"] as string,
      verbose: true,
    },
    id: "topic-recommendation",
    name: "Topic Recommendation",
  },
});
