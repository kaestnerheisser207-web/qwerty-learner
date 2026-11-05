# Qwerty Learner - static build served by nginx
FROM node:20-alpine AS build

WORKDIR /app
ENV HUSKY=0

# Install dependencies first so Docker can cache this layer
COPY package.json yarn.lock .yarnrc ./
RUN corepack enable \
 && corepack prepare yarn@1.22.22 --activate \
 && yarn install --frozen-lockfile --network-timeout 600000

COPY . .
RUN yarn build

FROM nginx:1.27-alpine
COPY deploy/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s \
  CMD wget -qO- http://127.0.0.1/ >/dev/null 2>&1 || exit 1
