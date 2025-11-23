# 🚀 快速开始指南

## 已完成的功能

✅ **数据文件结构**
- `_data/works.json` - 作品数据文件
- `_data/settings.json` - 页面设置文件

✅ **管理后台**
- `admin/index.html` - Decap CMS 管理后台（完整版）
- `admin/config.yml` - CMS 配置文件
- `admin-simple.html` - 简化版管理后台（可直接使用）

✅ **主页面**
- 从 JSON 文件加载数据
- 自动更新页面设置
- 支持动态分类

## 📝 使用方法

### 方法一：使用简化版管理后台（推荐，无需配置）

1. **本地打开管理后台**
   - 双击 `admin-simple.html` 文件
   - 或在浏览器中打开：`file:///路径/admin-simple.html`

2. **编辑作品**
   - 点击作品进入编辑模式
   - 修改内容后点击"保存"
   - 点击"导出 JSON" 复制数据

3. **更新数据文件**
   - 打开 `_data/works.json` 文件
   - 粘贴导出的 JSON 数据
   - 保存文件

4. **推送到 GitHub**
   ```bash
   cd C:\Users\Admin\Desktop\MGgh
   git add _data/works.json
   git commit -m "更新作品数据"
   git push
   ```

5. **等待更新**
   - 等待 1-2 分钟让 GitHub Pages 自动更新

### 方法二：使用 Decap CMS（完整版，需要 Netlify）

1. **配置 Netlify**
   - 访问 https://www.netlify.com/
   - 注册账号并导入 GitHub 仓库
   - 启用 Identity 和 Git Gateway

2. **访问管理后台**
   - 访问：`https://你的域名.netlify.app/admin/`
   - 注册/登录账号
   - 开始管理内容

详细配置步骤请参考 `SETUP_CMS.md`

## 📁 文件说明

- `_data/works.json` - 作品数据（可编辑）
- `_data/settings.json` - 页面设置（可编辑）
- `admin/index.html` - Decap CMS 管理后台
- `admin/config.yml` - CMS 配置文件
- `admin-simple.html` - 简化版管理后台（无需配置）
- `index.html` - 主页面（从 JSON 加载数据）

## 🎯 添加新作品

### 使用简化版管理后台：

1. 打开 `admin-simple.html`
2. 点击 "添加新作品" 按钮
3. 填写作品信息：
   - 标题
   - 描述
   - 类型（视频/图片）
   - 文件名（assets 文件夹中的文件名）
   - 分类（动画/绘画/交互/设计）
   - 链接（可选）
   - 排序（数字，越小越靠前）
4. 点击 "保存"
5. 点击 "导出 JSON"
6. 更新 `_data/works.json` 文件
7. 推送到 GitHub

### 直接编辑 JSON 文件：

1. 打开 `_data/works.json`
2. 在 `works` 数组中添加新对象：
```json
{
  "id": 6,
  "type": "video",
  "file": "新视频.mp4",
  "title": "作品标题",
  "desc": "作品描述",
  "category": "动画",
  "link": "https://example.com",
  "order": 6
}
```
3. 保存文件
4. 推送到 GitHub

## 🔧 修改页面设置

### 编辑 `_data/settings.json`：

```json
{
  "settings": {
    "siteTitle": "网站标题",
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

修改后推送到 GitHub，网站会自动更新。

## ⚠️ 注意事项

1. **文件名必须准确**：文件名必须与 `assets` 文件夹中的实际文件名完全一致（区分大小写）
2. **JSON 格式**：确保 JSON 格式正确，可以使用 JSON 验证工具检查
3. **Git 提交**：修改后记得提交并推送到 GitHub
4. **等待更新**：GitHub Pages 需要 1-2 分钟才能更新

## 💡 推荐工作流程

1. 本地使用 `admin-simple.html` 编辑数据
2. 导出 JSON 并更新数据文件
3. 使用 `push.bat` 一键推送到 GitHub
4. 等待网站自动更新

## 📚 更多帮助

- 详细配置：查看 `SETUP_CMS.md`
- CMS 使用：查看 `README_CMS.md`
- 问题反馈：检查浏览器控制台错误信息

