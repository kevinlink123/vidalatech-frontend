# Multi-stage build para Astro
FROM node:lts-slim AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN yarn build

FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html

# Copiamos template de nginx
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

# El entrypoint de nginx:alpine procesa el template automáticamente
# reemplazando las variables de entorno
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]