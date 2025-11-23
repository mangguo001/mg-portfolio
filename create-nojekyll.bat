@echo off
chcp 65001 >nul
echo ========================================
echo   创建 .nojekyll 文件
echo ========================================
echo.

cd /d "%~dp0"

echo 正在创建 .nojekyll 文件...

REM 尝试多种方法创建文件
if exist .nojekyll (
    echo [✓] .nojekyll 文件已存在
) else (
    REM 方法1: 使用 type nul
    type nul > .nojekyll 2>nul
    if exist .nojekyll (
        echo [✓] 使用 type nul 创建成功
        goto :add
    )
    
    REM 方法2: 使用 echo
    echo. > .nojekyll 2>nul
    if exist .nojekyll (
        echo [✓] 使用 echo 创建成功
        goto :add
    )
    
    REM 方法3: 使用 copy con
    echo 创建文件失败，请手动创建：
    echo 1. 在项目根目录创建新文件
    echo 2. 文件名为: .nojekyll (注意前面有点)
    echo 3. 文件内容留空
    echo 4. 保存文件
    pause
    exit /b
)

:add
echo.
echo 正在添加到 Git...
git add -f .nojekyll
if %errorlevel% == 0 (
    echo [✓] 文件已添加到 Git
    echo.
    echo 请运行以下命令提交并推送：
    echo   git commit -m "添加 .nojekyll 文件以支持 _data 文件夹"
    echo   git push
    echo.
    echo 或者使用 push.bat 进行推送
) else (
    echo [×] 添加到 Git 失败
)

echo.
pause

