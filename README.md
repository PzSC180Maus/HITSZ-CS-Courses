# 大二下课程笔记汇总 (Sophomore Semester 2 Course Notes)

这是一个利用 AI Agent 驱动生成的、基于 Typst 的 HITSZ CS 大二下学期课程整理笔记汇总。

## 1. 愿景与初衷

在 AI Agent 浪潮下，编写一份整洁美观且内容详实的笔记已不再是旷日持久的苦差。每个人都有条件在短时间内，通过 Agent 迅速解析课程 PPT、往年真题，搓出一份完整的课程“说明书”。这种生产力是以往任何技术条件都不具备的。

**项目愿景：** 有人能基于此，将所有课程的整理笔记汇总为一个大型仓库，并最终将其嵌入到 **hoa** 之中。形成一个大家都可以共同协作、持续维护的笔记平台。这个笔记平台不仅可以为当前的学生提供帮助，也能成为未来学弟学妹们宝贵的学习资源。

## 2. 包含课程

目前已涵盖以下课程的笔记整理：

- **计算机组成原理** (`template/computer_constitution.typ`)
- **数据结构** (`template/datastructure.typ`)
- **机器学习** (`template/machinelearning.typ`)
- **自动机与形式语言** (`template/automachine.typ`)
- **软件构造** (`template/software_construction.typ`)

> **注意：** 本仓库基本由 Vibe coding 驱动生成，部分图片、图表的放置可能较为杂乱，欢迎后来者进行整理和美化。

## 3. 项目结构

```text

├── template/          # 课程笔记入口文件 (.typ)
├── pdfs/              # 原始课程 PPT 与素材 (供 Agent 读取)
├── assets/            # 笔记中使用的静态资源
├── diagrams/          # 绘图源代码
├── math/              # 数学公式与符号定义
├── util/              # 处理 PDF 与渲染的辅助工具
└── conf.typ           # 全局样式配置
```

## 4. 环境要求

- **Typst Compiler**: `0.14.2` 或更高版本
- **Template Version**: `quite-elegant-typ 0.2.0`

编译命令示例：
```bash
typst compile template/{course_name}.typ --root .
```

## 5. 模板致谢

本模板根据 [Quite-Elegant-Typ](https://github.com/a31474/quite-elegant-typ) 修改而来。

## 6. 许可证与开发

- **大胆 Fork**：本项目鼓励任何形式的衍生和二次分发。
- **无需署名**：你可以自由使用、修改，无需保留原作者署名。
- **期待贡献**：希望有心人能将其整理并集成到 **hoa**，作为其新的组成部分。

---
*Powered by AI Agents & Typst*
