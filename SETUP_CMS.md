# CMS 系统配置说明

## ⚠️ 重要说明

由于 GitHub Pages 是静态网站托管，不支持服务器端功能。要使用完整的 Decap CMS（包括 Git Gateway），需要以下两种方案之一：

## 🔧 方案一：使用 Netlify 托管（推荐）

Netlify 提供免费的 Git Gateway 服务，可以完美支持 Decap CMS。

### 配置步骤：

1. **注册 Netlify 账号**
   - 访问 https://www.netlify.com/
   - 注册/登录账号

2. **导入 GitHub 仓库**
   - 点击 "Add new site" → "Import an existing project"
   - 选择 GitHub，授权访问你的仓库
   - 选择 `mangguo001/mg-portfolio` 仓库

3. **配置构建设置**
   - Build command: （留空）
   - Publish directory: `/` （根目录）

4. **启用 Identity 和 Git Gateway**
   - 进入 Site settings → Identity
   - 点击 "Enable Identity"
   - 进入 Settings → Identity → Services → Git Gateway
   - 点击 "Enable Git Gateway"
   - 选择 GitHub 账号授权

5. **更新网站地址**
   - Netlify 会提供一个新域名（如：`mg-portfolio.netlify.app`）
   - 或配置自定义域名

6. **访问管理后台**
   - 访问：`https://你的域名.netlify.app/admin/`
   - 注册/登录账号
   - 开始管理内容

### 优势：
- ✅ 免费
- ✅ 自动部署
- ✅ 支持 Git Gateway
- ✅ CDN 加速
- ✅ HTTPS 证书自动配置

## 🔧 方案二：GitHub OAuth（较复杂）

使用 GitHub OAuth 直接认证，无需 Netlify。

### 配置步骤：

1. **创建 GitHub OAuth App**
   - 访问 GitHub Settings → Developer settings → OAuth Apps
   - 点击 "New OAuth App"
   - 填写：
     - Application name: `MG Portfolio CMS`
     - Homepage URL: `https://mangguo001.github.io/mg-portfolio`
     - Authorization callback URL: `https://api.netlify.com/auth/done`
   - 创建后记录 Client ID 和 Client Secret

2. **更新 admin/config.yml**
   
   将 backend 配置修改为：
   
   ```yaml
   backend:
     name: github
     repo: mangguo001/mg-portfolio
     branch: main
     base_url: https://api.netlify.com
     auth_type: pkce
   ```

3. **配置环境变量**（如果使用 Netlify）
   - 在 Netlify 的 Environment variables 中添加：
     - `GITHUB_CLIENT_ID`: 你的 Client ID
     - `GITHUB_CLIENT_SECRET`: 你的 Client Secret

### 注意：
这个方案仍然建议使用 Netlify，因为 GitHub Pages 不支持服务器端功能。

## 🔧 方案三：简化版管理界面（无需后端）

如果不想使用 Netlify，可以创建一个纯前端的管理界面，直接编辑 JSON 文件。

### 实现方式：

1. 创建一个 `admin-simple.html` 页面
2. 提供可视化表单编辑 JSON 数据
3. 点击保存后，提示用户复制修改后的 JSON
4. 用户手动更新文件并推送到 Git

### 优缺点：

✅ 优点：
- 无需服务器
- 完全免费
- 简单易用

❌ 缺点：
- 需要手动提交到 Git
- 不能直接上传图片
- 功能有限

## 📋 当前实现状态

✅ 已完成：
- 数据文件结构（`_data/works.json`, `_data/settings.json`）
- CMS 配置文件（`admin/config.yml`）
- 管理后台页面（`admin/index.html`）
- 主页面从 JSON 加载数据
- 使用说明文档

⚠️ 待配置：
- Git Gateway 或 GitHub OAuth（需要 Netlify 或配置 OAuth）

## 🚀 快速开始（使用 Netlify）

1. **注册 Netlify 账号**
2. **导入 GitHub 仓库**
3. **启用 Identity 和 Git Gateway**
4. **访问管理后台**：`https://你的域名.netlify.app/admin/`
5. **开始管理内容**

详细步骤请参考 "方案一"。

## 🔍 验证配置

配置完成后，访问管理后台页面，你应该看到：
- 登录界面（首次访问）
- 登录后的管理界面（可以编辑作品和设置）
- 左侧菜单有 "作品管理" 和 "页面设置"

## 💡 提示

- 如果使用 Netlify，可以保留 GitHub Pages 作为备用
- 可以在 Netlify 和 GitHub Pages 上同时部署
- 修改内容后会自动提交到 GitHub 仓库
- GitHub Pages 会自动从仓库更新

## ❓ 问题反馈

如果遇到问题：
1. 检查浏览器控制台错误信息
2. 查看 Netlify 的 Identity 日志
3. 确认 Git Gateway 已启用
4. 检查 GitHub 仓库权限设置

