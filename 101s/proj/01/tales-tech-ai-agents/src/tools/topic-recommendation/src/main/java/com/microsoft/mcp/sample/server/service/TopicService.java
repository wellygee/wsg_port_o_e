package com.microsoft.mcp.sample.server.service;

import org.springframework.ai.tool.annotation.Tool;
import org.springframework.stereotype.Service;

/**
 * Service for providing Research Topic Recommendations.
 */
@Service
public class TopicService {

    // Constants for domain and themes
    public static final String ENGINEERING = "ENGINEERING";
    public static final String MEDICINE = "MEDICINE";
    public static final String HUMANITIES = "HUMANITIES";
    public static final String AI = "AI";
    public static final String ROBOTICS = "ROBOTICS";
    public static final String CANCER = "CANCER";
    public static final String NATURE = "NATURE";
    public static final String CULTURAL = "CULTURAL";
    public static final String RELAXATION = "RELAXATION";

    // Constants for budget categories
    public static final String BUDGET = "BUDGET";
    public static final String MODERATE = "MODERATE";
    public static final String PREMIUM = "PREMIUM";

    // Constants for demand categories
    public static final String HOT = "HOT";
    public static final String TIMELESS = "TIMELESS";
    public static final String OUTDATED = "OUTDATED";
    public static final String LIMITED = "LIMITED";

    /**
     * Echo back the input message
     * @param message The message to echo
     * @return The original message
     */
    @Tool(description = "Echo back the input message exactly as received")
    public String echoMessage(String message) {
        return message;
    }

    /**
     * Recommend topics based on domain, themes
     * @param domainOrThemes The preferred domain or themes (ENGINEERING, MEDICINE, HUMANITIES, CULTURAL, RELAXATION, ROBOTICS, CANCER, NATURE)
     * @return A list of recommended topics
     */
    @Tool(description = "Get research topic recommendations based on preferred domain, themes")
    public String getTopicsByDomainOrTheme(String domainOrThemes) {
        try {
            String domain = domainOrThemes.toUpperCase();
            // Validate domain or themes
            if (!isValidDomainOrTheme(domain)) {
                return "Invalid domain or themes. Please use one of: ENGINEERING, MEDICINE, HUMANITIES, CULTURAL, RELAXATION, ROBOTICS, CANCER, NATURE";
            }

            return getTopicsByPreference(domain, null, null);
        } catch (Exception e) {
            return "Invalid domain or themes. Please use one of: ENGINEERING, MEDICINE, HUMANITIES, CULTURAL, RELAXATION, ROBOTICS, CANCER, NATURE";
        }
    }

        // Helper method to validate domains
    private boolean isValidDomainOrTheme(String domainOrThemes) {
        return domainOrThemes.equals(ENGINEERING) ||
               domainOrThemes.equals(MEDICINE) ||
               domainOrThemes.equals(HUMANITIES) ||
               domainOrThemes.equals(ROBOTICS) ||
               domainOrThemes.equals(CANCER) ||
               domainOrThemes.equals(NATURE) ||
               domainOrThemes.equals(CULTURAL) ||
               domainOrThemes.equals(RELAXATION);
    }
    /**
     * Recommend topics based on category
     * @param category The preferred category (HOT, TIMELESS, OUTDATED, LIMITED)
     * @return A list of recommended topics
     */
    public String getTopicsByCategory(String category) {
        try {
            String categoryUpper = category.toUpperCase();
            // Validate category
            if (!isValidCategory(categoryUpper)) {
                return "Invalid category. Please use one of: HOT, TIMELESS, OUTDATED, LIMITED";
            }

            return getTopicsByPreference(null, null, categoryUpper);
        } catch (Exception e) {
            return "Invalid category. Please use one of: HOT, TIMELESS, OUTDATED, LIMITED";
        }
    }

    private boolean isValidCategory(String category) {
        return category.equals(HOT) ||
               category.equals(TIMELESS) ||
               category.equals(OUTDATED) ||
               category.equals(LIMITED);
    }

    /**
     * Recommend topics based on budget category
     * @param budget The budget category (BUDGET, MODERATE, PREMIUM)
     * @return A list of recommended topics
     */
    @Tool(description = "Get research topic recommendations based on budget category")
    public String getTopicsByBudget(String budget) {
        try {
            String budgetCategory = budget.toUpperCase();
            // Validate budget category
            if (!isValidBudgetCategory(budgetCategory)) {
                return "Invalid budget category. Please use one of: BUDGET, MODERATE, PREMIUM";
            }
            
            return getTopicsByPreference(null, budgetCategory, null);
        } catch (Exception e) {
            return "Invalid budget category. Please use one of: BUDGET, MODERATE, PREMIUM";
        }
    }
    
