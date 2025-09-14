package com.microsoft.mcp.sample.server;

import org.springframework.ai.tool.ToolCallbackProvider;
import org.springframework.ai.tool.method.MethodToolCallbackProvider;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import com.microsoft.mcp.sample.server.service.TopicService;

@SpringBootApplication
public class McpServerApplication {

	public static void main(String[] args) {
		SpringApplication.run(McpServerApplication.class, args);
	}
	
	@Bean
	public ToolCallbackProvider topicTools(TopicService topicService) {
		return MethodToolCallbackProvider.builder().toolObjects(topicService).build();
	}

}
