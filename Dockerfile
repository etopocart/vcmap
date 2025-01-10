FROM node:latest AS builder

WORKDIR /app

COPY package.json package.json

RUN npm install

COPY . .

RUN npm run install-plugins

RUN npm run build

RUN npm run build-preview

FROM nginx:stable-alpine as production-stage
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]