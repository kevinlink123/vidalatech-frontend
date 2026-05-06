# Multi-stage build para Astro
FROM node:lts-slim AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .

# Recibir argumentos de build
ARG PUBLIC_BACKEND_URL

# Pasarlos como variables de entorno para el build de Astro
ENV PUBLIC_BACKEND_URL=${PUBLIC_BACKEND_URL}

RUN yarn build

FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html

# Copiamos template de nginx
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

# El entrypoint de nginx:alpine procesa el template automáticamente
# reemplazando las variables de entorno
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]