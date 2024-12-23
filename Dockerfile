# 使用官方 Node.js LTS Alpine 作为基础镜像
FROM node:lts-alpine

# 安装 tini (进程管理工具)
RUN apk add --no-cache tini

# 设置环境变量
ENV NODE_ENV=production

# 设置工作目录为 /app
WORKDIR /app

# 先使用 root 用户复制文件，并设置文件权限
COPY . ./

# 使用 root 用户执行 chmod 命令，确保 /app 目录的权限正确
RUN chmod -R 755 /app

# 切换到 node 用户运行应用
USER node

# 安装依赖
RUN yarn --network-timeout=100000

# 暴露容器内的 3000 端口
EXPOSE 3000

# 使用 tini 作为进程管理工具来启动应用
CMD ["/sbin/tini", "--", "node", "app.js"]
