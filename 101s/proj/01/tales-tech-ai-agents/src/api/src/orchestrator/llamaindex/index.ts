import { mcp } from "@llamaindex/tools";
import dotenv from "dotenv";
import { agent, multiAgent, ToolCallLLM } from "llamaindex";
import { McpServerDefinition } from "../../mcp/mcp-tools.js";
import { llm as llmProvider } from "./providers/azure-openai.js";
import { McpToolsConfig } from "./tools/index.js";
dotenv.config({
  path: "./.env.dev",
});

// Function to set up agents and return the multiAgent instance
export async function setupAgents(filteredTools: McpServerDefinition[] = []) {
  const tools = Object.fromEntries(
    filteredTools.map((tool) => [tool.id, true])
  );
  console.log("Filtered tools:", tools);

  let agentsList = [];
  let handoffTargets = [];
  let toolsList = [];
  const verbose = false;
  const mcpToolsConfig = McpToolsConfig();

  let llm: ToolCallLLM = {} as ToolCallLLM;
  try {
    llm = await llmProvider();
  } catch (error) {
    throw new Error(error instanceof Error ? error.message : String(error));
  }

  if (tools["echo-ping"]) {
    const mcpServerConfig = mcpToolsConfig["echo-ping"].config;
    const tools = await mcp(mcpServerConfig).tools();
    const echoAgent = agent({
      name: "EchoAgent",
      systemPrompt:
        "Echo back the received input. Do not respond with anything else. Always call the tools.",
      tools,
      llm,
      verbose,
    });
    agentsList.push(echoAgent);
    handoffTargets.push(echoAgent);
    toolsList.push(...tools);
  }

  if (tools["customer-query"]) {
    const mcpServerConfig = mcpToolsConfig["customer-query"];
    const tools = await mcp(mcpServerConfig.config).tools();
    const customerQuery = agent({
      name: "CustomerQueryAgent",
      systemPrompt:
        "Assists employees in better understanding customer needs, facilitating more accurate and personalized service. This agent is particularly useful for handling nuanced queries, such as specific research preferences or budget constraints, which are common in research agency interactions.",
      tools,
      llm,
      verbose,
    });
    agentsList.push(customerQuery);
    handoffTargets.push(customerQuery);
    toolsList.push(...tools);
  }

  if (tools["research-planning"]) {
    const mcpServerConfig = mcpToolsConfig["research-planning"];
    const tools = await mcp(mcpServerConfig.config).tools();
    const researchPlanningAgent = agent({
      name: "researchPlanningAgent",
      systemPrompt:
        "Creates an academic research plan based on user preferences and requirements.",
      tools,
      llm,
      verbose,
    });
    agentsList.push(researchPlanningAgent);
    handoffTargets.push(researchPlanningAgent);
    toolsList.push(...tools);
  }

  if (tools["topic-recommendation"]) {
    const mcpServerConfig = mcpToolsConfig["topic-recommendation"];
    const tools = await mcp(mcpServerConfig.config).tools();
    const topicRecommendationAgent = agent({
      name: "TopicRecommendationAgent",
      systemPrompt:
        "Recommends topics for academic research based on user preferences and requirements.",
      tools,
      llm,
      verbose,
    });
    agentsList.push(topicRecommendationAgent);
    handoffTargets.push(topicRecommendationAgent);
    toolsList.push(...tools);
  }

  // Define the triage agent that will determine the best course of action

  const triageAgent = agent({
    name: "TriageAgent",
    systemPrompt:
      "Acts as a triage agent to determine the best course of action for the user's query. If you cannot handle the query, please pass it to the next agent. If you can handle the query, please do so.",
    tools: [...toolsList],
    canHandoffTo: handoffTargets
      .map((target) => target.getAgents().map((agent) => agent.name))
      .flat(),
    llm,
    verbose,
  });
  agentsList.push(triageAgent);

  console.log("Agents list:", agentsList);
  console.log("Handoff targets:", handoffTargets);
  console.log("Tools list:", JSON.stringify(toolsList, null, 2));

  // Create the multi-agent workflow
  return multiAgent({
    agents: agentsList,
    rootAgent: triageAgent,
    verbose,
  });
}
