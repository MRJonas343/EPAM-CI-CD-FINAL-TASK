# Base image
FROM oven/bun:1-alpine AS base
WORKDIR /usr/src/app

# Step: install production dependencies
FROM base AS deps
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile --production

# Step: copy source code & build
FROM base AS build
COPY --from=deps /usr/src/app/node_modules node_modules
COPY . .
ENV NODE_ENV=production
RUN bun run build

# Final image
FROM oven/bun:1-alpine AS release
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/node_modules node_modules
COPY --from=build /usr/src/app/src ./src
COPY --from=build /usr/src/app/package.json ./

# Run as non-root
USER bun
EXPOSE 3000/tcp
ENTRYPOINT ["bun", "run", "start"]
