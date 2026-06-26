# 🎓 UoA Thesis Template

> University of Auckland Sub-Doctoral Thesis — LaTeX 模板

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

基于 University of Auckland 论文格式指南的 LaTeX 模板，支持 VS Code 本地编辑和 Overleaf 在线编译。

---
# [点击预览PDF编译样本](https://github.com/Zhang-holden/UoA_Thesis_Template/blob/main/Sample%20File.pdf)
## 🚀 快速开始

### 方式一：本地 VS Code（推荐）

1. **安装 TeX 发行版**：
   - Windows：[MiKTeX](https://miktex.org/) 或 [TeX Live](https://tug.org/texlive/)
   - macOS：`brew install --cask mactex`
   - Linux：`sudo apt install texlive-xetex texlive-latex-extra biber`

2. **安装 VS Code 扩展**：[LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)

3. **打开项目**：用 VS Code 打开 `uoa_template/` 文件夹

4. **编译**：`Ctrl+S` 保存 → 自动编译（XeLaTeX → Biber → XeLaTeX × 2）

### 方式二：Overleaf（免费版会超时导致编译失败）

1. 下载本仓库 ZIP，将整个 `uoa_template/` 文件夹上传到 Overleaf
2. **切换编译器**：左上角 Menu → Compiler → 选 **XeLaTeX**
3. `.latexmkrc` 已配置好，点击 **Recompile** 即可

### 方式三：PRISM / 纯 pdfLaTeX

PRISM 仅支持 pdfLaTeX，不支持 `fontspec` 系统字体。需修改 `uoathesis.cls`：

```latex
% 注释掉 XeLaTeX 专用包
% \RequirePackage{fontspec}
% \setmainfont{Times New Roman}

% 替换为 pdfLaTeX 兼容字体
\RequirePackage{newtxtext}
\RequirePackage{newtxmath}
```

# 文档功能详细说明与使用方法见 [`USER_GUIDE.md`](USER_GUIDE.md) §1。

---

## 🖋️ 字体说明

| 平台 | 推荐字体 | 说明 |
|------|---------|------|
| Windows | **Times New Roman**（默认） | 系统自带 |
| macOS / Linux | TeX Gyre Termes | 开源等价字体，需安装 `tex-gyre` |

**切换字体**：编辑 `uoathesis.cls` 第 27 行，注释一行换另一行即可。

---

## 📁 项目结构

```
uoa_template/
├── main.tex                  ← 主文件：元数据 + 章节串联
├── uoathesis.cls             ← 格式类文件（字体/页边距/行距等）
├── .latexmkrc                ← Overleaf 编译配置
├── frontmatter/              ← 摘要、致谢、术语表等
├── chapters/                 ← 各章节 .tex 文件
├── appendix/                 ← 附录
├── bibliography/             ← .bib 参考文献数据库
├── figures/                  ← 图片文件夹
└── USER_GUIDE.md             ← 详细使用手册
```

---

## 📖 详细文档

参见 [`USER_GUIDE.md`](USER_GUIDE.md)，涵盖封面填写、摘要、章节编写、引用与参考文献（APA）、图片/表格/横排宽表、伪代码算法、交叉引用、数学公式、列表、防止图表漂移、编译指南、格式自定义、常见问题等 18 个章节。

---

## 🛠️ 本地编译命令

如果不使用 VS Code，也可以直接在终端编译：

```bash
# 完整编译（XeLaTeX → Biber → XeLaTeX × 2）
xelatex -shell-escape main.tex
biber main
xelatex -shell-escape main.tex
xelatex -shell-escape main.tex
```

---

## 📄 许可证

MIT License — 详见 [LICENSE](LICENSE)

---

## 🙏 致谢

- 模板架构参考 [uomthesis.cls](https://www.overleaf.com/latex/templates/university-of-melbourne-thesis-template-2025/vwqvztyxmsft)（University of Melbourne）
- University of Auckland [Guide to the presentation and submission of research components in sub-doctoral qualifications](https://www.auckland.ac.nz/en/students/academic-information/postgraduate-students/postgraduate/postgraduate-policies-guidelines-and-forms/presentation-submission-research-sub-doctoral.html)
