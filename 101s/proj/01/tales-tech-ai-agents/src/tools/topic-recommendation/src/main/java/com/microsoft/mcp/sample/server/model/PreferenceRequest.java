package com.microsoft.mcp.sample.server.model;

/**
 * Class representing user preferences for Topic Recommendations.
 * Using String types instead of enum references to avoid compilation issues.
 */
public class PreferenceRequest {
    private String preferredDomainTheme;  // Changed from ActivityType to String
    private String budgetCategory;     // Changed from BudgetCategory to String
    private String preferredCategory;    // Changed from Season to String
    private Boolean familyFriendly;
    private Integer numberOfTopics;

    // Default constructor
    public PreferenceRequest() {
        this.numberOfTopics = 3; // Default to returning 3 topics
    }

    // Constructor
    public PreferenceRequest(String preferredDomainTheme, String budgetCategory,
                          String preferredCategory, Integer numberOfTopics) {
        this.preferredDomainTheme = preferredDomainTheme;
        this.budgetCategory = budgetCategory;
        this.preferredCategory = preferredCategory;
        this.numberOfTopics = numberOfTopics != null ? numberOfTopics : 3;
    }

    // Getters and setters
    public String getPreferredDomainTheme() {
        return preferredDomainTheme;
    }

    public void setPreferredDomainTheme(String preferredDomainTheme) {
        this.preferredDomainTheme = preferredDomainTheme;
    }

    public String getBudgetCategory() {
        return budgetCategory;
    }

    public void setBudgetCategory(String budgetCategory) {
        this.budgetCategory = budgetCategory;
    }

    public String getPreferredCategory() {
        return preferredCategory;
    }

    public void setPreferredCategory(String preferredCategory) {
        this.preferredCategory = preferredCategory;
    }

    public Integer getNumberOfTopics() {
        return numberOfTopics;
    }

    public void setNumberOfTopics(Integer numberOfTopics) {
        this.numberOfTopics = numberOfTopics != null ? numberOfTopics : 3;
    }
}
