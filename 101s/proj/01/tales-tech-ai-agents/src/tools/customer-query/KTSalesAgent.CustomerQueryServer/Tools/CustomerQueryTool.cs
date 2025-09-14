using System.ComponentModel;

using KTSalesAgent.CustomerQueryServer.Models;

using ModelContextProtocol.Server;

namespace KTSalesAgent.CustomerQueryServer.Tools;

[McpServerToolType]
public class CustomerQueryTool(ILogger<CustomerQueryTool> logger)
{
    private static readonly string[] emotions = [ "happy", "sad", "angry", "neutral" ];
    private static readonly string[] intents = [ "get_topic_recommendation", "get_research_area", "inquire", "compile_research_bundle" ];
    private static readonly string[] requirements = [ "research_level", "research_area", "research_topic", "domain", "theme" ];
    private static readonly string[] preferences = [ "medicine", "engineering", "ai", "hot", "space", "time travel" ];
    private static readonly Random random = Random.Shared;

    [McpServerTool(Name = "analyze_customer_query", Title = "Analyze Customer Query")]
    [Description("Analyzes the customer query and provides a response.")]
    public async Task<CustomerQueryAnalysisResult> AnalyzeCustomerQueryAsync(
        [Description("The customer query to analyze")] string customerQuery)
    {
        // Simulate some processing time
        await Task.Delay(1000);

        // Log the received customer query
        logger.LogInformation("Received customer query: {customerQuery}", customerQuery);

        // Return a simple response for demonstration purposes
        var result = new CustomerQueryAnalysisResult
        {
            CustomerQuery = customerQuery,
            Emotion = emotions[random.Next(emotions.Length)],
            Intent = intents[random.Next(intents.Length)],
            Requirements = requirements[random.Next(requirements.Length)],
            Preferences = preferences[random.Next(preferences.Length)]
        };

        return result;
    }
}
