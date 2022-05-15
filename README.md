# lambda-ric-node

A minimal AWS Lambda Node.js container runtime.

Based on the `node:16-alpine` Docker image. Includes `aws-lambda-ric` at `/home/node/aws-lambda-ric`.

## Example usage

Dockerfile

```Dockerfile
FROM ghcr.io/brymastr/lambda-ric-node:latest as base
WORKDIR /home/node/app/functions/my-lambda-function
COPY . ./
RUN npm ci --production --silent
CMD ["app.handler"]
```
