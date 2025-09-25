# 生产实习报告（LaTeX 工程）

本仓库包含 `main.tex` 及分章节的中文生产实习报告源码，已配置 VS Code + `latexmk` 使用 XeLaTeX 编译中文。当前字体策略支持自动回退，适合在容器 / Linux / Windows 多环境使用。

## 1. 编译方式

最简：
```
latexmk -xelatex main.tex
```
或在 VS Code（已配置任务）中运行 `LaTeX: build`。

清理中间文件：
```
latexmk -C
```

（如需完全清理 PDF 也可：`rm -f main.pdf` 后再编译。）

## 2. 目录结构

```
main.tex            # 主文件
tex/                # 拆分的章节与格式控制
	00-depends.tex    # 依赖 & 全局包 & 字体 & 页眉
	05-formats.tex    # 标题/目录/行距/列表等格式
	xx-*.tex          # 正文章节
assets/             # 图片等资源（logo 等）
cite/               # （当前未使用）bib 条目示例
bin/                # 可扩展的脚本（预留）
```

## 3. 字体策略

在 `tex/00-depends.tex` 中的逻辑：
1. 西文优先 `Times New Roman`，若缺失回退 `TeX Gyre Termes`（外观接近 Times）。
2. 中文优先 `Noto Serif CJK SC`（思源宋体 Serif 版），若缺失回退 `FandolSong`（TeX Live 自带）。
3. 中文无衬线优先 `Noto Sans CJK SC`，缺失回退 `FandolHei`。
4. 这些字体通过 XeLaTeX + `ctex` + `fontspec` 自动处理，无需手动放置字体文件。

如果你想用系统 SimSun：
```
\IfFontExistsTF{SimSun}{\setCJKmainfont{SimSun}}{}
```
放在当前中文字体设置之前即可。

## 4. 环境依赖

基础（ Debian/Ubuntu 容器 ）：
```
apt-get update
apt-get install -y latexmk texlive-xetex texlive-latex-recommended \\
									 texlive-latex-extra texlive-fonts-recommended \\
									 fonts-noto-cjk
```

（容器中我们已经安装 `fonts-noto-cjk`，故中文已正常渲染。）

## 5. 常见问题 (FAQ)

| 现象 | 可能原因 | 处理 |
|------|----------|------|
| PDF 中文空白 | 未加载 CJK 字体 / 旧缓存 | `latexmk -C` 重新编译；确认 `fonts-noto-cjk` 安装。 |
| 字体不是宋体风格 | 实际使用 Fandol 回退 | 安装 `fonts-noto-cjk` 或放置 SimSun 并修改设置。 |
| 页码样式要修改 | 自定义 fancyhdr | 编辑 `00-depends.tex` 中 `\fancyhead` / `\fancyfoot`。 |
| 行距不符 | 1.5 倍行距需求变化 | 调整 `\onehalfspacing` 或改 `setspace`。 |
| 章节编号格式需改 | 自定义 titleformat | 修改 `05-formats.tex`。 |

## 6. 最小示例（MWE）

如果需要调试字体，可建一个 `mwe.tex`：
```
\documentclass{article}
\usepackage{ctex}
\begin{document}
中文测试：你好，生产实习报告。\\
English: Hello World.
\end{document}
```
编译：`xelatex mwe.tex`

## 7. 未来可选增强
* 添加 `.gitignore` 忽略临时文件。
* 加 `unicode-math` 统一数学字体。
* 自动生成封面 / 元数据（title/author/date）。
* 引入 Makefile 或 CI 自动构建。

## 8. 许可证

见仓库根目录 `LICENSE`。

---
若需我继续补 `.gitignore` 或添加 SimSun 探测，请提出即可。