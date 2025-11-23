@echo off
chcp 65001 >nul
echo ========================================
echo   本地服务器启动脚本
echo ========================================
echo.

cd /d "%~dp0"

REM 设置 Python 路径
set PYTHON_PATH=
set PYTHON_CMD=

REM 检查 Python 是否在 PATH 中
python --version >nul 2>&1
if %errorlevel% == 0 (
    set PYTHON_CMD=python
    goto :found
)

REM 检查常见安装路径
if exist "C:\Program Files\Python312\python.exe" (
    set PYTHON_CMD="C:\Program Files\Python312\python.exe"
    goto :found
)

if exist "C:\Program Files\Python311\python.exe" (
    set PYTHON_CMD="C:\Program Files\Python311\python.exe"
    goto :found
)

if exist "C:\Program Files\Python310\python.exe" (
    set PYTHON_CMD="C:\Program Files\Python310\python.exe"
    goto :found
)

if exist "C:\Users\Admin\AppData\Local\Programs\Python\Python312\python.exe" (
    set PYTHON_CMD="C:\Users\Admin\AppData\Local\Programs\Python\Python312\python.exe"
    goto :found
)

REM 如果没有找到 Python
echo [错误] 未检测到 Python！
echo.
echo 请选择以下方法之一：
echo.
echo 方法一：安装 Python（推荐）
echo   1. 访问: https://www.python.org/downloads/
echo   2. 下载并安装 Python（安装时勾选 "Add Python to PATH"）
echo   3. 重新运行此脚本
echo.
echo 方法二：使用 Node.js
echo   1. 访问: https://nodejs.org/
echo   2. 安装 Node.js 后运行: npm install -g http-server
echo   3. 运行: http-server -p 8080
echo.
echo 方法三：使用 VS Code Live Server
echo   安装 Live Server 插件，右键打开 index.html
echo.
pause
exit /b

:found
echo [✓] 检测到 Python
echo.
echo 正在启动服务器...
echo 服务器地址: http://localhost:8080
echo.
echo 访问地址:
echo   主网站: http://localhost:8080/index.html
echo   管理后台: http://localhost:8080/admin-simple.html
echo.
echo 按 Ctrl+C 停止服务器
echo ========================================
echo.
start http://localhost:8080/index.html
%PYTHON_CMD% -m http.server 8080
