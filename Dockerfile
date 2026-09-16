# -------------------------------------------------------------
# Stage 1: Build & Dependency Resolution
# -------------------------------------------------------------
FROM node:18-alpine AS dependencies

WORKDIR /app

# Metadata labels (Compliance & Auditing)
LABEL maintainer="devops-team"
LABEL environment="production"
LABEL app="node-web-service"

# Dependency manifests copy karein
COPY package*.json ./

# Production packages ka clean install + cache wipe out
RUN npm install --only=production && npm cache clean --force

# -------------------------------------------------------------
# Stage 2: Minimal Production Runtime
# -------------------------------------------------------------
FROM node:18-alpine AS runner

WORKDIR /app

# Standard environment variables
ENV NODE_ENV=production
ENV PORT=3000

# Healthcheck utility install karein (curl)
RUN apk --no-cache add curl

# Security: Non-root dedicated user & group create karein
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Stage 1 se resolved node_modules aur code pull karein
COPY --from=dependencies /app/node_modules ./node_modules
COPY package*.json ./
COPY index.js ./
COPY public ./public

# Directory permissions non-root user ko hand over karein
RUN chown -R appuser:appgroup /app

# Non-root user par switch karein (Least Privilege Principle)
USER appuser

EXPOSE 3000

# Health monitoring: Agar 3 dafa response na mila toh container UNHEALTHY mark hoga
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

CMD ["npm", "start"]