# ---- Etapa 1: Builder ----
# Aquí instalamos dependencias y construimos el proyecto
FROM node:18-alpine AS builder

WORKDIR /app

# Copia los archivos de dependencias e instala
COPY package*.json ./
RUN npm install

# Copia el resto del código fuente
COPY . .

# Genera el cliente de Prisma
RUN npx prisma generate

# Construye la aplicación para producción
RUN npm run build

# ---- Etapa 2: Production ----
# Aquí creamos la imagen final con solo lo necesario para correr
FROM node:18-alpine

WORKDIR /app

# Copia las dependencias de producción desde la etapa 'builder'
COPY --from=builder /app/package*.json ./
RUN npm install --omit=dev

# Copia la aplicación compilada desde la etapa 'builder'
COPY --from=builder /app/dist ./dist

# Copia el schema de Prisma (necesario para migraciones en producción)
COPY --from=builder /app/prisma ./prisma

EXPOSE 3000

# El comando para iniciar la aplicación
CMD ["node", "dist/main"]