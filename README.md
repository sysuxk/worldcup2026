# 2026 世界杯冠军预测器

手机 H5 单页应用：按小组排名、最佳第三、淘汰赛一路预测冠军，生成带 32 强对阵图和 GitHub Pages 二维码的分享海报。

## 本地预览

```bash
cd /Users/xiaokun/claudecode/worldcup2026
python3 -m http.server 8765
```

打开：

```text
http://127.0.0.1:8765/index.html
```

## GitHub Pages 发布

目标地址已在页面中配置为：

```text
https://sysuxk.github.io/worldcup2026/
```

### 使用 GitHub CLI

如果还没登录 GitHub CLI，先运行：

```bash
gh auth login
```

然后：

```bash
cd /Users/xiaokun/claudecode/worldcup2026
git init
git branch -M main
git add index.html README.md supabase/schema.sql .gitignore
git commit -m "Create World Cup 2026 H5 predictor"
gh repo create worldcup2026 --public --source=. --remote=origin --push
```

启用 Pages：

```bash
gh api repos/sysuxk/worldcup2026/pages \
  -X POST \
  -f source.branch=main \
  -f source.path=/
```

如果上面失败，在 GitHub 网页操作：仓库 Settings → Pages → Source 选择 `Deploy from a branch` → Branch 选 `main` → Folder 选 `/root` → Save。

## Supabase 数据库

1. 创建 Supabase 项目。
2. 打开 SQL Editor。
3. 执行 `supabase/schema.sql`。
4. 在 `index.html` 中替换：

```js
const SUPABASE_URL = 'https://YOUR_PROJECT_REF.supabase.co';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
```

只填写 anon public key，不要填写 service role key。

## 微信分享说明

普通 GitHub Pages 静态网页不能代替用户直接发布朋友圈或发送微信好友。页面提供了：

- 生成分享图片
- 保存/分享图片
- 发朋友圈提示
- 发微信好友提示
- 复制链接

用户可保存海报后在微信里发送或发朋友圈。海报底部二维码会打开 GitHub Pages 外网地址。
