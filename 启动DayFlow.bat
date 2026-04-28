@echo off
chcp 65001 >nul
title DayFlow 启动器

:: 检测 Python
python --version >nul 2>&1
if errorlevel 1 (
    echo [错误] 未检测到 Python，请先安装 Python 3
    echo 下载地址：https://www.python.org/downloads/
    pause
    exit /b 1
)

:: 检测端口是否已被占用
netstat -an | find "0.0.0.0:8080" >nul 2>&1
if not errorlevel 1 (
    echo [提示] 端口 8080 已在运行，直接打开浏览器...
    start http://localhost:8080/DayFlow.html
    exit /b 0
)

:: 启动本地服务器（后台运行）
echo [启动] DayFlow 本地服务器...
start /b python -m http.server 8080 --directory "%~dp0"

:: 等待服务器就绪
timeout /t 1 /nobreak >nul

:: 打开浏览器
echo [打开] http://localhost:8080/DayFlow.html
start http://localhost:8080/DayFlow.html

echo.
echo DayFlow 已启动，可以关闭此窗口。
echo 服务器将在后台继续运行，关闭电脑后自动停止。
timeout /t 3 /nobreak >nul
