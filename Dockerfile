# Multi-stage build para Astro
FROM node:lts-slim AS builder
# Activar yarn moderno
RUN npm install -g corepack

WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --immutable-cache
COPY . .

# Recibir argumentos de build
ARG PUBLIC_BACKEND_URL
ARG PUBLIC_UMAMI_WEBSITE_ID
ARG PUBLIC_UMAMI_SCRIPT_URL

# Pasarlos como variables de entorno para el build de Astro
ENV PUBLIC_BACKEND_URL=${PUBLIC_BACKEND_URL}
ENV PUBLIC_UMAMI_WEBSITE_ID=${PUBLIC_UMAMI_WEBSITE_ID}
ENV PUBLIC_UMAMI_SCRIPT_URL=${PUBLIC_UMAMI_SCRIPT_URL}

RUN yarn build

FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html

# Copiamos template de nginx
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

# El entrypoint de nginx:alpine procesa el template automáticamente
# reemplazando las variables de entorno
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]