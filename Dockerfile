FROM node:22-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY index.html tsconfig.json vite.config.ts ./
COPY src ./src
COPY public ./public
RUN npm run build

FROM node:22-alpine AS runtime
ENV NODE_ENV=production PORT=3000
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --omit=dev && mkdir -p data public/images/uploads && chown -R node:node /app
COPY --from=builder --chown=node:node /app/dist ./dist
COPY --chown=node:node server ./server
USER node
EXPOSE 3000
VOLUME ["/app/data", "/app/public/images/uploads"]
CMD ["node", "server/index.js", "--production"]
