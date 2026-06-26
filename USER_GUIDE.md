# UoA Thesis 模板使用手册

> 基于 uoathesis.cls v1.0 — University of Auckland Sub-Doctoral Thesis Template

---

## 1. 文件结构速览

```
uoa_template/
├── main.tex                  ← 元数据 + 串联所有章节
├── uoathesis.cls             ← 格式类文件（字体/页边距/行距/标题等）
├── .latexmkrc                ← Overleaf 编译配置（上传到 Overleaf 零配置）
├── .vscode/
│   └── settings.json         ← VS Code 编译配置（保存即自动编译）
├── frontmatter/
│   ├── abstract.tex          ← 摘要（≤350 词）
│   ├── dedication.tex        ← 致献（可选，不需要可留空）
│   ├── acknowledgements.tex  ← 致谢
│   ├── acronyms.tex          ← 缩略语表（表格形式）
│   ├── glossaries.tex        ← 术语表（表格形式）
│   └── nomenclature.tex      ← 符号表（表格形式）
├── chapters/                 ← 【主要编辑的部分】
│   ├── 01_introduction.tex        ← 第 1 章 引言
│   ├── 02_literature_review.tex   ← 第 2 章 文献综述
│   ├── 03_methodology.tex         ← 第 3 章 方法
│   ├── 04_results.tex             ← 第 4 章 结果
│   ├── 05_discussion.tex          ← 第 5 章 讨论
│   ├── 06_conclusion.tex          ← 第 6 章 结论
│   └── examples.tex               ← 示例章节（展示所有模板功能）
├── appendix/
│   └── additional_data.tex        ← 附录
├── bibliography/
│   └── refs.bib                    ← 参考文献数据库（BibTeX 格式）
└── figures/                        ← 图片文件夹（放 PNG/JPG/PDF）
    └── README.md
```

**关键文件说明**：

