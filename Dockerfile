# Etapa de construcción
FROM node:20 AS build
WORKDIR /app

# Copiar dependencias y instalarlas
COPY package*.json ./
RUN npm install

# Copiar todo el código del proyecto
COPY . .

# Compilar (Vite/React convierte TS -> JS)
RUN npm run build

# Etapa de producción con Nginx
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
