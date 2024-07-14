# 第一阶段：node镜像打包
FROM node:12.0-slim AS frontend-builder
WORKDIR /build-app
COPY . .
RUN npm install -g yarn
RUN yarn install
RUN npm run build:dev

# 第二阶段：nginx打包
FROM nginx:stable-alpine
EXPOSE 80
WORKDIR /app
# 替换nginx配置
#COPY config/nginx.conf /etc/nginx/conf.d/default.conf
# 将第一阶段的静态文件复制到nginx中
RUN rm -rf /usr/share/nginx/html
RUN mkdir /usr/share/nginx/html
COPY --from=frontend-builder /build-app/dist /usr/share/nginx/html

# 运行
CMD ["nginx", "-g", "daemon off;"]
