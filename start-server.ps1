# PowerShell 版本的启动脚本
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   本地服务器启动脚本" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 切换到脚本所在目录
Set-Location $PSScriptRoot

Write-Host "正在启动本地服务器..." -ForegroundColor Green
Write-Host "服务器地址: http://localhost:8080" -ForegroundColor Yellow
Write-Host ""
Write-Host "访问地址:" -ForegroundColor Yellow
Write-Host "  主网站: http://localhost:8080/index.html" -ForegroundColor White
Write-Host "  管理后台: http://localhost:8080/admin-simple.html" -ForegroundColor White
Write-Host ""
Write-Host "按 Ctrl+C 停止服务器" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 检查 Python
try {
    $pythonVersion = python --version 2>&1
    Write-Host "使用 Python 启动服务器..." -ForegroundColor Green
    Write-Host ""
    Start-Process "http://localhost:8080/index.html"
    python -m http.server 8080
} catch {
    Write-Host "[错误] 未检测到 Python！" -ForegroundColor Red
    Write-Host ""
    Write-Host "请安装 Python 或使用以下方法之一："
    Write-Host "1. 安装 Python: https://www.python.org/downloads/"
    Write-Host "2. 使用 Node.js: npm install -g http-server 然后运行 http-server -p 8080"
    Write-Host "3. 使用 VS Code 的 Live Server 插件"
    Write-Host ""
    Read-Host "按 Enter 键退出"
}
