# Multi-stage build for production
FROM node:18-alpine AS builder

# Install build dependencies
RUN apk add --no-cache python3 make g++

WORKDIR /app

# Copy package files
COPY backend/package*.json ./backend/
COPY package*.json ./

# Install dependencies
RUN cd backend && npm ci --only=production

# Production stage
FROM node:18-alpine AS production

# Install runtime dependencies
RUN apk add --no-cache sqlite

WORKDIR /app

# Copy built application
COPY --from=builder /app/backend/node_modules ./backend/node_modules
COPY backend/ ./backend/
COPY dining.db ./dining.db

# Create data directory for persistent storage
RUN mkdir -p /app/data && \
    mkdir -p /app/backups && \
    chown -R node:node /app

# Switch to non-root user
USER node

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/health', (res) => { process.exit(res.statusCode === 200 ? 0 : 1) })"

EXPOSE 3000

CMD ["node", "backend/server-sqlite.js"]