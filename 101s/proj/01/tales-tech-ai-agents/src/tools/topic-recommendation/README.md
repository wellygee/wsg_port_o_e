# Research Topic Recommendation Service

This service provides Research Topic Recommendations based on user preferences using the Spring AI MCP Server Boot Starter with WebFlux transport. It helps users discover topic recommendations based on activity preferences, budget constraints, seasonal preferences, and family-friendliness.

For more information, see the [MCP Server Boot Starter](https://docs.spring.io/spring-ai/reference/api/mcp/mcp-server-boot-starter-docs.html) reference documentation.

## Overview

The service showcases:
- Support for SSE (Server-Sent Events)
- Automatic tool registration using Spring AI's `@Tool` annotation
- Topic Recommendation tools:
  - Get topics by activity type (beach, adventure, cultural, etc.)
  - Get topics by budget category (budget, moderate, luxury)
  - Get topics by season (spring, summer, autumn, winter)
  - Get topics by multiple preference criteria
  - Simple message repeating functionality (retained for compatibility)

## Using the Service

The service exposes the following API endpoints through the MCP protocol:

- `getTopicsByActivity`: Get topics matching a specific activity type
- `getTopicsByBudget`: Get topics matching a budget category
- `getTopicsBySeason`: Get topics ideal for a specific season
- `getTopicsByPreferences`: Get topics matching multiple criteria
- `getAllTopics`: Get a list of all available topics

## Test Client

A test client is included in the `com.microsoft.mcp.sample.server.client` package. The `TopicRecommendationClient` class demonstrates how to interact with the service programmatically.

## Dependencies

The project requires the Spring AI MCP Server WebFlux Boot Starter:

```xml
<dependency>
    <groupId>org.springframework.ai</groupId>
    <artifactId>spring-ai-mcp-server-webflux-spring-boot-starter</artifactId>
</dependency>
```

This starter provides:
- Reactive transport using Spring WebFlux (`WebFluxSseServerTransport`)
- Auto-configured reactive SSE endpoints
- Included `spring-boot-starter-webflux` and `mcp-spring-webflux` dependencies

## Building the Project

Build the project using Maven:
```bash
./mvnw clean install -DskipTests
```

## Running the Server

```bash
java -jar target/topic-server-0.0.1-SNAPSHOT.jar
```

## Development with DevContainer

This project includes a DevContainer configuration for Visual Studio Code, providing a consistent development environment:

1. Install [VS Code](https://code.visualstudio.com/) and the [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension
2. Open the project folder in VS Code
3. Click "Reopen in Container" when prompted or run the "Dev Containers: Reopen in Container" command
4. The container will build and start

See the `.devcontainer` folder for more details.

## Running with Docker

The project includes a Dockerfile for containerization:

```bash
docker build --pull --rm -f 'Dockerfile' -t 'topic-recommendation:latest' '.'  
docker run -d -p 8080:8080 topic-recommendation:latest
```

## Testing the Server

### Using the ClientSse Test Client

The project includes a `ClientSse` class that provides a simple client for testing the server. This utility helps you send requests and receive streaming responses from the MCP server endpoints.

step 1 - Build and run the docker server (on port 8080)
step 2 - Run the ClientSse test
