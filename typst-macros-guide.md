# Typst 常用宏速查

这份说明整理了本仓库里最常见、最适合期末复习直接套用的宏。优先看 `lib.typ` 对外导出的接口，不建议直接调用底层的 `math-fun-*` 框架函数。

## 基本导入

```typst
#import "lib.typ": *
#show: conf
```

如果你在 `template/*.typ` 里写笔记，通常已经间接导入了这些宏；如果是新文件，先加上上面两行最稳。

## 一眼看懂

| 宏 | 用途 | 默认行为 |
| --- | --- | --- |
| `#definition` | 定义 | 默认编号 |
| `#theorem` | 定理 | 默认编号 |
| `#lemma` | 引理 | 默认编号 |
| `#corollary` | 推论 | 默认编号 |
| `#axiom` | 公理 | 默认编号 |
| `#postulate` | 假设 | 默认编号 |
| `#proposition` | 命题 | 默认编号 |
| `#example` | 例题/例子 | 默认编号 |
| `#problem` | 题目 | 默认编号 |
| `#exercise` | 练习 | 默认编号 |
| `#exam` | 考题 | 默认不编号 |
| `#choices` | 选择题选项 | 自动排版 A/B/C/D |
| `#note` | 笔记 | 带框提示 |
| `#conclusion` | 结论 | 带框提示 |
| `#assumption` | 假设 | 带框提示 |
| `#property` | 性质 | 带框提示 |
| `#remark` | 注释/补充 | 带框提示 |
| `#solution` | 解答 | 带框提示 |
| `#proof` | 证明 | 带框提示 |
| `#introduction` | 章节导读 | “内容提要”风格 |
| `#problemset` | 练习区块 | 自动生成“练习”标题 |

## 真实参数写法（按源码定义）

下面写法都按当前仓库里的函数签名整理，可直接复制。

### 1) 定义/定理类（同一套参数）

适用：`#definition`、`#theorem`、`#lemma`、`#corollary`、`#axiom`、`#postulate`、`#proposition`

常用写法：

- `#definition[名称][内容]`

### 2) 例题/题目/练习/考题类

适用：`#example`、`#problem`、`#exercise`、`#exam`

常用写法（你提到的重点）：

- `#example[题干]`
- `#example[标题][题干]`

对应地，`#problem`、`#exercise`、`#exam` 也都是同样的“单括号内容 / 双括号标题+内容”模式。

### 3) 选择题选项

函数签名：`#choices(..args)`

推荐写法（每个选项一个内容块）：

- `#choices([选项A], [选项B], [选项C], [选项D])`

例如：

- `#choices([时间复杂度为 O(n)], [时间复杂度为 O(log n)], [时间复杂度为 O(n log n)], [时间复杂度为 O(n^2)])`


### 4) 笔记提示类

`#note`、`#conclusion`、`#assumption`：

- 单参数：`#note[内容]`
- 双参数：`#note[小标题][内容]`

它们的函数都是 `#xxx(..args)`，且支持“可选标题 + 正文”。

`#property`：

- `#property[内容]`
- `#property[标题][内容]`（标题会显示为“性质 (标题)”）

`#remark`、`#solution`、`#proof`：

- 仅单参数正文：`#remark[内容]`、`#solution[内容]`、`#proof[内容]`
