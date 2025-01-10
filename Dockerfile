FROM node:latest AS builder

WORKDIR /app

COPY package.json package.json

RUN npm install

COPY . .

RUN npm run install-plugins

RUN npm run build

RUN npm run build-preview

FROM node:latest AS server

WORKDIR /app

COPY --from=builder /app/dist /app/

RUN npm install -g http-server

EXPOSE 8080

CMD ["http-server", "/dist"]