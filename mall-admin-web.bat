chcp 65001
@echo off
set COMPOSE_FILE=docker-compose.yml
set SERVICE_NAME=web-mall-admin

@REM docker build -t %COMPOSE_FILE%:1.0 .
@REM docker login -u admin -p admin 127.0.0.1:5000
@REM docker tag %COMPOSE_FILE%:1.0 127.0.0.1:5000/%COMPOSE_FILE%:1.0
@REM docker push 127.0.0.1:5000/%COMPOSE_FILE%:1.0

echo 正在停止 %SERVICE_NAME% 服务...
docker-compose -f %COMPOSE_FILE% stop %SERVICE_NAME%

echo 正在删除 %SERVICE_NAME% 服务的容器...
docker-compose -f %COMPOSE_FILE% rm -f --stop %SERVICE_NAME%

@REM docker login -u admin -p admin 127.0.0.1:5000

echo 正在拉取 %SERVICE_NAME% 服务的最新镜像...
docker-compose -f %COMPOSE_FILE% pull %SERVICE_NAME%

echo 正在启动 %SERVICE_NAME% 服务...
docker-compose -f %COMPOSE_FILE% up -d %SERVICE_NAME%

echo %SERVICE_NAME% 服务已重新部署完成。

echo ----start container----
