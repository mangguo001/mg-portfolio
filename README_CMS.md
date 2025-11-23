# MG Portfolio 内容管理系统使用说明

## 📖 简介

这是一个基于 Decap CMS（原 Netlify CMS）的可视化管理后台系统，可以让你通过可视化界面编辑网站内容，无需直接修改代码。

## 🚀 访问管理后台

访问地址：`https://你的域名.github.io/mg-portfolio/admin/`

或本地测试：`http://localhost:8080/admin/`

## 🔐 登录方式

### 方式一：Git Gateway（推荐）

1. 访问管理后台页面
2. 点击 "Login with Netlify Identity"
3. 首次登录需要注册账号
4. 验证邮箱后即可使用

### 方式二：GitHub OAuth（需要配置）

如果使用 GitHub OAuth，需要在 GitHub 仓库设置中配置 OAuth App。

## 📝 功能说明

### 1. 作品管理

- **添加作品**：点击 "New Work" 创建新作品
- **编辑作品**：点击作品进入编辑页面
- **删除作品**：在编辑页面点击 "Delete" 删除作品
- **排序**：通过 `order` 字段控制显示顺序（数字越小越靠前）

#### 作品字段说明：

- **ID**：作品唯一标识（数字）
- **标题**：作品标题
- **描述**：作品简短描述
- **类型**：`video`（视频）或 `image`（图片）
- **文件名**：assets 文件夹中的文件名
- **分类**：作品分类（动画、绘画、交互、设计）
- **链接**：点击跳转的链接（如 B站链接，可选）
- **排序**：显示顺序（数字，越小越靠前）

### 2. 页面设置

- **网站标题**：浏览器标签页显示的标题
- **头部大标题**：首页头部显示的大标题（使用 `\n` 换行）
- **介绍文字**：首页右下角的介绍文字（5行）
- **分类列表**：网站的分类按钮列表

## 📁 文件结构

```
mg-portfolio/
├── index.html              # 主页面
├── admin/
│   ├── index.html          # 管理后台入口
│   └── config.yml          # CMS配置文件
├── _data/
│   ├── works.json          # 作品数据
│   └── settings.json       # 页面设置
└── assets/
    ├── uploads/            # 上传的媒体文件
    └── ...                 # 其他资源文件
```

## 🔧 配置说明

### CMS 配置（admin/config.yml）

主要配置项：

- **backend**: Git Gateway 或 GitHub OAuth
- **branch**: Git 分支名称（通常是 `main`）
- **media_folder**: 上传文件保存位置
- **public_folder**: 公开访问路径

### 数据文件格式

#### works.json 格式：

```json
{
  "works": [
    {
      "id": 1,
      "type": "video",
      "file": "demo_video.mp4",
      "title": "作品标题",
      "desc": "作品描述",
      "category": "动画",
      "link": "https://example.com",
      "order": 1
    }
  ]
}
```

#### settings.json 格式：

```json
{
  "settings": {
    "siteTitle": "MY WORK",
    "headerTitle": "MG-mango\nPortfolio.",
    "intro": {
      "line1": "慢工艺术.",
      "line2": "平PING & 芒果小子.",
      "line3": "数字艺术创作者.",
      "line4": "湖北武汉.",
      "line5": "🛰VX：mango130p"
    },
    "categories": ["动画", "绘画", "交互", "设计"]
  }
}
```

## 🎯 使用流程

### 添加新作品：

1. 访问管理后台
2. 点击左侧 "作品管理"
3. 点击右上角 "New Work" 按钮
4. 填写作品信息
5. 点击 "Publish" 发布
6. 等待 GitHub Pages 自动更新（1-2分钟）

### 编辑作品：

1. 访问管理后台
2. 在 "作品管理" 中找到要编辑的作品
3. 点击作品进入编辑页面
4. 修改内容
5. 点击 "Publish" 保存更改

### 修改页面设置：

1. 访问管理后台
2. 点击左侧 "页面设置"
3. 编辑网站设置
4. 点击 "Publish" 保存

## ⚠️ 注意事项

1. **文件名**：文件名必须与 `assets` 文件夹中的实际文件名完全一致（区分大小写）
2. **分类名称**：分类名称必须与设置的分类列表一致
3. **图片上传**：上传的图片会自动保存到 `assets/uploads/` 文件夹
4. **Git 提交**：每次修改都会创建一个新的 Git 提交
5. **自动部署**：修改提交后，GitHub Pages 会自动重新部署（需要 1-2 分钟）

## 🐛 故障排除

### 无法登录：

- 检查是否已启用 Git Gateway 或配置了 GitHub OAuth
- 检查网络连接
- 清除浏览器缓存

### 无法加载数据：

- 检查 JSON 文件格式是否正确
- 检查文件路径是否正确
- 查看浏览器控制台错误信息

### 修改后网站未更新：

- 等待 1-2 分钟让 GitHub Pages 重新部署
- 检查 GitHub 仓库的 Actions 标签，查看部署状态
- 强制刷新浏览器（Ctrl+F5）

## 📚 更多帮助

- [Decap CMS 官方文档](https://decapcms.org/)
- [Git Gateway 配置](https://decapcms.org/docs/git-gateway-backend/)
- [GitHub OAuth 配置](https://decapcms.org/docs/github-backend/)

## 🎨 自定义配置

如果需要修改 CMS 配置，编辑 `admin/config.yml` 文件：

- 添加新字段
- 修改字段类型
- 添加新的集合（collections）

修改后需要重新部署才能生效。

