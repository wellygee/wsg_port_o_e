# Steps

- npm
- npm install -g typescript
- npm install -g lite-server
- npm install -g ts-node

## Configure

- script.ts
- package.json
- tsconfig.json

```bash
npm init
npm install
tsc -init
```

### Run
option 1. 
    -> start server : npm run start
    -> compile + run : npm run compile / watch needs server + browser
option 2. 
-> npx ts-node script.ts .. no need for server
