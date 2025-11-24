@echo off
chcp 65001 >nul
echo ========================================
echo 🚀 七牛云文件上传工具
echo ========================================
echo.

REM 检查 Python 是否安装
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ 未检测到 Python，请先安装 Python 3.6+
    echo.
    echo 下载地址: https://www.python.org/downloads/
    pause
    exit /b 1
)

echo ✅ Python 已安装
echo.

REM 检查 qiniu 库是否安装
python -c "import qiniu" >nul 2>&1
if errorlevel 1 (
    echo 📦 正在安装 qiniu 库...
    pip install qiniu
    if errorlevel 1 (
        echo ❌ 安装 qiniu 库失败，请手动运行: pip install qiniu
        pause
        exit /b 1
    )
    echo ✅ qiniu 库安装成功
    echo.
)

REM 检查配置文件
if not exist "qiniu-config.json" (
    echo ❌ 配置文件 qiniu-config.json 不存在
    echo 请先创建配置文件
    pause
    exit /b 1
)

echo 📋 开始上传文件...
echo.

REM 运行上传脚本
python upload-to-qiniu.py

echo.
pause


