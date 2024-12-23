FROM node:lts-alpine

RUN apk add --no-cache tini

ENV NODE_ENV production

USER node

WORKDIR /app

# 复制文件并确保正确的权限
COPY --chown=node:node . ./

# 修复权限，确保 node 用户能够访问 /app 目录
RUN chmod -R 755 /app

RUN yarn --network-timeout=100000

EXPOSE 3000

CMD [ "/sbin/tini", "--", "node", "app.js" ]
