# KT Sales Agents - MCP Tools

This directory contains various AI agent tools that serve different purposes within the KT Sales Agents application. Each tool is implemented as an [MCP](https://github.com/modelcontextprotocol) server (in Python, TypeScript, C# and Java) and can be called by an MCP client (see [api package](../api))

## Overview of Tools

| Tool Name                                                  | Technology | Containerized ? | OpenTelemetry ? | GPU ? |
| ---------------------------------------------------------- | ---------- | --------------- | --------------- | ----- |
| [echo-ping](./echo-ping) (for testing)                     | TypeScript | ✅              | ✅              |       |
| [customer-query](./customer-query)                         | C#         | ✅              | ✅              |       |
| [topic-recommendation](./topic-recommendation)             | Java       | ✅              | ✅              |       |
| [research-planning](./research-planning)                   | Python     | ✅              | ✅              |       |

## Tool Descriptions

### customer-query

A .NET-based MCP server that processes customer queries. Implements the Model Context Protocol for handling customer inquiries.

### topic-recommendation

A tool for recommending research topic recommendations based on user preferences.

### echo-ping

A Node.js MCP server that provides echo functionality for testing purposes. Features OpenTelemetry integration for performance monitoring and tracing.

### research-planning

A tool for planning detailed research topic.

## Setting Up

Each tool is containerized using Docker and can be deployed independently or as part of the entire KT Sales Agents suite using Docker Compose (see [docker-compose.yml](../docker-compose.yml)).

## Development

To add a new tool, create a new directory with a descriptive name and implement the MCP server according to the protocol specifications. Make sure to:
- Include a README.md file with a description of the tool and its functionality.
- Include a .env.dev and .env.docker file for environment variables.
- Use [OpenTelemetry documentation](https://opentelemetry.io/docs/) for performance monitoring and tracing. See [./echo-ping](./echo-ping) for an example.
- Check that the tool is containerized and can be run independently. The server also needs to be able to run directly in the host (outside of the container) for local development. 
