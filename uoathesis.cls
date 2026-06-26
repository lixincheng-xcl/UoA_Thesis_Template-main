% uoathesis.cls — University of Auckland Thesis Class
% Based on: "Guide to the presentation and submission of research components in sub-doctoral qualifications" (University of Auckland)
% https://www.auckland.ac.nz/en/students/academic-information/postgraduate-students/postgraduate/postgraduate-policies-guidelines-and-forms/presentation-submission-research-sub-doctoral.html
% Author: Xincheng Li
% Compile with: XeLaTeX
% Version: 1.0 (2026/05/13)

\def\versionno{1.0}
\def\versiondate{2026/05/13}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uoathesis}[\versiondate\space v\versionno\space University of Auckland Thesis Class]

% ============================================================
%  1. Base Class
% ============================================================
\LoadClass[12pt,a4paper]{report}                              %字体大小可调，A4纸张

% ============================================================
%  2. Typography — XeLaTeX + Times-compatible font
% ============================================================
\RequirePackage{fontspec}
% ── 字体选择 ──────────────────────────────────────────
% 优先使用 Times New Roman；若系统或 Overleaf 中不存在，则自动使用
% TeX Gyre Termes（开源 Times 风格字体，TeX Live / Overleaf 默认可用）。
\IfFontExistsTF{Times New Roman}
  {\setmainfont{Times New Roman}}
  {\setmainfont{TeX Gyre Termes}}
\RequirePackage{etoolbox}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{csquotes}
\RequirePackage{enumitem}
\RequirePackage{amsmath}                                     %数学公式（align, equation 等）
\RequirePackage[linesnumbered,ruled,vlined]{algorithm2e}     %伪代码/算法块
\RequirePackage{array}                                       %表格列格式（>{} 语法）
\RequirePackage{pdflscape}                                   %横排页面（旋转90度大表格）
\RequirePackage{placeins}                                    %\FloatBarrier 阻止图表浮动过远

% ============================================================
%  3. Page Geometry
% ============================================================
\RequirePackage[                                               %页面格式可调
  a4paper,
  left=25mm,
  right=20mm,
  top=25mm,
  bottom=25mm,
  headheight=15pt
]{geometry}

% ============================================================
%  4. Spacing — 1.5 line spacing + compact floats
% ============================================================
\RequirePackage{setspace}
\onehalfspacing                                               %行距可调（1.5）

% Tighten float spacing (default values are: textfloatsep 20pt,
% intextsep 12pt, floatsep 12pt — reduced for a more compact layout)
\setlength{\textfloatsep}{12pt plus 2pt minus 2pt}
\setlength{\intextsep}{12pt plus 2pt minus 2pt}
\setlength{\floatsep}{10pt plus 2pt minus 2pt}

% ============================================================
%  5. Headers & Footers — page numbers bottom centre
% ============================================================
\RequirePackage{fancyhdr}
\RequirePackage{emptypage}

% ============================================================
%  6. Captions — bold label, small font, centred
% ============================================================
\RequirePackage[labelfont=bf,labelsep=quad,justification=centering,font=small]{caption}
\RequirePackage{subcaption}

% ============================================================
%  7. Hyperlinks
% ============================================================
\RequirePackage{hyperref}
\hypersetup{
  colorlinks   = true,
  linkcolor    = blue!70!black,
  urlcolor     = blue!60!black,
  citecolor    = blue!90!black,
  filecolor    = blue!40!black
}

% ============================================================
%  8. Long Quotations — 10mm left indent, single spaced, no quote marks
%     UoA: "indented 10mm from the left-hand margin ... quote-marks omitted"
% ============================================================
\RequirePackage{quoting}                                      %长引文环境
\newenvironment{uoaquote}
  {\begin{quoting}[leftmargin=10mm,rightmargin=0mm,font=singlespacing]\small}
  {\end{quoting}}

% ============================================================
%  9. Footnotes — Arabic numerals, consecutive per chapter
% ============================================================
\RequirePackage[perpage]{footmisc}

