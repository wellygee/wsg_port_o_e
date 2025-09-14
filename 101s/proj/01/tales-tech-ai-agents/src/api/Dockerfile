FROM node:22.12-alpine AS builder

RUN apk add --update python3 make g++ curl\
   && rm -rf /var/cache/apk/*

WORKDIR /app

COPY src /app/src
COPY ./package*.json ./
COPY tsconfig.json ./tsconfig.json

RUN --mount=type=cache,target=/root/.npm npm install
RUN npm run build

FROM node:22-alpine AS release

RUN apk add --update curl

WORKDIR /app

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./

ENV NODE_ENV=production
EXPOSE 4000

RUN npm ci --ignore-scripts --omit-dev

CMD ["node", "dist/index.js"]