# ---- Etapa 1: El Taller (Builder) ----
# Usamos la imagen 'slim' (basada en Debian) para evitar problemas de compatibilidad con Prisma.
FROM node:24-slim AS builder

# Actualizamos los paquetes del sistema operativo base por seguridad.
RUN apt-get update && apt-get upgrade -y && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copia los archivos de dependencias e instala todo (incluido devDependencies)
COPY package*.json ./
RUN npm install

# Copia el resto del código fuente
COPY . .

# Genera el cliente de Prisma (ahora compatible con el entorno final)
RUN npx prisma generate

# Construye la aplicación, creando la carpeta 'dist'
RUN npm run build

# ---- Etapa 2: El Producto Final (Production) ----
# Empezamos de nuevo con una imagen 'slim' limpia para la producción.
FROM node:24-slim

WORKDIR /app

# Copia los archivos de dependencias
COPY --from=builder /app/package*.json ./
# Instala SOLO las dependencias de producción
RUN npm install --omit=dev

# Copia la carpeta 'dist' ya compilada desde la etapa 'builder'
COPY --from=builder /app/dist ./dist

# Copia el schema de Prisma
COPY --from=builder /app/prisma ./prisma

# Expone el puerto que usa la aplicación
EXPOSE 3000

# El comando para iniciar la aplicación
CMD ["node", "dist/main"]