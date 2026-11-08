# syntax=docker/dockerfile:1

FROM oven/bun:1.3.13-alpine@sha256:4de475389889577f346c636f956b42a5c31501b654664e9ae5726f94d7bb5349 AS build

WORKDIR /src

COPY package.json bun.lock ./
RUN bun install --frozen-lockfile

COPY esbuild.ts tsconfig.json ./
COPY src/ ./src/
COPY generated/ ./generated/
RUN bun run build

FROM node:24-alpine@sha256:a34ab6d7f6f4813f4d0c5469d74685604b962fbdbf5793a7bc7b4998ecb867c8

ARG VERSION=""
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.source="https://github.com/aaronkyriesenbach/jellarr"
LABEL org.opencontainers.image.licenses="AGPL-3.0-only"

ENV NODE_ENV=production

COPY --from=build /src/bundle.cjs /app/jellarr.cjs

USER node

ENTRYPOINT ["node", "/app/jellarr.cjs"]
