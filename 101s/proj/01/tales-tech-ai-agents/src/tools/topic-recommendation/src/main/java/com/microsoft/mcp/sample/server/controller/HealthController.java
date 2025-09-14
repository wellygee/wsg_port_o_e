package com.microsoft.mcp.sample.server.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.microsoft.mcp.sample.server.service.TopicService;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

/**
 * Controller for health check and information endpoints.
 */
@RestController
public class HealthController {

    private final TopicService topicService;

    @Autowired
    public HealthController(TopicService topicService) {
        this.topicService = topicService;
    }

    /**
     * Simple health check endpoint.
     *
     * @return Health status information
     */
    @GetMapping("/health")
    public ResponseEntity<Map<String, Object>> healthCheck() {
        Map<String, Object> response = new HashMap<>();
        response.put("status", "UP");
        response.put("timestamp", LocalDateTime.now().toString());
        response.put("service", "Topic Recommendation Service");
        
        return ResponseEntity.ok(response);
    }
    
    /**
     * Information endpoint about the service.
     * 
     * @return Service information
     */
    @GetMapping("/info")
    public ResponseEntity<Map<String, Object>> serviceInfo() {
        Map<String, Object> response = new HashMap<>();
        response.put("service", "Topic Recommendation Service");
        response.put("version", "1.0.0");
        response.put("endpoint", "/v1/tools");
        
        Map<String, String> tools = new HashMap<>();
        tools.put("getTopicsByDomainOrTheme", "Get topics by domain or theme (ENGINEERING, MEDICINE, etc.)");
        tools.put("getTopicsByBudget", "Get topics by budget (BUDGET, MODERATE, LUXURY)");
        tools.put("getTopicsByCategory", "Get topics by category (HOT, TIMELESS, etc.)");
        tools.put("getTopicsByPreferences", "Get topics matching multiple criteria");
        tools.put("getAllTopics", "Get all available topics");
        response.put("availableTools", tools);
        
        return ResponseEntity.ok(response);
    }
}
