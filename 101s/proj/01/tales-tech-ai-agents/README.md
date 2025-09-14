# The KT Sales Agents

The KT Sales Agents is a robust **enterprise application** that leverages multiple **AI agents** to enhance sales agency operations. The application demonstrates how the **four AI agents** collaborate to assist customer queries, research planning and providing topic recommendations. it's based on a ([Microsoft recommendend pattern](https://learn.microsoft.com/en-us/training/modules/guided-project-create-ai-travel-agent/)).

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

![High-Level Architecture](docs/ai-sales-agent-system-diagram.svg)

## Project Structure

```
ai-agents/
│── src/
│   ├── tools/
│   │   ├── customer-query/
│   │   ├── topic-recommendation/
│   │   ├── research-planning/
│   │   └── echo-ping/
│   │
│   ├── api/                # API Gateway for backend services
│   └── ui/                 # Frontend application
│
│── README.md              # Project documentation
```

## Prerequisites

Ensure you have the following installed before running the application:

- **[Docker](https://www.docker.com/)**

## Environment Variables setup for containerized services

The application uses environment variables to configure the services. You can set them in a `.env` file in the root directory or directly in your terminal. We recommend the following approach:
1. Create a `.env.dev` file for each containerized service under `src/`, and optionally a `.env.docker` file for Docker-specific configurations:
    - `src/ui/.env.dev`
    - `src/ui/.env.docker`
    - `src/api/.env.dev`
    - `src/api/.env.docker`
    - `src/tools/customer-query/.env.dev`
    - `src/tools/customer-query/.env.docker`
    - `src/tools/topic-recommendation/.env.dev`
    - `src/tools/topic-recommendation/.env.docker`
    - `src/tools/research-planning/.env.dev`
    - `src/tools/research-planning/.env.docker`
    - `src/tools/echo-ping/.env.dev`
    - `src/tools/echo-ping/.env.docker`

2. `.env.docker` files are used to set environment variables for Docker containers. These files should contain the same variables as `.env.dev` files, but with values specific to the Docker environment. For example:

```bash
# src/api/.env.dev
TOOL_CUSTOMER_QUERY_URL=http://localhost:8080

# src/api/.env.docker
TOOL_CUSTOMER_QUERY_URL=http://tool-customer-query:8080
```

3. Load the environment variable files in `docker-compose.yml` using the `env_file` directive, in the following order:
```yml
  web-api:
    container_name: web-api
    # ...
    env_file: 
      - "./api/.env.dev"
      - "./api/.env.docker" # override .env with .env.docker
```

> [!Note]
> adding the `- environment:` directive to the `docker-compose.yml` file will override the environment variables set in the `.env.*` files.

## Run the Entire Application

To run the entire application, use the scripts in the root directory. The scripts will build and run all the services defined in the `src/docker-compose.yml` file.

```sh
./run.sh
```


```node tool inspection
npx @modelcontextprotocol/inspector node build/index.js
```

Alternatively, if you're in VS Code you can use the **Run Task** command (Ctrl+Shift+P) and select the `Run KT Sales Agents` task.

This command will build and start all the services defined in the `docker-compose.yml` file.

Once all services are up and running, you can view the messages (currently logging messages) via the [Aspire Dashboard](http://localhost:18888). On `Structured` tab you'll see the logging messages from the **tool-echo-ping** and **api** services. The `Traces` tab will show the traces across the services, such as the call from **api** to **echo-agent**.

###