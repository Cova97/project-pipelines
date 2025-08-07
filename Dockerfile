# ---- Etapa 1: El Taller (Builder) ----
# Aquí se instala todo lo necesario y se construye la aplicación.
FROM node:18-alpine AS builder

WORKDIR /app

# Copia los archivos de dependencias e instala todo (incluido devDependencies)
COPY package*.json ./
RUN npm install

# Copia el resto del código fuente (src, prisma, etc.)
COPY . .

# Genera el cliente de Prisma
RUN npx prisma generate

# Construye la aplicación, creando la carpeta 'dist'
RUN npm run build

# ---- Etapa 2: El Producto Final (Production) ----
# Aquí se crea una imagen limpia solo con lo necesario para ejecutar la app.
FROM node:18-alpine

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