FROM node:16-buster as build
RUN apt-get update && \
  apt-get install -y \
  cmake \
  libcurl4-openssl-dev
RUN cd /home/node && npm install aws-lambda-ric


FROM node:16-alpine as lambda_ric
RUN apk add libidn2
RUN mkdir -p /home/node/app && chown -R node:node /home/node/app
RUN chown -R node: /home/node
USER node
WORKDIR /home/node
COPY --from=build /home/node/node_modules/aws-lambda-ric/bin aws-lambda-ric/bin
COPY --from=build /home/node/node_modules/aws-lambda-ric/lib aws-lambda-ric/lib
COPY --from=build /home/node/node_modules/aws-lambda-ric/build/Release/runtime-client.node aws-lambda-ric/build/Release/runtime-client.node
COPY --from=build /home/node/node_modules/aws-lambda-ric/package.json aws-lambda-ric/package.json
WORKDIR /home/node/app

ENTRYPOINT ["/usr/local/bin/npx", "/home/node/aws-lambda-ric/bin/index.js"]