% ============================================================
% 10. Bibliography — APA via biblatex + biber
% ============================================================
\RequirePackage[style=apa,backend=biber]{biblatex}             %参考文献格式可调

% ============================================================
% 11. THESIS METADATA COMMANDS
%     Pattern: internal storage → setter → conditional display
% ============================================================
\makeatletter
\let\uoathesistitle\@empty
\let\uoathesissubtitle\@empty
\let\uoathesisauthor\@empty
\let\uoathesisdegree\@empty
\let\uoathesissubject\@empty
\let\uoathesisdepartment\@empty
\let\uoathesisuniversity\@empty
\let\uoathesissupervisor\@empty
\let\uoathesisyear\@empty
\makeatother

\newcommand{\ThesisTitle}[1]{\renewcommand{\uoathesistitle}{#1}}
\newcommand{\ThesisSubtitle}[1]{\renewcommand{\uoathesissubtitle}{#1}}
\newcommand{\ThesisAuthor}[1]{\renewcommand{\uoathesisauthor}{#1}}
\newcommand{\ThesisDegree}[1]{\renewcommand{\uoathesisdegree}{#1}}
\newcommand{\ThesisSubject}[1]{\renewcommand{\uoathesissubject}{#1}}
\newcommand{\ThesisDepartment}[1]{\renewcommand{\uoathesisdepartment}{#1}}
\newcommand{\ThesisUniversity}[1]{\renewcommand{\uoathesisuniversity}{#1}}
\newcommand{\ThesisSupervisor}[1]{\renewcommand{\uoathesissupervisor}{#1}}  % 不用于封面
\newcommand{\ThesisYear}[1]{\renewcommand{\uoathesisyear}{#1}}

% ============================================================
% 12. TITLE PAGE — UoA Guidelines
%     Title top third | Author middle | Degree statement lower third
%     No logo, no supervisor on title page
%     UoA: "The title page must not include the name of the supervisor or any logo"
% ============================================================
\makeatletter
\renewcommand{\maketitle}{%
  \begin{titlepage}
    \centering
    % ---- Top third: Title ----
    \vspace*{0.10\textheight}
    {\Huge\bfseries \uoathesistitle\par}
    \ifx\uoathesissubtitle\@empty\else
      \vspace{0.8cm}
      {\Large \uoathesissubtitle\par}
    \fi

    % ---- Middle: Author ----
    \vspace{0.18\textheight}
    {\Large \uoathesisauthor\par}

    % ---- Lower third: Degree information ----
    \vspace{0.22\textheight}
    {\normalsize
      A thesis submitted in partial fulfilment of the requirements for the degree of\\
      \ifx\uoathesisdegree\@empty\else\uoathesisdegree\fi
      \ifx\uoathesissubject\@empty\else\ in \uoathesissubject\fi,\\
      \ifx\uoathesisuniversity\@empty\else\uoathesisuniversity,\fi\
      \ifx\uoathesisyear\@empty\else\uoathesisyear\fi.\par
    }
    \vfill
  \end{titlepage}
}
\makeatother

% ============================================================
% 13. FRONTMATTER — Roman numerals, plain page style
% ============================================================
\makeatletter
\newcommand{\frontmatter}{%
  \cleardoublepage
  \pagenumbering{roman}
  \pagestyle{plain}
}
\makeatother

% ============================================================
% 14. MAINMATTER — Arabic numerals, page numbers bottom centre
% ============================================================
\makeatletter
\newcommand{\mainmatter}{%
  \cleardoublepage
  \pagenumbering{arabic}
  \pagestyle{fancy}
  \fancyhf{}
  \fancyfoot[C]{\thepage}
  \renewcommand{\headrulewidth}{0pt}
  \fancypagestyle{plain}{%
    \fancyhf{}
    \fancyfoot[C]{\thepage}
  }
}
\makeatother

% ============================================================
% 15. Ensure LoF / LoT start on new page
% ============================================================
\AtBeginDocument{%
  \preto{\listoffigures}{\cleardoublepage}
  \preto{\listoftables}{\cleardoublepage}
}

\endinput
