# 七牛云 CDN 部署说明

## 📋 概述

本部署版本已配置七牛云 CDN 支持，可以显著提升国内访问速度。

## 🚀 快速开始

### 第一步：上传文件到七牛云

1. **检查配置**
   - 确认 `qiniu-config.json` 中的配置信息正确
   - 已包含你的 AccessKey、SecretKey、存储空间名称和区域代码

2. **运行上传脚本**
   ```bash
   # 方式一：双击运行
   upload-assets.bat
   
   # 方式二：命令行运行
   python upload-to-qiniu.py
   ```

3. **等待上传完成**
   - 脚本会自动上传：
     - `index.html`（网站入口文件）
     - `assets/` 文件夹（图片、视频等静态资源）
     - `_data/` 文件夹（JSON 数据）
   - 保持原有的文件夹结构

### 第二步：获取 CDN 域名

1. **登录七牛云控制台**
   - 访问：https://portal.qiniu.com/

2. **获取域名**
   - 方式 A（测试用）：使用默认测试域名
     - 进入对象存储 → 选择空间 `mg-portfolio-assets`
     - 空间设置 → 域名管理 → 默认域名
     - 格式：`https://mg-portfolio-assets.bkt.clouddn.com/`
     - ⚠️ 注意：测试域名有有效期限制
   
   - 方式 B（正式用）：绑定自定义域名（推荐）
     - 需要域名已备案
     - 空间设置 → 域名管理 → 添加域名
     - 绑定后使用自定义域名
     - 格式：`https://assets.yourdomain.com/`

### 第三步：配置 CDN 域名

1. **打开 `deploy/index.html`**

2. **找到 CDN 配置部分**（约第 3152 行）

3. **更新域名**
   ```javascript
   qiniuCDNBase: 'https://你的七牛云域名.com/',  // 替换为你的实际域名
   ```
   
   例如：
   ```javascript
   qiniuCDNBase: 'https://mg-portfolio-assets.bkt.clouddn.com/',
   ```
   
   ⚠️ **重要**：域名末尾必须带斜杠 `/`

4. **保存文件**

### 第四步：部署到 GitHub Pages（推荐）

> 目的：把 `index.html` 托管到 GitHub Pages，资源仍然由七牛云 CDN 加速，国内访问速度快且无需备案。

1. **运行一键脚本**
   - 双击 `deploy/一键部署.bat`（或 `deploy/deploy-to-github.bat`）
   - 按提示输入提交信息即可
   - 脚本会自动：
     - 将 `deploy/index.html`（及 `admin/`）复制到仓库根目录
     - 可选地运行 `upload-assets.bat` 上传七牛云资源
     - `git add` → `git commit` → `git push`

2. **等待 GitHub Pages 自动部署**
   - 通常 1-2 分钟
   - 访问地址：`https://mangguo001.github.io/mg-portfolio/`
   - 页面中的图片/视频/JSON 将自动从七牛云 CDN 加载

### 第五步：测试

1. **本地测试**
   - 在 `deploy` 文件夹中打开 `index.html`
   - 检查浏览器控制台，确认资源从七牛云 CDN 加载

2. **GitHub Pages 访问**
   - 访问 `https://mangguo001.github.io/mg-portfolio/`
   - 打开开发者工具 → Network → 检查资源是否来自 `t67uxf1bp.hd-bkt.clouddn.com`

## 📁 文件结构

```
deploy/
├── index.html              # 主文件（已配置七牛云 CDN）
├── assets/                 # 资源文件
├── _data/                  # 数据文件
├── admin/                  # 管理后台
├── qiniu-config.json       # 七牛云配置（包含密钥，不要提交到 Git）
├── upload-to-qiniu.py      # 上传脚本
├── upload-assets.bat       # 一键上传批处理
└── README_QINIU.md         # 本说明文件
```

## ⚙️ 配置说明

### qiniu-config.json

```json
{
  "access_key": "你的AccessKey",
  "secret_key": "你的SecretKey",
  "bucket_name": "mg-portfolio-assets",
  "region": "z0",
  "domain": ""
}
```

- `access_key`: 七牛云 AccessKey
- `secret_key`: 七牛云 SecretKey
- `bucket_name`: 存储空间名称
- `region`: 存储区域代码（z0=华东-浙江）
- `domain`: CDN 域名（可选，可在 index.html 中配置）

### index.html 中的 CDN 配置

```javascript
const CDN_CONFIG = {
    useQiniuCDN: true,  // 启用七牛云 CDN
    qiniuCDNBase: 'https://你的域名.com/',  // CDN 域名
    // ... 其他配置
};
```

## 🔄 更新文件

当需要更新文件时：

1. **修改本地文件**
   - 在 `deploy/assets/` 或 `deploy/_data/` 中修改文件

2. **重新上传**
   ```bash
   upload-assets.bat
   ```
   
   脚本会重新上传所有文件（会覆盖同名文件）

## 🛠️ 故障排除

### 问题 1：上传失败

**错误**: `❌ 配置文件缺少必需项`

**解决**: 检查 `qiniu-config.json` 是否包含所有必需字段

---

### 问题 2：Python 未安装

**错误**: `❌ 未检测到 Python`

**解决**: 
1. 下载安装 Python 3.6+：https://www.python.org/downloads/
2. 安装时勾选 "Add Python to PATH"

---

### 问题 3：qiniu 库未安装

**错误**: `ModuleNotFoundError: No module named 'qiniu'`

**解决**: 
```bash
pip install qiniu
```

---

### 问题 4：资源加载失败

**可能原因**:
1. CDN 域名配置错误
2. 文件未上传到七牛云
3. 文件路径不匹配

**解决**:
1. 检查 `index.html` 中的 `qiniuCDNBase` 是否正确
2. 确认域名末尾有斜杠 `/`
3. 在七牛云控制台检查文件是否存在
4. 检查浏览器控制台的错误信息

---

### 问题 5：跨域错误（CORS）

**错误**: `Access-Control-Allow-Origin`

**解决**:
1. 登录七牛云控制台
2. 进入对象存储 → 选择空间
3. 空间设置 → 跨域设置
4. 添加规则：
   - 来源：`*` 或你的网站域名
   - 允许方法：`GET, HEAD`
   - 允许头部：`*`
   - 暴露头部：`ETag, Content-Length`

## 📝 注意事项

1. **密钥安全**
   - `qiniu-config.json` 包含敏感信息，不要提交到 Git
   - 建议添加到 `.gitignore`

2. **域名配置**
   - 域名末尾必须带斜杠 `/`
   - 使用 HTTPS 域名（七牛云默认支持）

3. **文件路径**
   - 确保七牛云上的文件路径与代码中的路径一致
   - 文件夹结构：`assets/` 和 `_data/`

4. **CDN 缓存**
   - 文件更新后，CDN 可能有缓存
   - 可以在七牛云控制台刷新缓存，或等待缓存过期

## 🔗 相关链接

- 七牛云控制台：https://portal.qiniu.com/
- 七牛云文档：https://developer.qiniu.com/
- Python qiniu SDK：https://github.com/qiniu/python-sdk

## 💡 提示

- 首次上传可能需要几分钟，取决于文件大小和网络速度
- 建议使用自定义域名，更稳定且无有效期限制
- 定期检查七牛云的使用量和费用（免费额度通常足够使用）

