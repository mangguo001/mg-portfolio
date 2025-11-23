@echo off
chcp 65001 >nul
echo ========================================
echo    GitHub 推送工具
echo ========================================
echo.

cd /d "C:\Users\Admin\Desktop\MGgh"

echo [1/4] 检查 Git 状态...
git status
echo.

set /p commit_msg="请输入提交信息 (例如: 添加新作品 / 修复问题): "

if "%commit_msg%"=="" (
    echo.
    echo 错误: 提交信息不能为空！
    echo 请重新运行并输入提交信息。
    echo.
    pause
    exit /b
)

echo.
echo [2/4] 添加所有修改的文件...
git add .
echo.

echo [3/4] 提交更改...
git commit -m "%commit_msg%"
if errorlevel 1 (
    echo.
    echo 警告: 提交失败，可能没有需要提交的更改。
    echo.
    pause
    exit /b
)
echo.

echo [4/4] 推送到 GitHub...
git push
if errorlevel 1 (
    echo.
    echo 错误: 推送失败，请检查网络连接或 Git 配置。
    echo.
    pause
    exit /b
)
echo.

echo ========================================
echo    推送完成！
echo ========================================
echo.
echo 网站将在 1-2 分钟内自动更新:
echo https://mangguo001.github.io/mg-portfolio/
echo.
echo 你可以稍后在浏览器中访问查看更新。
echo.
pause

