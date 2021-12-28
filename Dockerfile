FROM node:14-alpine AS build

WORKDIR /app
COPY . /app

RUN set -ex \
  # Build JS-Application
  && npm install --production \
  # Correct User's file access
  && chown -R node:node /app

FROM node:14-alpine AS final
WORKDIR /app
COPY --from=build /app /app
ENV HTTP_PORT=8080
EXPOSE $HTTP_PORT
USER 1000
CMD ["node", "./index.js"]
