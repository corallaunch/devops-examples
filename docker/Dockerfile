# syntax=docker/dockerfile:1
# Small, non root image. Add an "npm ci" build stage when the app has dependencies.
FROM node:22-alpine
ENV NODE_ENV=production PORT=8080
WORKDIR /app
COPY app/package.json app/server.js ./
USER node
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s \
  CMD wget -qO- http://127.0.0.1:8080/health || exit 1
CMD ["node", "server.js"]