    // Helper method to validate budget categories
    private boolean isValidBudgetCategory(String budgetCategory) {
        return budgetCategory.equals(BUDGET) ||
               budgetCategory.equals(MODERATE) ||
               budgetCategory.equals(PREMIUM);
    }


    /**
     * Recommend topics based on multiple preferences
     * @param domainOrThemes The preferred domain or themes
     * @param budget The budget category
     * @param category The preferred category
     * @return A list of recommended topics
     */
    @Tool(description = "Get research topic recommendations based on multiple criteria")
    public String getTopicsByPreferences(String domainOrThemes, String budget, String category) {
        try {
            // Set preferences if provided
            if (domainOrThemes != null && !domainOrThemes.isEmpty()) {
                String domainOrThemesUpper = domainOrThemes.toUpperCase();
                if (!isValidDomainOrTheme(domainOrThemesUpper)) {
                    return "Invalid domain or themes. Please use one of: ENGINEERING, MEDICINE, HUMANITIES, CULTURAL, RELAXATION, ROBOTICS, CANCER, NATURE";
                }
            }

            if (category != null && !category.isEmpty()) {
                String categoryUpper = category.toUpperCase();
                if (!isValidCategory(categoryUpper)) {
                    return "Invalid category. Please use one of: HOT, TIMELESS, OUTDATED, LIMITED";
                }
            }
        
            if (budget != null && !budget.isEmpty()) {
                String budgetUpper = budget.toUpperCase();
                if (!isValidBudgetCategory(budgetUpper)) {
                    return "Invalid budget category. Please use one of: BUDGET, MODERATE, PREMIUM";
                }
            }

            return getTopicsByPreference(domainOrThemes, budget, category);
        } catch (Exception e) {
            return "Invalid input. Please check your parameters and try again.\n" + 
                   "Domain themes: MEDICINE, ENGINEERING, HUMANITIES, CULTURAL, RELAXATION, ROBOTICS, CANCER, NATURE\n" +
                   "Budget categories: BUDGET, MODERATE, PREMIUM\n" +
                   "Categories: HOT, TIMELESS, OUTDATED, LIMITED\n";
        }
    }
    

    /**
     * Get all available topics by domain theme and category
     * @param domainOrThemes The preferred domain or themes (ENGINEERING, MEDICINE, HUMANITIES, CULTURAL, RELAXATION, ROBOTICS, CANCER, NATURE)
     * @param category The preferred category (HOT, TIMELESS, OUTDATED, LIMITED)
     * @return A list of all topics
     */
    @Tool(description = "Get a list of all available topic recommendations")
    public String getAllTopics() {
        return "Here are some popular topic recommendations:\n\n" +
               "📍 Pediatric Medicine\n" +
               "⭐️ Focused on the health and well-being of infants, children, and adolescents.\n" +
               "🏷️ Domain: MEDICINE | Budget: MODERATE | Category: TIMELESS\n\n" +
               "📍 AI in Humanities\n" +
               "⭐️ Exploring the intersection of artificial intelligence and the humanities.\n" +
               "🏷️ Domain: CULTURAL | Budget: MODERATE | Category: HOT\n\n" +
               "📍 The Future of Engineering\n" +
               "⭐️ Innovations and advancements shaping the field of engineering.\n" +
               "🏷️ Domain: ENGINEERING | Budget: MODERATE | Category: LIMITED";
    }

    
    /**
     * Helper method to get topics based on preference
     */
    private String getTopicsByPreference(String theme, String budget, String category) {
        // We'll return some hardcoded results based on the preferences
        if (theme != null && theme.equals(MEDICINE)) {
            return "Here are some MEDICINE topics for you:\n\n" +
               "📍 Pediatric Medicine\n" +
               "⭐️ Focused on the health and well-being of infants, children, and adolescents.\n" +
               "🏷️ Domain: MEDICINE | Budget: MODERATE | Category: TIMELESS\n\n";
        } else if (theme != null && theme.equals(AI)) {
            return "Here are some AI topics for you:\n\n" +
               "📍 AI in Humanities\n" +
               "⭐️ Exploring the intersection of artificial intelligence and the humanities.\n" +
               "🏷️ Domain: CULTURAL | Budget: MODERATE | Category: HOT\n\n";
        } else if (budget != null && budget.equals(PREMIUM)) {
            return "Here are some PREMIUM topics for you:\n\n" +
               "📍 The Future of Engineering\n" +
               "⭐️ Innovations and advancements shaping the field of engineering.\n" +
               "🏷️ Domain: ENGINEERING | Budget: MODERATE | Category: LIMITED";
        } else {
            return getAllTopics();
        }
    }
}