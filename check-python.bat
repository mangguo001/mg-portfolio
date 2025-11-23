@echo off
chcp 65001 >nul
echo ========================================
echo   检查 Python 安装状态
echo ========================================
echo.

echo 方法一：检查系统 PATH 中的 Python...
python --version 2>nul
if %errorlevel% == 0 (
    echo [✓] Python 已安装并配置到 PATH
    python --version
    echo.
    echo Python 可以使用了！您可以运行 start-server.bat 启动本地服务器。
    goto :end
)

echo [×] 未在 PATH 中找到 Python
echo.

echo 方法二：检查常见安装路径...
if exist "C:\Program Files\Python312\python.exe" (
    echo [✓] 找到 Python 安装: C:\Program Files\Python312\
    "C:\Program Files\Python312\python.exe" --version
    echo.
    echo 注意: Python 已安装但未添加到 PATH
    echo 建议: 重新运行安装程序并勾选 "Add Python to PATH"
    goto :end
)

if exist "C:\Users\Admin\AppData\Local\Programs\Python\Python312\python.exe" (
    echo [✓] 找到 Python 安装: C:\Users\Admin\AppData\Local\Programs\Python\Python312\
    "C:\Users\Admin\AppData\Local\Programs\Python\Python312\python.exe" --version
    echo.
    echo 注意: Python 已安装但未添加到 PATH
    echo 建议: 重新运行安装程序并勾选 "Add Python to PATH"
    goto :end
)

echo [×] 未找到 Python 安装
echo.
echo Python 安装程序可能还在运行，或者安装失败。
echo.
echo 请选择：
echo 1. 手动运行安装程序: python-installer.exe
echo 2. 确保勾选 "Add Python to PATH" 选项
echo 3. 安装完成后重新运行此脚本检查

:end
echo.
pause
