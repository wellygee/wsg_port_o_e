package com.microsoft.mcp.sample.server.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Configuration class that displays welcome and usage information at application startup.
 */
@Configuration
public class StartupConfig {

    @Value("${topic.service.welcome:Welcome to the Topic Recommendation Service!}")
    private String welcomeMessage;
    
    @Value("${topic.service.usage:}")
    private String usageMessage;
    
    /**
     * Display startup information when the application launches.
     */
    @Bean
    public CommandLineRunner startupInfo() {
        return args -> {
            System.out.println("\n" + "=".repeat(80));
            System.out.println(welcomeMessage);
            System.out.println("=".repeat(80));
            
            if (usageMessage != null && !usageMessage.isEmpty()) {
                System.out.println("\nUsage Information:");
                System.out.println(usageMessage);
                System.out.println("\nEndpoint: http://localhost:8080/v1/tools");
                System.out.println("\nSee the README.md for more information on how to use the service.");
            }
            
            System.out.println("\nThe Topic Recommendation service is now ready to accept requests!");
            System.out.println("=".repeat(80) + "\n");
        };
    }
}
