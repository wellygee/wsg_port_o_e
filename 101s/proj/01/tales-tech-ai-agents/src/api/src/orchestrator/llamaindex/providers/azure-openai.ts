import { openai } from "llamaindex";

export const llm = async () => {
  console.log("Using Azure OpenAI");
  return openai({
    azure: {
      apiKey: process.env.AZURE_OPENAI_KEY,
      endpoint: process.env.AZURE_OPENAI_ENDPOINT,
      deployment: process.env.AZURE_DEPLOYMENT,
      apiVersion: process.env.AZURE_OPENAI_DEPLOYMENT_NAME
    },
  });
};