| 文件 | 你需要改吗？ |
|------|-------------|
| main.tex | ✅ 必须 — 填封面信息、调章节顺序 |
| chapters/*.tex | ✅ 必须 — 写正文 |
| frontmatter/abstract.tex | ✅ 必须 — 写摘要 |
| frontmatter/acronyms.tex 等 | ✅ 可选 — 有术语就填 |
| `bibliography/refs.bib` | ✅ 必须 — 加参考文献 |
| uoathesis.cls | ⚠️ 偶尔 — 改格式才动（字体/行距/页边距） |
| .latexmkrc | ❌ 不需要 |

> ⚠️ **PRISM / pdfLaTeX 用户注意**：PRISM（OpenAI 的云端 LaTeX 平台）仅支持
> pdfLaTeX，无法使用 XeLaTeX 的 `fontspec` 包直接调用系统字体。
> 编译前需修改 `uoathesis.cls` 中的字体配置。

### 适配 pdfLaTeX 的改法

1. 打开 `uoathesis.cls`，找到第 22–27 行：

```latex
% 注释掉 XeLaTeX 专用包
% \RequirePackage{fontspec}
% \setmainfont{Times New Roman}
% \setmainfont{TeX Gyre Termes}

% 替换为 pdfLaTeX 兼容的 Times 字体包
\RequirePackage{newtxtext}
\RequirePackage{newtxmath}
```

2. 在 PRISM 中将编译引擎设为 **pdfLaTeX**。

| 平台 | 引擎 | 字体方案 |
|------|------|---------|
| VS Code / Overleaf | XeLaTeX | `fontspec` + `Times New Roman`（系统字体，100% 还原） |
| PRISM / 纯 pdfLaTeX | pdfLaTeX | `newtxtext` + `newtxmath`（接近 Times，微小差异） |

> `newtxtext` 是 Times New Roman 的开源替代，字符间距和连字有细微差异，
> 但不影响论文提交。完成后记得换回 XeLaTeX 做正式终稿。

---

## 2. 第一步：填写封面信息

打开 main.tex，修改第 12–22 行的元数据字段：

```latex
\ThesisTitle{Your Thesis Title Here}              ← 论文题目（必填）
\ThesisSubtitle{Optional Subtitle}                ← 副标题（不需要可删除整行）
\ThesisAuthor{Your Full Name}                     ← 姓名（必填）
\ThesisDegree{Master of Science}                  ← 学位名称（必填）
\ThesisSubject{Computer Science}                  ← 专业方向（必填）
\ThesisUniversity{The University of Auckland}     ← 大学（一般不改）
\ThesisYear{2026}                                 ← 完成年份（必填）
```

**封面自动生成的内容**：
> 论文题目 → 作者姓名 → 学位声明（"A thesis submitted in partial fulfilment..."）→ 年份

按照 UoA 规定，封面**不含**导师姓名和校徽。

---

## 3. 第二步：写摘要

编辑 frontmatter/abstract.tex：

```latex
\chapter*{Abstract}
\addcontentsline{toc}{chapter}{Abstract}

This thesis investigates the application of machine learning
techniques to ...

The key contributions of this work are:
\begin{enumerate}
  \item A novel algorithm for ...
  \item Comprehensive evaluation on ...
  \item Practical guidelines for ...
\end{enumerate}

\vspace{1cm}
\textbf{Keywords:} machine learning, optimisation, data analysis
```

| 注意事项 | 说明 |
|---------|------|
| 字数限制 | UoA 要求 ≤ 350 词 |
| \chapter*{} | 带 * 表示不编号（摘要不需要 "Chapter 1"） |
| \addcontentsline | 把摘要加入目录，**不要删除这行** |
| Keywords | 用 \textbf{} 加粗标签，逗号分隔关键词 |

---

## 4. 第三步：写正文章节

### 4.1 章节模板

每个章节是一个独立 .tex 文件，按以下模板：

```latex
\chapter{Introduction}
\label{chap:introduction}

\section{Background}
\label{sec:background}

Your text here. Climate change has become one of the most pressing
issues of our time \parencite{ipcc2023}.

\subsection{Historical Context}
\label{subsec:history}

The study of climate patterns dates back to ...

\section{Research Aims}
\label{sec:aims}

This thesis aims to:
\begin{enumerate}
  \item Investigate the impact of ...
  \item Develop a framework for ...
  \item Validate the proposed approach through ...
\end{enumerate}
```

### 4.2 层级结构

| 命令 | 层级 | 编号格式 |
|------|------|---------|
| \chapter{} | 章 | Chapter 1, Chapter 2... |
| \section{} | 节 | 1.1, 1.2, 2.1... |
| \subsection{} | 子节 | 1.1.1, 1.1.2... |
| \subsubsection{} | 子子节 | 1.1.1.1...（不编号、加粗斜体） |

### 4.3 添加新章节

如果要加第 7 章：

1. 创建文件 chapters/07_new_chapter.tex
2. 在 main.tex 的 \mainmatter 区域加一行：
   ``latex
   \include{chapters/07_new_chapter}
   ``
3. 保存 → 自动编译

### 4.4 交叉引用章节

```latex
% 在章节标题处放标签
\chapter{Introduction}
\label{chap:intro}

% 在别处引用
As discussed in Chapter~\ref{chap:intro}, ...
The background is covered in Section~\ref{sec:background}.
```

~ 是不换行空格，防止 "Chapter" 和 "1" 分成两行。

---

## 5. 如何使用引用和参考文献

### 5.1 添加文献到数据库

编辑 `bibliography/refs.bib`，每条参考文献按 BibTeX 格式：

**期刊文章**：
```bibtex
@article{he2016deep,
  author  = {He, Kaiming and Zhang, Xiangyu and Ren, Shaoqing and Sun, Jian},
  title   = {Deep Residual Learning for Image Recognition},
  journal = {Proceedings of the IEEE Conference on Computer Vision
             and Pattern Recognition},
  year    = {2016},
  pages   = {770--778},
  doi     = {10.1109/CVPR.2016.90}
}
```

**书籍**：
```bibtex
@book{goodfellow2016deep,
  author    = {Goodfellow, Ian and Bengio, Yoshua and Courville, Aaron},
  title     = {Deep Learning},
  publisher = {MIT Press},
  year      = {2016},
  address   = {Cambridge, MA}
}
```

**会议论文**：
```bibtex
@inproceedings{vaswani2017attention,
  author    = {Vaswani, Ashish and Shazeer, Noam and Parmar, Niki and
               Uszkoreit, Jakob and Jones, Llion and Gomez, Aidan N. and
               Kaiser, {\L}ukasz and Polosukhin, Illia},
  title     = {Attention Is All You Need},
  booktitle = {Advances in Neural Information Processing Systems},
  year      = {2017},
  pages     = {5998--6008}
}
```

**快速获取 .bib 条目**：Google Scholar → 搜文献 → 点 "Cite" → 点 "BibTeX" → 复制粘贴到 `refs.bib`。或者用 Zotero 批量导出

### 5.2 在正文中引用

```latex
% 括号引用 —— 最常用
According to recent studies \parencite{he2016deep}, ...

% 叙述性引用 —— 作者名作为句子主语
\textcite{goodfellow2016deep} provided a comprehensive overview ...

% 只写年份
The method was first proposed in \citeyear{vaswani2017attention}.

% 多篇一起引用
Several approaches have been proposed \parencite{he2016deep,vaswani2017attention}.
```

**编译后效果**：

| 命令 | 输出 |
|------|------|
| \parencite{he2016deep} | (He et al., 2016) |
| \textcite{goodfellow2016deep} | Goodfellow et al. (2016) |
| \citeyear{vaswani2017attention} | 2017 |
| \parencite{he2016deep,vaswani2017attention} | (He et al., 2016; Vaswani et al., 2017) |

### 5.3 编译引用

引用了新文献后保存即自动编译（Ctrl+S），或手动：

`
Ctrl+Alt+B → 选 "xelatex → biber → xelatex × 2"
`

> ⚠️ 编译链必须含 Biber，否则引用显示 (???)。保存触发的是完整链，不用担心。

---

## 6. 如何插入图片

### 6.1 基本单图

```latex
\begin{figure}[htbp]
  \centering
  \includegraphics[width=0.7\textwidth]{figures/experiment_setup.png}
  \caption{Experimental setup for the measurement.}
  \label{fig:setup}
\end{figure}
```

### 6.2 图片宽度选项

| 写法 | 效果 |
|------|------|
| width=0.5\textwidth | 宽 = 页面文字宽度的一半 |
| width=8cm | 固定 8cm 宽 |
| height=5cm | 固定 5cm 高（宽按比例） |
| width=0.5\textwidth,keepaspectratio | 宽 ≤ 50%，高自动保持比例 |
| scale=0.8 | 缩放到原图的 80% |

### 6.3 并排两张图

```latex
\begin{figure}[htbp]
  \centering
  \begin{subfigure}{0.48\textwidth}
    \centering
    \includegraphics[width=\textwidth]{figures/before.png}
    \caption{Before treatment.}
    \label{fig:before}
  \end{subfigure}
  \hfill
  \begin{subfigure}{0.48\textwidth}
    \centering
    \includegraphics[width=\textwidth]{figures/after.png}
    \caption{After treatment.}
    \label{fig:after}
  \end{subfigure}
  \caption{Comparison before and after treatment.}
  \label{fig:comparison}
\end{figure}
```

**效果**：两张图并排 (a) Before treatment (b) After treatment，共用图号 Figure 2。

### 6.4 浮动体位置控制

`[htbp]` 控制图片放在哪里：

| 字母 | 含义 |
|------|------|
| `h` | here — 尽量放在代码所在位置 |
| `t` | top — 页面顶部 |
| `b` | bottom — 页面底部 |
| `p` | page — 单独一页 |

推荐顺序：`[htbp]`（优先当前位置 → 顶部 → 底部 → 单独页）。
加 `!` 可强制：`[htbp!]`。

#### 防止图表漂移过远

图表有时会"漂移"到远离引用它的段落，这是 LaTeX 浮动算法的副作用。三种解决方法：

| 方法 | 用法 | 适用场景 |
|------|------|---------|
| 加 `!` | `\begin{figure}[htbp!]` | 大多数情况，允许 LaTeX 微调但强力约束 |
| `\FloatBarrier` | 在段落间插一行 `\FloatBarrier` | 强制该位置之前的所有浮动体立即输出，不跨节 |
| `[H]` | `\begin{figure}[H]` | 绝对固定，图/表**精确放在代码所在位置**（不推荐全书使用） |

**推荐策略**：

1. 先用 `[htbp!]`（加 `!`），多数情况就能固定住
2. 如果图表仍然漂到了下一节，在节标题 `\section{}` 前加 `\FloatBarrier`
3. `[H]` 作为最后武器——但会让 LaTeX 无法自动排版，可能造成大面积空白

```latex
% 示例：用 \FloatBarrier 锁定本章所有图表
\section{Results}
\label{sec:results}

\begin{figure}[htbp!]
  \centering
  \includegraphics[width=0.6\textwidth]{figures/result.png}
  \caption{Main experimental results.}
  \label{fig:result}
\end{figure}

\FloatBarrier  % 确保上图在此处之前输出，不漂移到下一节

\section{Discussion}
...
```

### 6.5 引用图片

```latex
As shown in Figure~\ref{fig:setup}, the apparatus consists of ...
Figure~\ref{fig:comparison} compares the two conditions.
See Figures~\ref{fig:before} and~\ref{fig:after} for details.
```

> ✅ 图片文件统一放 figures/ 文件夹，支持 PNG、JPG、PDF 格式。

---

## 7. 如何插入表格

### 7.1 标准三线表

```latex
\begin{table}[htbp]
  \centering
  \caption{Performance comparison of three algorithms on the benchmark
           dataset.}
  \label{tab:performance}
  \begin{tabular}{@{}lccc@{}}
    \toprule
    Algorithm & Accuracy (\%) & Precision & Recall \\
    \midrule
    Baseline   & 87.3 & 0.85 & 0.86 \\
    Method A   & 94.2 & 0.93 & 0.92 \\
    Method B   & 96.7 & 0.96 & 0.95 \\
    \textbf{Method C} & \textbf{97.1} & \textbf{0.97} & \textbf{0.96} \\
    \bottomrule
    \multicolumn{4}{@{}l@{}}{\small\textit{Note.} Higher values indicate
                             better performance.}
  \end{tabular}
\end{table}
```

**关键命令**：

| 命令 | 含义 |
|------|------|
| \toprule | 顶线（粗） |
| \midrule | 中间分隔线（细） |
| \bottomrule | 底线（粗） |
| \cmidrule{2-3} | 局部线（只画第 2–3 列下方） |
| \multicolumn{4}{@{}l@{}}{...} | 跨 4 列、左对齐、无列间距（表注释） |

### 7.2 带局部线的复杂表头

```latex
\begin{table}[htbp]
  \centering
  \caption{Summary of participant demographics across two cohorts.}
  \label{tab:demographics}
  \begin{tabular}{@{}lcccc@{}}
    \toprule
    & \multicolumn{2}{c}{Cohort A} & \multicolumn{2}{c}{Cohort B} \\
    \cmidrule(lr){2-3} \cmidrule(lr){4-5}
    Metric  & Mean  & SD    & Mean  & SD \\
    \midrule
    Age (years)  & 24.3 & 3.1 & 31.7 & 4.5 \\
    Score        & 78.5 & 9.2 & 82.1 & 7.8 \\
    \bottomrule
  \end{tabular}
\end{table}
```

### 7.3 列对齐符号速查

```latex
\begin{tabular}{l c r p{3cm}}
  左对齐 & 居中 & 右对齐 & 固定3cm宽自动换行 \\
\end{tabular}
```

| 符号 | 含义 | 适用场景 |
|------|------|---------|
| l | 左对齐 | 文字标签、算法名 |
| c | 居中对齐 | 数值数据 |
| `r` | 右对齐 | 小数对齐 |
| p{3cm} | 固定宽度 + 自动换行 | 长文本 |
| @{} | 去掉列间距 | 表两侧贴边 |

### 7.4 表注释（Table Note）

在 `\\end{tabular}` 之前用 `\\multicolumn` 跨全列放注释：

```latex
\bottomrule
\multicolumn{4}{@{}l@{}}{\small\textit{Note.} Higher values indicate
                         better performance.}
\end{tabular}
```

### 7.5 引用表格

```latex
The results in Table~\ref{tab:performance} show that Method C
outperforms all other algorithms.
```

---

## 8. 如何使用伪代码 / 算法块

模板内置了 `algorithm2e` 包，支持标准伪代码写法。
### 8.1 基本算法

```latex
\begin{algorithm}[htbp]
  \caption{Gradient Descent Optimisation}
  \label{alg:gd}
  \SetKwInput{KwParams}{Parameters}
  \KwParams{Learning rate $\eta$, max iterations $}
  \SetKwInput{KwInit}{Initialise}
  \KwInit{Model parameters $\theta_0$}
  \For{ \leftarrow 1$ \KwTo $}{
    Compute gradient $\nabla \mathcal{L}(\theta_{t-1})$\;
    Update $\theta_t \leftarrow \theta_{t-1} - \eta
            \nabla \mathcal{L}(\theta_{t-1})$\;
    \If{$\|\nabla \mathcal{L}(\theta_t)\| < \epsilon$}{
      \textbf{break}\;
    }
  }
  \Return{$\theta_t$}\;
\end{algorithm}
```

### 8.2 algorithm2e 常用命令

| 命令 | 含义 |
|------|------|
| \; | 行结束（每条语句末尾必须加） |
| \For{条件}{块} | for 循环 |
| \While{条件}{块} | while 循环 |
| \If{条件}{块} | if 条件 |
| \eIf{条件}{真块}{假块} | if-else |
| \Return{值} | return 语句 |
| `\\KwTo` | `to` 关键字（`1 \\KwTo n` → "1 to n"） |
| \SetKwInput{KwXxx}{Label} | 自定义输入标签 |
| \tcp{注释} | 行内注释 |

---

## 9. 如何交叉引用

### 9.1 标签命名规范

```latex
\label{chap:introduction}     % 章节
\label{sec:background}        % 节
\label{fig:setup}             % 图
\label{tab:performance}       % 表
\label{eq:einstein}           % 公式
\label{alg:gradient_descent}  % 算法
\label{app:data}              % 附录
```

### 9.2 引用命令

```latex
Chapter~\ref{chap:introduction}       → Chapter 1
Section~\ref{sec:background}          → Section 1.1
Figure~\ref{fig:setup}                → Figure 1
Table~\ref{tab:performance}           → Table 1
Equation~\ref{eq:einstein}            → Equation 1.1
Algorithm~\ref{alg:gd}                → Algorithm 1
Page~\pageref{chap:introduction}      → Page 2
```

**同时引用多个**：
```latex
Figures~\ref{fig:setup} and~\ref{fig:comparison}
Chapters~\ref{chap:intro}--\ref{chap:method}
```

---

## 10. 列表

### 10.1 无序列表

```latex
\begin{itemize}
  \item Data quality and availability
  \item Computational resource constraints
  \begin{itemize}
    \item GPU memory limitations
    \item Training time budget
  \end{itemize}
  \item Ethical considerations
\end{itemize}
```

**效果**：圆点 → 短横线 → 嵌套

### 10.2 有序列表（数字）

```latex
\begin{enumerate}
  \item Collect raw data from the sensors.
  \item Pre-process the data using standard normalisation.
  \item Train the model for 100 epochs.
  \item Evaluate on the held-out test set.
\end{enumerate}
```

### 10.3 带括号数字

```latex
\begin{enumerate}[label=\arabic*)]
  \item First step: prepare the dataset.
  \item Second step: configure the model hyperparameters.
  \item Third step: run the training procedure.
\end{enumerate}
```

**效果**：1) First step... / 2) Second step... / 3) Third step...

### 10.4 罗马数字

```latex
\begin{enumerate}[label=\roman*.]
  \item First criterion
  \item Second criterion
\end{enumerate}
```

| label 值 | 效果示例 |
|----------|---------|
| \arabic* | 1, 2, 3 |
| \arabic*) | 1), 2), 3) |
| \roman* | i, ii, iii |
| \Roman* | I, II, III |
| \alph* | a, b, c |
| (\alph*) | (a), (b), (c) |

---

## 11. 数学公式

### 11.1 行内公式

```latex
The well-known mass--energy equivalence is $E = mc^2$, where $m$ is
the rest mass and $c$ is the speed of light in vacuum.
```

### 11.2 独立公式（无编号）

```latex
\[
  F = G \frac{m_1 m_2}{r^2}
\]
```

### 11.3 带编号公式（可引用）

```latex
\begin{equation}
  \mathcal{L}(\theta) = \frac{1}{n} \sum_{i=1}^{n}
    \bigl( y_i - f(x_i; \theta) \bigr)^2
  \label{eq:mse}
\end{equation}
```

引用：Equation~\ref{eq:mse} → Equation 1.1

### 11.4 多行对齐公式（align）

```latex
\begin{align}
  y &= \beta_0 + \beta_1 x_1 + \beta_2 x_2 + \varepsilon
     \label{eq:linear_model} \\
  \hat{\beta} &= (X^\top X)^{-1} X^\top y
     \label{eq:ols}
\end{align}
```

& 标记对齐点（通常放 = 前），每行自动编号。

### 11.5 分段函数（cases）

```latex
\begin{equation}
  \text{ReLU}(x) =
  \begin{cases}
    x,  & x \geq 0 \\
    0,  & x < 0
  \end{cases}
  \label{eq:relu}
\end{equation}
```

### 11.6 常用符号速查

| 代码 | 效果 | 代码 | 效果 |
|------|------|------|------|
| x^2 | x² | x_i | xᵢ |
| \alpha \beta \gamma | α β γ | \theta \lambda \mu | θ λ μ |
| \sum_{i=1}^{n} | Σⁿᵢ₌₁ | \prod_{i=1}^{n} | Πⁿᵢ₌₁ |
| \int_{0}^{\infty} | ∫₀∞ | \oint | ∮ |
| \frac{a}{b} | a/b | \sqrt{x} \sqrt[n]{x} | √x ∛x |
| \partial | ∂ | \nabla | ∇ |
| \times \cdot \circ | × · ∘ | \pm \mp | ± ∓ |
| \leq \geq \ll \gg | ≤ ≥ ≪ ≫ | \neq \approx \equiv | ≠ ≈ ≡ |
| \infty | ∞ | \emptyset | ∅ |
| \mathbb{R} | ℝ | \mathcal{L} | ℒ |
| \mathbf{x} | **x** | \boldsymbol{\theta} | ***θ*** |
| \top | ⊤ | \bot | ⊥ |

---

## 12. 长引文（UoA 专用格式）

语法：

```latex
According to Smith (2020):

\begin{uoaquote}
This is a long quotation of three or more lines. Per the University
of Auckland formatting guidelines, it is indented 10\,mm from the
left-hand margin, single-spaced, and has no quotation marks. This
environment automatically handles all the formatting required.
\end{uoaquote}

This finding has significant implications for future research ...
```

**自动格式**：左缩进 10mm、单倍行距、无引号、字号略小。

---

## 13. 脚注

```latex
This claim is supported by multiple independent studies\footnote{See
  Smith (2020) and Jones (2021) for comprehensive reviews of the
  underlying methodology.}.
```

**效果**：页底出现上标编号 + 脚注文字。模板已配置为每页独立编号（1, 2, 3...），避免跨页累积到几十号。

---

## 14. 缩略语、术语表、符号表

三张表均改用普通 LaTeX 表格，编辑对应 .tex 文件即可，编译零额外步骤。

### 14.1 缩略语（Acronyms）

编辑 frontmatter/acronyms.tex：

```latex
\chapter*{Acronyms}
\addcontentsline{toc}{chapter}{Acronyms}

\begin{center}
\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}c c}
\toprule
\multicolumn{1}{l}{\textbf{Abbreviation}} & \multicolumn{1}{c}{\textbf{Full Form}} \\
\midrule
AI    & Artificial Intelligence \\
CNN   & Convolutional Neural Network \\
GPU   & Graphics Processing Unit \\
MSE   & Mean Squared Error \\
\bottomrule
\end{tabular*}
\end{center}
```

正文中直接写全称或缩写即可，如 \textit{Artificial Intelligence (AI)}。

### 14.2 术语表（Glossary）

编辑 frontmatter/glossaries.tex：

```latex
\chapter*{Glossary}
\addcontentsline{toc}{chapter}{Glossary}

\begin{center}
\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}c p{0.72\textwidth}}
\toprule
\multicolumn{1}{l}{\textbf{Term}} & \multicolumn{1}{c}{\textbf{Definition}} \\
\midrule
Backpropagation & Algorithm for computing gradients in neural networks
                  by applying the chain rule backwards through the
                  computation graph. \\
\LaTeX          & Typesetting system commonly used in academic and
                  scientific documents. \\
\bottomrule
\end{tabular*}
\end{center}
```

### 14.3 符号表（Nomenclature）

编辑 frontmatter/nomenclature.tex：

```latex
\chapter*{Nomenclature}
\addcontentsline{toc}{chapter}{Nomenclature}

\begin{center}
\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}c c c}
\toprule
\multicolumn{1}{l}{\textbf{Symbol}} & \multicolumn{1}{c}{\textbf{Description}}
  & \multicolumn{1}{c}{\textbf{Unit}} \\
\midrule
$v$  & Velocity                                & m/s \\
$x$  & Position                                & m   \\
$c$  & Speed of light in vacuum                & $3.00 \times 10^8$ m/s \\
$h$  & Planck constant                         & $6.63 \times 10^{-34}$ J·s \\
\bottomrule
\end{tabular*}
\end{center}
```

### 14.4 表格格式说明

| 特性 | 说明 |
|------|------|
| `tabular*{\textwidth}` | 撑满页面文字宽度 |
| @{\extracolsep{\fill}} | 列间自动均匀分布空白 |
| \multicolumn{1}{l}{...} | 表头左对齐覆盖 |
| \multicolumn{1}{c}{...} | 表头居中覆盖 |
| p{0.72\textwidth} | 术语定义列自动换行 |

---

## 15. 编译指南

### 15.1 自动编译（推荐）

编译链：**XeLaTeX → Biber → XeLaTeX × 2**（共 4 步）。

| 操作 | 方法 |
|------|------|
| 日常写作 | Ctrl+S 保存 |
| 手动触发 | Ctrl+Alt+B |
| 仅看排版（不更新引用） | Ctrl+Alt+B → 选 "xelatex × 2" |
| 查看 PDF | Ctrl+Alt+V |
| PDF 反向定位源码 | Ctrl+Click PDF 上的文字 |

### 15.2 命令行编译

```bash
# 完整编译（XeLaTeX → Biber → XeLaTeX × 2）
xelatex -shell-escape main.tex
biber main
xelatex -shell-escape main.tex
xelatex -shell-escape main.tex
```

### 15.3 Overleaf 编译

上传整个 uoa_template/ 文件夹到 Overleaf，.latexmkrc 会自动配置编译方式，点击 **Recompile** 即可。

### 15.4 编译时机速查

| 做了什么 | 需要跑 |
|---------|--------|
| 改正文文字 | Ctrl+S（自动） |
| 加/改 \parencite{} 引用 | Ctrl+S（含 Biber） |
| 加了新的 \label{} 交叉引用 | Ctrl+S（含 2 遍 XeLaTeX） |
| 改 `refs.bib` | Ctrl+S（含 Biber） |
| 加新图/新表 | Ctrl+S（自动） |
| 改 uoathesis.cls 格式 | Ctrl+S（全部重编） |

---

## 16. 格式自定义

所有格式定义在 uoathesis.cls 中：

| 想改什么 | 位置 | 改法 |
|---------|------|------|
| 正文字号 | 第 17 行 | `[12pt]` → `[11pt]` |
| 字体 | 第 27 行 | `Times New Roman` → `TeX Gyre Termes` |
| 页边距 | 第 43–50 行 | 修改 `left/right/top/bottom` 值 |
| 行距 | 第 56 行 | `\onehalfspacing` → `\doublespacing` |
| 图表标题格式 | 第 74 行 | `labelfont/justification/font` 参数 |
| 参考文献格式 | 第 105 行 | `style=apa` → `style=ieee` |
| 封面布局 | 第 140–176 行 | `\vspace*{}` 调整间距 |
| 页码位置 | 第 190 行 | `C` → `L`（左）/ `R`（右） |

### 16.1 图表标题自定义

```latex
% 当前配置：标签粗体、quad 间隔、标题居中、小号字
\RequirePackage[labelfont=bf,labelsep=quad,justification=centering,font=small]{caption}

% 示例：标签正常字体 + 冒号分隔 + 标题左对齐
% \RequirePackage[labelfont=normalfont,labelsep=colon,justification=raggedright,font=small]{caption}
```

---

## 17. 常见问题

| 问题 | 原因 | 解决 |
|------|------|------|
| 引用显示 (???) | 没跑 Biber | Ctrl+S 保存触发完整编译 |
| 图片不显示 | 路径错误或图片不在 figures/ | 确认文件名和路径 |
| Illegal unit of measure | \\ 后紧跟 [ 被误解 | \\ 和 [ 间加 {} |
| 参考文献列表为空 | 正文无 \parencite{} 或 Biber 没跑 | 加引用 + Ctrl+S |
| 章节在目录中缺失 | .tex 文件不以 \chapter{} 开头 | 检查文件首行 |
| 编译报 font not found（Mac/Linux） | Times New Roman 不存在 | uoathesis.cls 第 27 行改为 TeX Gyre Termes |
| 算法环境报 undefined | 旧版编译 | Ctrl+S 重新编译 |

---

## 18. 写作工作流建议
1. **填元数据** → 改 main.tex 第 12–22 行
2. **写大纲** → 在每个 chapters/*.tex 写 \chapter{} + \section{} 骨架
3. **编译看版式** → Ctrl+S 保存即自动编译
4. **逐步填内容** → 一次写一小节，写完保存看效果
5. **加引用** → Google Scholar 复制 BibTeX → 粘贴到 `refs.bib` → 正文 `\parencite{}`
6. **加图表** → 图片放 `figures/`，用 `\includegraphics`；表格用三线表模板
7. **加术语** → 有缩略语/术语/符号时编辑对应的 frontmatter 表格
8. **最终检查** → Ctrl+S 确认编译无报错，检查 PDF 排版
