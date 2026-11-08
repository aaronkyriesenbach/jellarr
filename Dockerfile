# syntax=docker/dockerfile:1

FROM node:24-alpine@sha256:a34ab6d7f6f4813f4d0c5469d74685604b962fbdbf5793a7bc7b4998ecb867c8 AS build

WORKDIR /src

RUN npm install --global pnpm@10

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
RUN pnpm install --frozen-lockfile

COPY esbuild.ts tsconfig.json ./
COPY src/ ./src/
COPY generated/ ./generated/
RUN pnpm build

FROM node:24-alpine@sha256:a34ab6d7f6f4813f4d0c5469d74685604b962fbdbf5793a7bc7b4998ecb867c8

ARG VERSION=""
LABEL org.opencontainers.image.version="${VERSION}"

ENV NODE_ENV=production

COPY --from=build /src/bundle.cjs /app/jellarr.cjs

USER node

ENTRYPOINT ["node", "/app/jellarr.cjs"]
