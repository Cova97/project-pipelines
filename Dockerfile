# Use the official Node.js image as the base image
FROM node:24-slim

# Directorio de trabajo en el contenedor
WORKDIR /app

# Copia los archivos de dependencias
COPY package*.json ./

# Instala SOLO las dependencias de producción
RUN npm install --omit=dev

# Copia el código ya compilado y el schema de prisma
# (Esto asume que ya ejecutaste 'npm run build' localmente)
COPY ./dist ./dist
COPY ./prisma ./prisma

# Expone el puerto que usa la aplicación
EXPOSE 3000

# El comando para iniciar la aplicación
CMD ["node", "dist/main"]