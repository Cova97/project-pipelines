# ---- Etapa 1: El Taller (Builder) ----
FROM node:24-slim AS builder
RUN apt-get update && apt-get upgrade -y && apt-get clean && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npx prisma generate
RUN npm run build

# ---- Etapa 2: El Producto Final (Production) ----
FROM node:24-slim
WORKDIR /app
COPY --from=builder /app/package*.json ./
RUN npm install --omit=dev

# --- ¡LA CORRECCIÓN ESTÁ AQUÍ! ---
# Copiamos explícitamente el cliente de Prisma ya generado para asegurar que esté disponible.
COPY --from=builder /app/node_modules/.prisma/client ./node_modules/.prisma/client

# Copia la aplicación compilada
COPY --from=builder /app/dist ./dist

# Copia el schema de Prisma
COPY --from=builder /app/prisma ./prisma

EXPOSE 3000

CMD ["node", "dist/main"]