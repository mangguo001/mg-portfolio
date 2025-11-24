@echo off
chcp 65001 >nul
echo ========================================
echo 🚀 GitHub Pages + 七牛云 一键部署
echo ========================================
echo.

REM 设置路径（动态获取）
set DEPLOY_DIR=%~dp0
set ROOT_DIR=%DEPLOY_DIR%..

REM 检查 Git 是否安装
git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ 未检测到 Git，请先安装 Git 并加入 PATH
    echo 下载地址: https://git-scm.com/downloads
    pause
    exit /b 1
)
echo ✅ Git 已安装
echo.

REM 检查源文件是否存在
if not exist "%DEPLOY_DIR%\index.html" (
    echo ❌ 找不到 %DEPLOY_DIR%\index.html
    echo 请确认 deploy 文件夹位于 %ROOT_DIR% 下
    pause
    exit /b 1
)

REM 切换到项目根目录
cd /d "%ROOT_DIR%"

echo [1/4] 复制文件到仓库根目录...
copy /Y "%DEPLOY_DIR%\index.html" "%ROOT_DIR%\index.html" >nul
if errorlevel 1 (
    echo ❌ 复制 index.html 失败，请检查权限
    pause
    exit /b 1
)

REM 复制 admin 文件夹（可选）
if exist "%DEPLOY_DIR%\admin" (
    xcopy "%DEPLOY_DIR%\admin" "%ROOT_DIR%\admin\" /E /Y /I >nul
    echo ✅ admin 文件夹已更新
)

echo ✅ 文件复制完成
echo.

REM 询问是否运行七牛云上传脚本
choice /M "是否同时上传资源到七牛云？"
if errorlevel 2 (
    echo ⏭️  跳过七牛云上传
) else (
    echo [可选] 运行七牛云上传脚本...
    cd /d "%DEPLOY_DIR%"
    call upload-assets.bat
    cd /d "%ROOT_DIR%"
)
echo.

REM 输入提交信息
set /p commit_msg="请输入提交信息 (例如: 更新网站内容): "
if "%commit_msg%"=="" (
    set commit_msg=更新网站
)

echo [2/4] 添加文件...
git add .
if errorlevel 1 (
    echo ❌ git add 失败，请检查 Git 状态
    pause
    exit /b 1
)

echo [3/4] 提交更改...
git commit -m "%commit_msg%"
if errorlevel 1 (
    echo ⚠️  提交失败，可能没有需要提交的更改
    pause
    exit /b 1
)

echo [4/4] 推送到 GitHub...
git push
if errorlevel 1 (
    echo ❌ 推送失败，请检查网络或 Git 配置
    pause
    exit /b 1
)

echo.
echo ========================================
echo ✅ 部署完成！
echo ========================================
echo GitHub Pages 地址:
echo https://mangguo001.github.io/mg-portfolio/
echo.
echo 如需生效，请等待 1-2 分钟再刷新页面。
echo ========================================
echo.
pause


