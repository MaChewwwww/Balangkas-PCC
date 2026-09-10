FROM node:22-bookworm-slim
WORKDIR /toolchain
RUN npm install --global pnpm@10.30.2
COPY frontend/package.json frontend/pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile --ignore-scripts
CMD ["node", "--version"]
