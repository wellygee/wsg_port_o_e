## MCP Host

This package represents the MCP (Model Context Protocol). It contains the following MCP Clients:
- **Echo MCP**: This tool echoes back any received input and is used as an example.
- **Customer Query**: This tool handles customer queries and provides relevant information.
- **Topic Recommendation**: This tool recommends topic recommendations based on user preferences.
- **Research Planning**: This tool creates detailed research plan based on user preferences.


# Test

```bash
npx @modelcontextprotocol/inspector node build/index.js

api                   -> 4000
customer-query        -> 5001
echo-ping             -> 5007
research-planning     -> 5003
topic-recommendation  -> 5002
```

# -------------------------------------------- Sample runs - excercise the different servers / tools + gain more context from external sources -------------------

# missing context
```bash
 curl -X POST localhost:4000/api/chat -H 'Content-Type: application/json' --header 'Content-type: application/json' --data '{    "message": "What are you able to assist with?",    "tools": [{"id": "echo-ping" }]}'
 ```

# more context from additional agent
 ```bash
 curl -X POST localhost:4000/api/chat -H 'Content-Type: application/json' --header 'Content-type: application/json' --data '{    "message": "What are you able to assist with?",    "tools": [{"id": "customer-query" }, {"id": "echo-ping" }]}'
 ```

``` bash
curl -X POST localhost:4000/api/chat -H 'Content-Type: application/json' --header 'Content-type: application/json' --data '{ "message": "I need help coming up with research plan. Something in Medicine Cancer related and maybe after the year 2024. Please include some price guides.", "tools": [{ "id": "customer-query" }, { "id": "echo-ping" }, { "id": "research-planning" }, {"id": "topic-recommendation" }]}'
```
