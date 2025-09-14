# ... 101s

#### The KT Sales Agents

The KT Sales Agents is a robust **enterprise application** that leverages multiple **AI agents** to enhance sales agency operations.

## Overview of AI Agents

| Agent Name                       | Purpose                                                                                                                       |
| -------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| **Customer Query Understanding** | Extracts key **preferences** from customer inquiries.                                                                         |
| **Topic Recommendation**         | Suggests topics based on customer preferences.                                                                                |
| **Research Planning**            | Creates a detailed research plan.                                                                                             |
| **Echo Ping**                    | Echoes back any received input (used as an MCP server example).                                                               |


## High-Level Architecture

The architecture of the KT Sales Agents application is designed to be modular and scalable:

- All components are containerized using **Docker** so that they can be easily deployed and managed.
- All agents tools are available as MCP ([Model Context Protocol](https://github.com/modelcontextprotocol)) servers and are called by the MCP clients.
- MCP servers are implemented independently using variant technologies, such as **Python**, **Node.js**, **Java**, and **.NET**.
- The Agent Workflow Service orchestrates the interaction between the agents and MCP clients, allowing them to work together seamlessly.
- An Aspire Dashboard is used to monitor the application.

![High-Level Architecture](101s/proj/01/tales-tech-ai-agents/docs/ai-sales-agent-system-diagram.svg)

## Project Structure

[Visit project home for more detail..](101s/proj/01/tales-tech-ai-agents/README.md)
