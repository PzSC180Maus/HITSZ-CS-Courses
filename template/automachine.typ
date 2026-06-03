#import "../lib.typ": *
#import "../diagrams/automachine/diagrams.typ": *
#show: conf

#default-cover(
  title: [形式语言与自动机],
  subtitle: [课程整理],
)

#default-outline()

= 课程简介及基础知识

#introduction[形式化描述][演绎证明][归纳证明][基本概念与语言]

== 形式化描述与证明

=== 形式化描述
使用基于数学的方法以形式化规约语言对问题、模型等进行精确描述，是科学研究的基础。

=== 形式化证明

#theorem[演绎证明][
  一是从一般性原理出发，依据已被确认的事实和公认的逻辑规则，推导出某个特殊情况下的结论。
  - 大前提：已知的一般性原理
  - 小前提：所证明对象的特殊性
  - 结论：根据一般性原理，对特殊情况作出判断
]

#theorem[归纳证明][
  从由某类事物的部分对象具有某些特征，推导出该类事物的全部对象都具有这些特征的过程。由“基础”和“归纳递推”两部分组成。
]

#example[归纳证明示例][
  证明：若 $x$ 和 $y$ 是 $Sigma$ 上的字符串，则 $|x y| = |x| + |y|$。
  
]


#solution[
  *证明：* 通过对 $y$ 的长度进行归纳。
  1. *基础：* 当 $|y|=0$ 时，即 $y = epsilon$，则 $x y = x epsilon = x$，故 $|x y| = |x| = |x| + 0 = |x| + |epsilon|$。
  2. *递推：* 假设 $|y|=n$ 时命题成立。当 $|y|=n+1$ 时，设 $y = w a$，其中 $a in Sigma$。
     $x y = x(w a) = (x w) a$
     $|x y| = |(x w) a| = |x w| + 1$ （根据长度定义）
     $|x y| = (|x| + |w|) + 1$ （根据归纳假设）
     $|x y| = |x| + (|w| + 1) = |x| + |w a| = |x| + |y|$
]
#property[反证法][
  假设某命题不成立，然后推理出矛盾的结果。
]

#property[逆否命题][
  命题“如果H，则C”与其逆否命题“如果非C，则非H”等价。
]

== 基本概念

#definition[字母表 (Alphabet)][
  符号（字符）的非空有穷集合，记为 $Sigma$。
]

#definition[字符串 (String)][
  由某字母表中符号组成的有穷序列。
  - 空串：记为 $epsilon$，长度为 0。
  - 字符串 $w$ 的长度：记为 $|w|$。
]

#definition[语言 (Language)][
  若 $Sigma$ 为字母表且 $L subset Sigma^*$, 则称 $L$ 为字母表 $Sigma$ 上的语言。
]

#property[克林闭包与正闭包][
  - 克林闭包：$Sigma^* = union_(i=0)^oo Sigma^i$
  - 正闭包：$Sigma^+ = union_(i=1)^oo Sigma^i$
  - 关系：$Sigma^* = Sigma^+ union {epsilon}$
]

#problemset[
  #problem[（2024年）给定集合 $A = {epsilon, 01, 1}$，$B = {01, epsilon}$，$C = {011, 101}$，请给出：
  1. 集合 $A$ 与集合 $B$ 的连接 $A B$
  2. 集合 $A^2$ 与集合 $C$ 的差 $A^2 - C$
  ]

  #solution[
    (1) *集合 A 与集合 B 的连接 AB*：
    $A B = {x y | x in A, y in B}$
    $A B = {epsilon, 01, 1} dot {01, epsilon} = {01, epsilon, 0101, 01, 101, 1}$
    去重及整理后：$A B = {epsilon, 01, 1, 0101, 101}$

    (2) *集合 $A^2$ 与集合 C 的差 $A^2 - C$*：
    首先计算 $A^2 = A A$：
    $A^2 = {epsilon, 01, 1} dot {epsilon, 01, 1} = {epsilon, 01, 1, 01, 0101, 011, 1, 101, 11}$
    去重后：$A^2 = {epsilon, 01, 1, 0101, 011, 101, 11}$
    计算差集 $A^2 - C$：
    $A^2 - C = {epsilon, 01, 1, 0101, 011, 101, 11} - {011, 101}$
    $A^2 - C = {epsilon, 01, 1, 0101, 11}$
  ]
  
]

= 有穷状态自动机

#introduction[DFA][NFA][$epsilon$-NFA][等价性证明]

== 确定有穷自动机 (DFA)

#definition[DFA 形式化定义][
  确定的有穷自动机 (DFA) 为五元组 $A = (Q, Sigma, delta, q_0, F)$：
  1. $Q$：有穷状态集
  2. $Sigma$：有穷输入符号集（字母表）
  3. $delta$：状态转移函数，$delta: Q times Sigma -> Q$
  4. $q_0$：初始状态，$q_0 in Q$
  5. $F$：终结状态集或接受状态集，$F subset Q$
]


#problem[设计 DFA   在任何由 0 和 1 构成的串中，接受含有 "01" 子串的全部串。]

#solution[
  - $Q = {q_0, q_1, q_2}$
  - $q_0$：初始状态，没发现 "01" 且没发现 0。
  - $q_1$：发现 0。
  - $q_2$：终止状态，已发现 "01"。
  
  转移函数：
  - $delta(q_0, 0) = q_1, delta(q_0, 1) = q_0$
  - $delta(q_1, 0) = q_1, delta(q_1, 1) = q_2$
  - $delta(q_2, 0) = q_2, delta(q_2, 1) = q_2$
]

#figure(
  image("../assets/automachine/Page_25.png", width: 60%),
  caption: [含有01子串的DFA状态转移图]
)

#example[接受全部含有偶数个 0 和偶数个 1 的串][
  四个状态：
  - $q_0$：(偶0, 偶1) - 开始状态且接受状态
  - $q_1$：(偶0, 奇1)
  - $q_2$：(奇0, 偶1)
  - $q_3$：(奇0, 奇1)
]

#figure(
  image("../assets/automachine/Page_44.png", width: 60%),
  caption: [偶数个0和1的DFA]
)

== 扩展转移函数
#definition[定义扩展转移函数 $hat(delta)$：][
- $hat(delta)(q, epsilon) = q$
- $hat(delta)(q, x a) = delta(hat(delta)(q, x), a)$
]
== 非确定有穷自动机 (NFA)

#definition[NFA 形式化定义][
  非确定有穷自动机 (NFA) 为五元组 $A = (Q, Sigma, delta, q_0, F)$，其中转移函数为：
  $delta: Q times Sigma -> 2^Q$ （输出是一个状态集合）
]

#property[DFA 与 NFA 的等价性][
  如果语言 $L$ 被 NFA 接受，当且仅当 $L$ 被某个 DFA 接受。可通过 *子集构造法 (Subset Construction)* 将 NFA 转换为等价的 DFA。
]

#theorem[子集构造法 (Subset Construction) 步骤][
  1. *计算初始状态*：DFA 的起始状态是 $E C L O S E(q_0)$。
  2. *迭代计算转移表*：对于每一个新产生的 DFA 状态 $U$ (它是原 NFA 状态的集合)：
     - 对于字母表中的每个符号 $a in Sigma$：
     - 计算 $V = union_(s in U) delta(s, a)$。
     - 该转移后的新状态为 $V' = E C L O S E(V)$。
     - 如果 $V'$ 是新集合，将其加入 DFA 状态集。
  3. *确定终结态*：DFA 的终结态是所有包含至少一个原 NFA 终结态的集合。
]

#problem[
  设计一个有穷自动机，接受所有以 $01$ 结尾的由 $0$ 和 $1$ 构成的字符串。请分别给出其 NFA 和 DFA 实现。
]

#solution[
  NFA 实现 (直白简洁） \
  *设计思路*：NFA 允许状态转移的“非确定性”。我们可以让初始状态 $q_0$ 始终处理前缀，并在读到 $0$ 时“预测”这是倒数第二位。

  #figure(
    fig_1(),
    caption: [以 01 结尾的 NFA]
  )

  2. DFA 实现 (逻辑严密) \
  *设计思路*：DFA 必须记录当前的“进度”。我们需要通过不同的状态来代表当前后缀的情况。
  - $q_0$: 初始/后缀非 $0$。
  - $q_1$: 刚刚读入 $0$（后缀为 $0$）。
  - $q_2$: 刚刚读入 $01$（后缀为 $01$，接受态）。

  #figure(
    fig_2(),
    caption: [以 01 结尾的 DFA]
  )
]


#linebreak()
#linebreak()
#problem[（2022年）
  试构造接受下列语言的一个有限自动机（DFA、NFA 和 $epsilon$-NFA 任选），要求状态数不超过 10，且用状态转移图的方式给出答案。
  $ L = {w | w in {a, b}^*, |w| >= 3, w "最后三个字符中包含偶数个" b} $
]

#solution[
  这道题可以通过 NFA 或 DFA 两种方式解决。

  NFA 构造 \
  *设计思路*：让状态 $q_0$ 负责消耗掉字符串的前部，在任何时刻它都可以非确定性地开始匹配最后三个字符。
  - $q_0$ 读入 $a, b$ 后可以回到自身。
  - $q_0$ 也可以“猜测”接下来的三个字符是最后三个，分别根据输入转移到中间状态，最终到达接受态。
  - 符合条件的最后三位序列及其 $b$ 的个数：$a a a (0), a b b (2), b a b (2), b b a (2)$。
  *实际上可以化简状态，再优化一些状态数*
  #figure(
    fig_3(),
    caption: [接受满足条件语言的 NFA (状态数：8)]
  )
  
  *因此建议优先使用 NFA 解决此类“最后 $k$ 位”属性的问题。*
]

== 带空转移的 NFA ($epsilon$-NFA)

#definition[$epsilon$-NFA][
  允许在不消耗任何输入符号的情况下进行状态转移（即通过空串 $epsilon$ 转移）。
  $delta: Q times (Sigma union {epsilon}) -> 2^Q$
]

#note()[
  *直观理解*：$epsilon$-转移就像是机器内部的“免费跳变”或“自动触发”。当机器处于某个状态时，无需外界输入任何字符，它就可以“移动”到另一个状态。
]

#definition[状态的 $epsilon$-闭包 ("ECLOSE")][
  对于状态 $q$，$"ECLOSE"(q)$ 是指从 $q$ 开始，仅通过 $epsilon$ 转移所能到达的所有状态的集合（包括 $q$ 自身）。
  
  *计算规则*：
  1. $q in "ECLOSE"(q)$
  2. 若 $p in "ECLOSE"(q)$ 且存在转移 $p arrow.r^epsilon r$，则 $r in "ECLOSE"(q)$。
  3. 重复第 2 步直到集合不再扩大。
]

#remark[
  对于状态集 $S$，$"ECLOSE"(S) = union_(q in S) "ECLOSE"(q)$。
]

#note()[
  *前置知识：转换的“心理模型”* \
  要把 $epsilon$-NFA 变成 DFA，本质上是 *“消除不确定性”*：
  1.  *打包思维*：NFA 在读入一个字符后可能处于多个状态。我们将这些可能状态的 *所有组合* 看作是一个整体，给这个“包裹”取个名字（如 A, B, C）。
  2.  *带上随从*：由于有 $epsilon$ 转移，无论停在哪个状态，都必须立刻把能通过“免费路”到达的所有状态也算进来。这就是为什么每一道计算最后都要套一个 $E C L O S E$。
]

#problem[  将下图所示的 $epsilon$-NFA 转换为等价的 DFA。]

  
  #figure(
    fig_4(),
    caption: [待转换的 $epsilon$-NFA]
  )

#solution[
  *第一步：计算所有状态的 "ECLOSE"*
  - $"ECLOSE"(q_0) = {q_0}$ (无 $epsilon$ 边)
  - $"ECLOSE"(q_1) = {q_1, q_2, q_3}$ (通过 $q_1 arrow.r^epsilon q_2 arrow.r^epsilon q_3$ 连通)
  - $"ECLOSE"(q_2) = {q_2, q_3}$
  - $"ECLOSE"(q_3) = {q_3}$

#note()[
  *突击应试技巧：如何理解子集构造过程*
  - *A, B, C, D 是怎么确定的？*
    它们其实是 *集合的别名*。初始状态的 $E C L O S E$ 集合定义为 $A$。计算 $A$ 遇到 $0$ 或 $1$ 后的集合，如果产生了 *以前没见过的新组合*，就按顺序起名 $B, C, D...$。
  
  - *转移函数怎样算？*
    记住公式：$delta_D ("状态集", "字符") = E C L O S E ("该集合读入字符后能到的所有状态")$。
    比如算 $B$ 到 $0$ 的转移：先看 $B$ 里的每个状态读 $0$ 去了哪，结果合并后再求一次 $E C L O S E$（把“免费”跳步算进去）。
]

  *第二步：子集构造法 (从初始状态的 "ECLOSE" 开始)*
  1. *初始状态 A*：$A = "ECLOSE"(q_0) = {q_0}$
  2. *计算 A 的转移*：
     - $delta_D(A, 0) = "ECLOSE"(delta(q_0, 0)) = "ECLOSE"({q_0}) = {q_0} (A)$
     - $delta_D(A, 1) = "ECLOSE"(delta(q_0, 1)) = "ECLOSE"({q_0, q_1}) = "ECLOSE"(q_0) union "ECLOSE"(q_1) = {q_0, q_1, q_2, q_3} (B)$
  3. *计算新状态 B 的转移*：
     - $delta_D(B, 0) = "ECLOSE"(delta(q_0, 0) union delta(q_1, 0) union delta(q_2, 0) union delta(q_3, 0))$
       $= "ECLOSE"({q_0} union {q_2} union {q_3} union emptyset) = {q_0, q_2, q_3} (C)$
     - $delta_D(B, 1) = "ECLOSE"(delta(q_0, 1) union delta(q_1, 1) union delta(q_2, 1) union delta(q_3, 1))$
       $= "ECLOSE"({q_0, q_1} union {q_2} union {q_3} union emptyset) = {q_0, q_1, q_2, q_3} (B)$
  4. *计算新状态 C 的转移*：
     - $delta_D(C, 0) = "ECLOSE"({q_0, q_3}) = {q_0, q_3} (D)$
     - $delta_D(C, 1) = "ECLOSE"({q_0, q_1, q_3}) = {q_0, q_1, q_2, q_3} (B)$
  5. *计算新状态 D 的转移*：
     - $delta_D(D, 0) = "ECLOSE"({q_0}) = A$
     - $delta_D(D, 1) = "ECLOSE"({q_0, q_1}) = B$

  *第三步：确定终结状态*
  - 原 NFA 的终结状态是 $q_3$。
  - 凡是包含 $q_3$ 的新状态集合都是 DFA 的终结状态：$F_D = {B, C, D}$。

  *最终转移表*：
  #align(center, table(
    columns: (1.2fr, 1fr, 1fr),
    align: center,
    [$delta_D$], [$0$], [$1$],
    [$arrow.r A({q_0})$], [$A$], [$B$],
    [$* B({q_0, q_1, q_2, q_3})$], [$C$], [$B$],
    [$* C({q_0, q_2, q_3})$], [$D$], [$B$],
    [$* D({q_0, q_3})$], [$A$], [$B$],
  ))
  *最终得到的 DFA 状态转移图*：
  #figure(
    fig_5(),
    caption: [转换后的等价 DFA]
  )]

#note()[
  *考试得分关键 (Tips)*：
  1. *"ECLOSE" 不要漏掉自身*：$"ECLOSE"(q)$ 永远包含 $q$。
  2. *计算顺序*：先列表列出每个单状态的 "ECLOSE"，在子集构造时直接套用并集，能极大减少计算错误。
  3. *DFA 终结态*：转换后的 DFA 可能有多个终结态，只要对应集合里有一个原终结态，该子集状态就是终结态。
]


#problem[（2023年）

  设计一个 $epsilon$-NFA 表示以下语言：
  $ L = (w | w in (a,b)^*, |w| >= 1 "并且" w "中前两个字符和后两个字符 都 至少含有一个" a) $
  1. 请用状态转移图的方式给出答案。
  2. 并将上述 $epsilon$-NFA 转化为等价的 DFA。
]

#solution[
  *1. $epsilon$-NFA 构造*

  *深入解析学长的构造原理：为什么前缀部分可以用 $q_0 arrow.r^(a,b,epsilon) q_1 arrow.r^a q_2$ 表达？*
  这种设计极为巧妙、没有赘余。为了检查“前两个字符至少含有一个 $a$”，分以下几种情况：
  1. 如果第一个字符是 $a$：直接利用 $epsilon$-转移零代价划过 $q_0$，然后在 $q_1$ 读 $a$ 进入 $q_2$（共消耗1个字符，恰好是 $a$）。
  2. 如果第一个字符是 $b$：只能老老实实走 $q_0 arrow.r^b q_1$。此时要想到达 $q_2$，下一步*必须*是 $a$。所以相当于强制前缀只能是 `ba`（消耗2个字符）。
  3. 如果前两个是 `bb`：$q_0$ 读 $b$ 进 $q_1$ 后，面临第二个 $b$，因为 $q_1$ 没有 $b$ 的转移会直接“卡死”。
  这仅用 $3$ 个状态完美实现了合法前缀的甄别，并能将匹配部分干净利落地吃掉。

  *后缀对应拼接与短字符串兼顾*
  既然前缀结构搞定了，后缀条件“最后两个字符至少含有一个 $a$”完全是前者的镜像映射。我们只需要做对称的逆转拼合：$q_2 arrow.r^a q_3 arrow.r^(a,b,epsilon) q_4$（$q_4$ 为终结态）。
  - $q_2$ 提供 $a,b$ 自环，负责消耗前后缀之间任意中间段。
  - 对于长度只有1或2、导致前缀后缀重叠的情况（例如 `a`, `ab`, `ba` 等），同一颗 $a$ 即是前缀合格证明，又是后缀合格证明。对此只需增加一条 $q_1 arrow.r^a q_3$ 这一直达车（Bypass）完美解决。

  #figure(
    fig_6(),
    caption: [ $epsilon$-NFA图]
  )

  *2. 转换为等价 DFA* 
  依据上述 5 状态 NFA 进行子集构造。注意到 $q_3 arrow.r^epsilon q_4$ ，所以只要闭包包含 $q_3$ 就必带 $q_4$。

  *逐步推导过程：*
  1. *ECLOSE 闭包计算*：
     - $E C L O S E (q_0) = \{q_0, q_1\}$ （根据 $q_0 arrow.r^epsilon q_1$）
     - $E C L O S E (q_1) = \{q_1\}$
     - $E C L O S E (q_2) = \{q_2\}$
     - $E C L O S E (q_3) = \{q_3, q_4\}$ （根据 $q_3 arrow.r^epsilon q_4$）
     - $E C L O S E (q_4) = \{q_4\}$

  2. *子集构造步骤 (Subset Construction)*：
     - *起始状态* $D_0 = E C L O S E (q_0) = \{q_0, q_1\}$
     - *计算* $D_0 \x arrow.r{a}$：$delta(q_0, a)=\{q_1\}, delta(q_1, a)=\{q_2, q_3\}$，则 $E C L O S E(\{q_1, q_2, q_3\}) = \{q_1, q_2, q_3, q_4\}$。记为 $D_A$。
     - *计算* $D_0 \x arrow.r{b}$：$delta(q_0, b)=\{q_1\}, delta(q_1, b)=emptyset$，则 $E C L O S E(\{q_1\}) = \{q_1\}$。记为 $D_B$。
     - *计算* $D_B \x arrow.r{a}$：$delta(q_1, a)=\{q_2, q_3\}$，则 $E C L O S E(\{q_2, q_3\}) = \{q_2, q_3, q_4\}$*。由于此状态后续转移行为与 $D_A$ 完全一致且同为终结态，在 DFA 中合并并统一记为 $D_A$*。
     - *计算* $D_A \x arrow.r{b}$：$delta(q_2, b)=\{q_2\}, delta(q_3, b)=\{q_4\}$，则 $E C L O S E(\{q_2, q_4\}) = \{q_2, q_4\}$。记为 $D_C$。
     - *计算* $D_C \x arrow.r{b}$：$delta(q_2, b)=\{q_2\}, delta(q_4, b)=emptyset$，则 $E C L O S E(\{q_2\}) = \{q_2\}$。记为 $D_D$。
     - *计算* $D_D \x arrow.r{b}$：$delta(q_2, b)=\{q_2\}$，结果仍为 $D_D$。
     - *所有状态遇 $a$*：均会包含 $\{q_2, q_3\}$，闭包后均走向 $D_A$。

  *最终状态定义：*
  - $D_0 = \{q_0, q_1\}$
  - $D_A = \{q_1, q_2, q_3, q_4\}$ (或 $\{q_2, q_3, q_4\}$)
  - $D_B = \{q_1\}$ 
  - $D_C = \{q_2, q_4\}$
  - $D_D = \{q_2\}$
  - $"Dead" = emptyset$

  #align(center, table(
    columns: (1fr, 1fr, 1fr),
    align: center,
    [$delta_D$], [$a$], [$b$],
    [$arrow.r D_0$], [$D_A$], [$D_B$],
    [$D_B$], [$D_A$], [$"Dead"$],
    [$* D_A$], [$D_A$], [$D_C$],
    [$* D_C$], [$D_A$], [$D_D$],
    [$D_D$], [$D_A$], [$D_D$],
    [$"Dead"$], [$"Dead"$], [$"Dead"$],
  ))

  #figure(
    fig_7(),
    caption: [转换后的等价最小 DFA]
  )
]

#problemset[
  #problem[（2023年判断题）DFA 中状态的转移是确定的, 而 NFA 中一次状态可能转移到多个状态, 因此 NFA 具有更强的语言表示能力。]
  #solution[
    ×（错误）。DFA 和 NFA 在识别语言的能力上是等价的。任何 NFA 都可以通过子集构造法转化为等价的 DFA。
  ]
  #note[
    *突击笔记*：有穷自动机的核心在于其“有穷性”。虽然 NFA 在设计上比 DFA 更灵活（非确定性），但在数学表达上，通过子集构造法可以将任何 NFA 转换为 DFA。\
    记住：*有穷自动机（无论是否确定）识别的都是正则语言*。
  ]
]

= 正则表达式与正则语言

#introduction[正则表达式定义][正则语言与 FA 的转换][代数定律]

#definition[正则表达式 (RE)][
  递归定义：
  1. *基础步骤*：$epsilon$ 表示语言 ${epsilon}$；$emptyset$ 表示空语言 $emptyset$；$a$ 表示语言 ${a}$。
  2. *归纳步骤*：若 $r, s$ 分别表示语言 $L(r), L(s)$，则：
    - $r+s$ 表示 $L(r) union L(s)$（并）
    - $r s$ 表示 $L(r) L(s)$（连接）
    - $r^*$ 表示 $L(r)^*$（克林闭包）
    - $(r)$ 表示 $L(r)$
]

#note[
  *优先级*：括号 $>$ 星运算 (\*) $>$ 连接运算 (\.) $>$ 加运算 (+)。
  例：$1+0 1^* = 1+(0(1^*))$。
]

#property[正则表达式的代数定律][
  - *并*：交换律 $r+s=s+r$，结合律 $(r+s)+t=r+(s+t)$，幂等律 $r+r=r$，单位元 $r+emptyset=r$。
  - *连接*：结合律 $(r s)t=r(s t)$，左分配律 $r(s+t)=r s+r t$，右分配律 $(s+t)r=s r+t r$。
  - *单位元与零元*：$epsilon r = r epsilon = r$（单位元），$emptyset r = r emptyset = emptyset$（零元）。
  - *闭包定律*：$(r^*)^* = r^*$，$emptyset^* = epsilon$，$epsilon^* = epsilon$，$(r+s)^* = (r^* s^*)^*$。
]

#theorem[Kleene 定理][
  正则表达式与其对应的正则语言在表达能力上与有穷自动机等价。
]

#note[
  *转换方法*：
  - *RE -> FA*：Thompson 构造法（结构化递归构造）。
  - *FA -> RE*：
    1. *状态消除法*：逐个消除中间状态，更新边上的正则表达式。公式：$R_(i j)^(k) = R_(i j)^(k-1) + R_(i k)^(k-1) (R_(k k)^(k-1))^* R_(k j)^(k-1)$。简单记：新路径 = 旧路径 + (入边 $times$ 自环的星闭包 $times$ 出边)。
    2. *递归法/阿登引理 (Arden's Lemma)*：求解线性方程 $X = A X + B$，若 $epsilon in.not A$，则唯一解为 $X = A^* B$。
]

#remark[
  *期末考突击技巧*：
  - *状态消除法*：选择入度或出度较小的状态优先消除，可以简化最终的 RE 表达式。
  - *Arden 引理*：在处理简单的 DFA 转换时非常快，列出每个状态的方程：$q_i = sum a_{i j} q_j + (epsilon "if" q_i in F)$。
]


#problem[
  请给出语言“不含 3 的奇数数字字符串”的正则表达式及文法，字符串允许以 $0^*$ 开头。(2022年)
]

#solution[
  - *字母表*：$Sigma = {0, 1, 2, 4, 5, 6, 7, 8, 9}$
  - *奇数数字*：末尾必须是 $\{1, 5, 7, 9\}$（排除 3）。
  - *正则表达式*：
    $ r = (0 | 1 | 2 | 4 | 5 | 6 | 7 | 8 | 9)^* (1 | 5 | 7 | 9) $
    考虑到 $0^*$ 开头（实际已包含在前面的闭包中），也可显式写出：
    $ r = 0^* (0 | 1 | 2 | 4 | 5 | 6 | 7 | 8 | 9)^* (1 | 5 | 7 | 9) $
]

#remark[
  *应考方式*：
  - *排除法*：注意“不含 3”意味着所有位置的备选数字都要剔除 3。
  - *末位判定*：在十进制下，“奇数”仅由末位数字决定。
  - *文法构造*：右线性文法 $A -> a B$ 代表状态转移， $A -> a$ 代表在产生 $a$ 后进入接受状态（结束）。
]
#linebreak()
#linebreak()
#problem[
  请给出下列语言的一个正则表达式：
  $L = {w | w in {0, 1}^*, w "至多含有 2 个子串 01"}$。(2022年)
]

#solution[
  *分析*：
  “至多含有 2 个 01”表示含有 0 个、1 个或 2 个 01 子串。
  1. *不含 01*：即所有 1 都在 0 之前，正则表达式为 $1^* 0^*$。
  2. *恰好 $k$ 个 01*：每增加一个 01，相当于在 $1^* 0^*$ 的基础上，跳转一次并重新进入一个不含 01 的结构。
  
  *正则表达式*：
  $ r = 1^* 0^* (epsilon | 01 1^* 0^* | 01 1^* 0^* 01 1^* 0^*) $
  或者更简洁地写成：
  $ r = 1^* 0^* 1^* 0^* 1^* 0^* $
]

#note[
  *期末突击技巧*：
  对于“至多 $n$ 次出现”题目，构造核心是：
  1. 找出“基础块” (即 $0$ 次出现的模式，此处为 $1^* 0^*$)。
  2. 使用“基础块 + (目标子串 + 基础块)”的模式进行重复扩展。
]

= 正则语言的性质

#introduction[泵引理][封闭性][判定性][DFA 最小化]

#theorem[正则语言的泵引理 (Pumping Lemma)][
  若 $L$ 是正则语言，存在常数 $n$（泵长度），使得对任何 $|w| >= n$ 的 $w in L$，可写成 $w = x y z$，满足：
  1. $y != epsilon$（即 $|y| > 0$）
  2. $|x y| <= n$
  3. 对所有 $k >= 0$, $x y^k z in L$
]

#note[
  *原理*：基于*鸽巢原理*。若 DFA 有 $n$ 个状态，处理长度为 $n$ 的字符串会经过 $n+1$ 个状态，必有状态重复，从而形成环（即 $y$）。
  *用途*：用于证明一个语言 *不是* 正则语言（利用反证法）。
]

#example[证明 $L = {0^n 1^n | n >= 1}$ 不是正则语言]

#solution[
  1. 假设 $L$ 是正则的。设 $n$ 为泵长度。
  2. 取 $w = 0^n 1^n in L$。
  3. 由泵引理，$w = x y z$ 且 $|x y| <= n, y != epsilon$。
  4. 由于 $|x y| <= n$，$y$ 必须完全由 $0$ 组成。
  5. 令 $k=0$ 或 $k=2$，则 $x z$ 或 $x y^2 z$ 中 $0$ 与 $1$ 的个数不再相等，即 $x y^k z in.not L$，产生矛盾。
  6. 因此 $L$ 不是正则语言。
]

#problem[
  （2023年）语言 $L = {0^n 1^m | 0 <= m < n}$ 是否为正则语言？若是请写出其正则表达式；若不是请说明理由。
]

#solution[
  该语言 *不是* 正则语言。可以通过泵引理证明。

  *证明 (泵引理)*：
  1. 假设 $L$ 是正则语言，设其泵长度为 $p$。
  2. 选取字符串 $w = 0^p 1^(p-1)$。显然 $w in L$（因为 $p-1 < p$）且 $|w| >= p$。
  3. 根据泵引理，$w$ 可拆分为 $x y z$，满足 $|x y| <= p, |y| > 0$。
  4. 由于 $|x y| <= p$，字符串 $y$ 完全由 $0$ 组成。设 $y = 0^i$，其中 $i >= 1$。
  5. 考虑 *泵下 (Pump down)*，令 $k = 0$，则字符串为 $x z$。
  6. $x z$ 中 $0$ 的个数为 $p - i$， 而 $1$ 的个数仍为 $p - 1$。
  7. 由于 $i >= 1$，则 $p - i <= p - 1$。
     - 若 $i = 1$，则 $0$ 的个数等于 $1$ 的个数，不符合 $m < n$。
     - 若 $i > 1$，则 $0$ 的个数小于 $1$ 的个数，不符合 $m < n$。
  8. 无论何种情况，$x z in.not L$，与泵引理矛盾。故 $L$ 不是正则语言。

  *突击提示*：
  - 在泵引理证明中，若选取 $k=2$（泵上）无法推导出矛盾（因为 $0$ 变多依然满足 $n > m$），则必须考虑 $k=0$（泵下）使数量对比发生反转。
]

#property[正则语言的封闭性][
  正则语言在以下运算下均封闭：
  - *布尔运算*：并 ($L union M$)、交 ($L inter M$)、补 ($Sigma^* - L$)、差 ($L - M$)。
  - *连接运算*：连接 ($L M$)、克林闭包 ($L^*$)。
  - *转换运算*：反转 ($L^R$)、同态 ($h(L)$)、逆同态 ($h^(-1)(L)$)。
]

#example[利用封闭性质证明非正则语言][
  证明语言 $L = {w in {0, 1}^* | w text("中 0 和 1 的个数相等")}$ 不是正则语言。
]

#solution[
  1. 假设 $L$ 是正则语言。
  2. 我们已知 $L_{01} = 0^* 1^*$ 是正则语言（可以用正则表达式表示）。
  3. 根据封闭性，正则语言的交集 $L inter L_{01}$ 必须也是正则语言。
  4. 然而 $L inter L_{01} = {0^n 1^n | n >= 0}$，通过泵引理已证该语言不是正则语言。
  5. 产生矛盾，故 $L$ 不是正则语言。
]

#note[
  *突击技巧*：
  - 如果一个语言看起来很“乱”（比如 0 和 1 随意分布），直接用泵引理可能很难选取 $w$。
  - 此时先用 *交集* 运算（通常是交上 $0^* 1^*$）将其简化为整齐形式，再引用已知非正则语言（如 $0^n 1^n$）得出矛盾。
]

#note[
  *特殊封闭性说明*：
  - *同态*：$h$ 将每个符号映射为一个字符串。若 $L$ 正则，替换 $L$ 中所有符号得到的 $h(L)$ 仍正则。
  - *逆同态*：若 $L$ 正则，所有经同态 $h$ 映射后落在 $L$ 中的原始字符串集体 $h^(-1)(L)$ 仍正则。
]

#note[
  *判定性质 (Decision Properties)*：
  - *空性 (Emptiness)*：$L = emptyset$? 算法：从起始态开始进行图遍历（BFS/DFS），检查是否能到达任何终态。
  - *成员资格 (Membership)*：$w in L$? 算法：若为 DFA，直接运行 $w$；若为 NFA，可用子集构造思想或闭包运算辅助。
  - *有穷性 (Finiteness)*：算法：先去除所有无法从起始态到达或无法到达终态的状态，然后检查剩余图中是否有环。若有环则为无穷语言。
  - *等价性 (Equivalence)*：$L = M$? 算法：构造最小 DFA 后比较；或者构造 $L Delta M = (L - M) union (M - L)$，判断其是否为空。
]

#definition[DFA 最小化 (DFA Minimization) #text(fill:red)[24级明确不考]][
  *状态等价性*：若从状态 $p$ 和 $q$ 出发，输入任何字符串 $w$ 后的接受结果相同，则 $p, q$ 等价。

  *填表算法 (Table-filling Algorithm)*：
  1. 画出所有状态对 $[p, q]$ 的表格。
  2. *基础步骤*：标记所有一个状态在 $F$ 中而另一个不在 $F$ 中的对 $[p, q]$（即终态与非终态必可区分）。
  3. *归纳步骤*：若存在字符 $a in Sigma$ 使得 $[delta(p, a), delta(q, a)]$ 已被标记，则标记 $[p, q]$。
  4. 重复此过程，直到没有新标记。
  *合并*：将未标记的状态对合并为同一个状态。
]


#problemset[
  #problem[（2023年判断题）若某语言满足正则语言的泵引理, 则该语言一定是正则语言。]

  #solution[
    ×（错误）。泵引理是正则语言的 *必要条件* 而非充分条件。存在满足泵引理但非正则的语言。
  ]

  #problem[（2023年判断题）正则语言在并运算和交运算下是封闭的, 但在补和差运算下不封闭。]

  #solution[
    ×（错误）。正则语言在布尔运算（并、交、补、差）下都是封闭的。
  ]

  #problem[（2023年判断题）给定两个有穷自动机, 存在判定两者等价性的算法。]

  #solution[
    √（正确）。算法是将两个 FA 最小化，或者构造其对称差语言并判断是否为空（$L_1 Delta L_2 = emptyset$）。
  ]

  #problem[（2023年判断题）正则语言的无穷性是不可判定的。]

  #solution[
    ×（错误）。可判定性：检查 DFA 中是否存在能从起始态到达并能到达终结态的环（或检查是否存在长度 $l$ 满足 $n <= l < 2n$ 的串）。
  ]
]

= 上下文无关文法 (CFG)

#introduction[CFG 定义][派生树][歧义性]

#definition[CFG 形式化定义][
  CFG 为四元组 $G = (V, T, P, S)$：
  - $V$：变元集（非终结符）
  - $T$：终结符集
  - $P$：产生式集，形式为 $A -> alpha$
  - $S$：开始变元
]


#problem[
  试给出下列语言的一个上下文无关文法。
  $ L = {a^n b^m c^p d^q | n + m = p + q} $
]
#solution[
  *解题思路*（剥洋葱法）：
  $n+m = p+q$ 意味着前两类字符总数等于后两类字符总数。由于要求 $a,b,c,d$ 的顺序，我们可以由外向内进行“匹配平衡”：
  1. *外层平衡*：使用 $a S d$ 消耗掉成对的 $a$ 和 $d$。
  2. *差值补偿*：当 $a$ 和 $d$ 不等量时：
    - 若 $a$ 多于 $d$ ($n>q$)，多出的 $a$ 必须与 $c$ 配对（即 $a A c$）。
    - 若 $d$ 多于 $a$ ($q>n$)，多出的 $d$ 必须与 $b$ 配对（即 $b B d$）。
  3. *内层平衡*：最后剩余的 $b$ 必须与 $c$ 配对（即 $b C c$）。

  *文法设计*：
  $ S &-> a S d | A | B \
    A &-> a A c | C \
    B &-> b B d | C \
    C &-> b C c | epsilon $
    
  *应考笔记*：
  此类题目若直接嵌套往往会导致顺序混乱（如原设计中 $C -> b C d$ 会让 $d$ 出现在 $c$ 内部）。
  通过 *分路径平衡* （$A$ 路径处理 $n>q$，$B$ 路径处理 $q>n$）可以完美兼顾“等量性”和“顺序性”。
]



== 上下文无关文法的简化

#note[
  *简化步骤建议*：
  1. *消除 $epsilon$-产生式*：找到所有可空的非终结符。
  2. *消除单元产生式*：消除形如 $A -> B$ 的产生式。
  3. *消除无用符号*：
    - *首先*：删除 *非生成符号*（无法导出终结符串的变量）及其相关产生式。
    - *其次*：删除 *不可达符号*（从 $S$ 出发无法到达的变量）。
]

#problem[
  给定文法 $G = (V, Sigma, P, S)$，其中： \
  $V = {S, A, B, C, D}$ \
  $Sigma = {a, b, c}$ \
  $P = { S -> A B C | a B C, A -> A a | epsilon, B -> b B | epsilon, C -> c C | c, D -> d D | d }$ \
  请化简上述文法。
]

#solution[
  *步骤 1：消除 $epsilon$-产生式*
  - 可空非终结符为 ${A, B}$。
  - 对于 $S -> A B C | a B C$，考虑 $A, B$ 分别为空或同时为空的情况，得到：
    $S -> A B C | B C | A C | C | a B C | a C$
  - 对于 $A -> A a | epsilon$，得到：$A -> A a | a$
  - 对于 $B -> b B | epsilon$，得到：$B -> b B | b$
  
  *步骤 2：消除单元产生式*
  - 存在单元产生式 $S -> C$。用 $C$ 的右部 ${c C, c}$ 替换之。
  - 得到 $S -> A B C | B C | A C | c C | c | a B C | a C$。

  *步骤 3：消除无用符号*
  - *非生成符号*：由于 $Sigma = {a, b, c}$，产生式 $D -> d D | d$ 产生的字符 $d$ 不在 $Sigma$ 中，故 $D$ 为非生成符号，将其删除。
  - *不可达符号*：遍历发现 $S, A, B, C$ 均可从 $S$ 到达。

  *最终化简结果*：
  - $V' = {S, A, B, C}$
  - $P' = { \
    S -> A B C | B C | A C | c C | c | a B C | a C, \
    A -> A a | a, \
    B -> b B | b, \
    C -> c C | c \
  }$
]

#problemset[
  #problem[（2023年判断题）对于一个有歧义的上下文无关文法, 一定可以消除歧义。]

  #solution[
    ×（错误）。存在先天歧义（Inherently Ambiguous）的上下文无关语言（如 $L = {a^n b^n c^m} union {a^n b^m c^m}$），其任何文法都必定是歧义的。
  ]
]

= 下推自动机 (PDA)

#introduction[PDA 定义][瞬时描述][等价性]

#definition[PDA 形式化定义][
  PDA 为七元组 $P = (Q, Sigma, Gamma, delta, q_0, Z_0, F)$：
  - $Gamma$：堆栈字母表
  - $Z_0$ : 栈底符号
  - $delta: Q times (Sigma union {epsilon}) times Gamma -> 2^(Q times Gamma^*)$
]

#definition[瞬时描述 (ID)][
  为描述 PDA 在某一时刻的格局，使用三元组 $(q, w, gamma)$ 表示：
  - $q$：当前状态。
  - $w$：*剩余*的输入字符串
  - $gamma$：当前的栈内容字符串（左侧为栈顶，右侧为栈底）。

  *转移关系*：若 $(p, beta) in delta(q, a, X)$，则有瞬时描述转移 $(q, a w, X alpha) tack.r (p, w, beta alpha)$。
  - 注意区别：转移函数中的 $a$ 是*当前读入的一个字符*，而 ID 中的 $w$ 是*后续没读完的整个字符串*。
]

#note[应考：如何读懂转移方程 $delta(q, a, X) = {(p, beta)}$][
  该方程表示：在状态 $q$ 下，读入字符 $a$，栈顶为 $X$ 时，转移到状态 $p$，并将栈顶的 $X$ *整体替换*为 $beta$。
  - *压栈*：$beta$ 比 $X$ 长。如 $delta(q_0, 0, Z_0) = {(q_0, 0 Z_0)}$，表示在 $Z_0$ 上方压入一个 $0$（新的栈内容为 $0Z_0$）。
  - *弹栈*：$beta = epsilon$。如 $delta(q_1, 1, 0) = {(q_1, epsilon)}$，表示将栈顶的 $0$ 弹出，栈变短。
  - *不变*：$beta = X$。如 $delta(q_1, epsilon, Z_0) = {(q_2, Z_0)}$，表示栈顶符号不变（仅改变状态）。
  - *修改*：$beta$ 是另一个符号。如 $delta(q, a, X) = {(p, Y)}$，表示把栈顶的 $X$ 换成 $Y$。
]

#figure(
  image("../assets/automachine/Page_9.png", width: 70%),
  caption: [PDA 的抽象装置模型]
)

#theorem[PDA 与 CFG 的等价性][
  一个语言是上下文无关语言，当且仅当它能被某个下推自动机接受。
]

#example(title: [课本原题])[构造 PDA 识别 $L = {0^n 1^n | n >= 1}$]

#solution[
  *思路*：
  - 读入 $0$ 时全部压入栈中。
  - 每读入一个 $1$，从栈中弹出一个 $0$。
  - 输入结束且栈中刚好剩下初始符号 $Z_0$ 时，通过 $epsilon$ 转移进入接受状态。

  *转移方程*：
  1. $delta(q_0, 0, Z_0) = {(q_0, 0 Z_0)}$ 
  2. $delta(q_0, 0, 0) = {(q_0, 0 0)}$ 
  3. $delta(q_0, 1, 0) = {(q_1, epsilon)}$ 
  4. $delta(q_1, 1, 0) = {(q_1, epsilon)}$ 
  5. $delta(q_1, epsilon, Z_0) = {(q_2, Z_0)}$ 

  #figure(
    fig_8(),
    caption: [识别 $0^n 1^n (n >= 1)$ 的 PDA 状态转换图]
  )
  
  *ID 推导示例 (输入 $0011$)*：
  $(q_0, 0011, Z_0) tack.r (q_0, 011, 0Z_0) tack.r (q_0, 11, 00Z_0) tack.r (q_1, 1, 0Z_0) tack.r (q_1, epsilon, Z_0) tack.r (q_2, epsilon, Z_0)$
  最后到达终态 $q_2$ 且输入已读完，接受！
]
#linebreak()
#linebreak()

#example[构造 PDA 识别 $L = {0^n 1^n | n > 1}$   注意本题 n > 1 的约束]

#solution[
  *思路方案*：
  - 核心逻辑：利用堆栈记录 $0$ 的个数，遇到 $1$ 时依次弹出。
  - $n > 1$ 约束：通过状态转移 $q_0 -> q_1 -> q_2$ 强制要求前两个字符必须是 $0$。

  *转移方程设计*：
  1. $delta(q_0, 0, Z_0) = {(q_1, X Z_0)}$ （读第 1 个 0，压入 $X$）
  2. $delta(q_1, 0, X) = {(q_2, X X)}$ （读第 2 个 0，压入 $X$，确保 $n >= 2$）
  3. $delta(q_2, 0, X) = {(q_2, X X)}$ （后续 $0$ 继续压栈）
  4. $delta(q_2, 1, X) = {(q_3, epsilon)}$ （遇到 1，开始弹出 $X$）
  5. $delta(q_3, 1, X) = {(q_3, epsilon)}$ （持续弹出 $X$ 匹配 1）
  6. $delta(q_3, epsilon, Z_0) = {(q_f, Z_0)}$ （栈空且输入结束，进入接受状态）

  #figure(
    fig_9(),
    caption: [识别 $0^n 1^n (n>1)$ 的 PDA 状态转换图]
  )

  *应考笔记*：
  - *入栈判定*：$a^n b^n$ 型必用堆栈。
  - *次数限制*：通过增加中间状态（如 $q_1$）来“计数”最小必需的字符数。
]


#remark[
  *为什么课本图示只用 3 个状态？*
  - *核心逻辑*：课本图示通常是识别 $L = {0^n 1^n | n >= 1}$（即 $n$ 为正整数即可）。
    - $q_0$：入栈阶段（$0^n$）。
    - $q_1$：出栈阶段（$1^n$）。
    - $q_2$：接受状态。
  - *$n > 1$ 的精确解*：
    - 我们之前的示例要求 $n > 1$。为了保证系统至少读入两个 $0$，我们通过“状态链” ($q_0 -> q_1 -> q_2$) 强行消耗了输入，这就像是给系统加了前置检查。
    - 如果不要求 $n > 1$，或者允许用栈顶符号判断（较为复杂），则可以用 3 个状态。
]

== 下推自动机接受的语言

#definition[PDA 的两种接受方式][
  PDA 接受语言有两种等价的方式：

  1. *终态接受 (Acceptance by Final State)*：
     只要 PDA 到达 $F$ 中的某个状态，且输入已完全消耗，即认为接受。
     $L(P) = {w | (q_0, w, Z_0) |-* (p, epsilon, gamma), p in F}$

  2. *空栈接受 (Acceptance by Empty Stack)*：
     只要 PDA 的栈变为空（不论当前状态是否为 $F$），且输入已完全消耗，即认为接受。
     $N(P) = {w | (q_0, w, Z_0) |-* (p, epsilon, epsilon)}$
]

#theorem[两种接受方式的等价性][
  - 对任意以终态方式接受语言的 PDA $P_F$，存在以空栈方式接受相同语言的 PDA $P_N$。
  - 对任意以空栈方式接受语言的 PDA $P_N$，存在以终态方式接受相同语言的 PDA $P_F$。
]

#note[
  转换技巧：$L(P)$ 与 $N(P)$ 的互换

  *1. 终态转空栈 ($L arrow.r N$)*：
  - *操作*：引入新起始状态 $q_s$、清空状态 $q_e$ 及新栈底 $X_0$。
  - *逻辑*：$q_s$ 压入 $Z_0 X_0$ 并转到原起始态。在原所有终态 $f in F$ 处，增加 $epsilon$ 转移：$delta(f, epsilon, "任意") = (q_e, epsilon)$。$q_e$ 负责弹出栈中所有剩余符号。

  *2. 空栈转终态 ($N arrow.r L$)*：
  - *操作*：引入新起始状态 $q_s$、新终态 $q_f$ 及新栈底 $X_0$。
  - *逻辑*：$q_s$ 压入 $Z_0 X_0$。当读取到栈底 $X_0$ 时（意味着原栈已排空），转移到 $q_f$。
]

#definition[确定性下推自动机 (DPDA) #text(fill:red)[24级明确不考]][
  若 PDA $P$ 满足以下条件，则称之为 DPDA：
  1. 对任何 $q in Q, a in Sigma union {epsilon}, X in Gamma$，其转移函数 $delta(q, a, X)$ 的结果集大小至多为 1。
  2. 如果 $delta(q, a, X)$ 非空，则 $delta(q, epsilon, X)$ 必须为空（即读入字符和 $epsilon$ 转移不能共存）。

  *重要性质*：
  - $L("DPDA") subset L("PDA")$。DPDA 只能识别 *确定性上下文无关语言 (DCFL)*。
  - 例子：$L = {w c w^R | w in {0,1}^*}$ 是 DCFL（可以用 DPDA），但 $L = {w w^R | w in {0,1}^*}$ 不是 DCFL（必须用 NPDA，因为无法预测中点）。
]

#theorem[从 CFG 构造 PDA 的算法（常用考点）][
  给定 CFG $G = (V, T, P, S)$，构造一个单状态空栈接受 PDA $P = ({q}, T, V union T, delta, q, S)$：
  1. 对于每个产生式 $A -> alpha in P$，添加转移：$delta(q, epsilon, A)$ 包含 $(q, alpha)$。
  2. 对于每个终结符 $a in T$，添加转移：$delta(q, a, a) = {(q, epsilon)}$。
  
  *核心思想*：在栈中模拟最左推导。变量被其右部替换，终结符则与输入匹配并弹出。
]


#note[
  *应考要点*：
  - 一般题目默认使用终态接受。
  - 设计空栈接受 PDA 时，通常需要引入新的栈底符号 $X_0$ 以防止模拟过程中栈“提前变空”。
]

== 特殊文法与 PDA 构造技巧

=== 1. 回文与非回文的 CFG 设计
- *回文 (Palindromes) $L = {w | w = w^R}$*：
  $ S -> a S a | b S b | a | b | epsilon $
- *非回文 (Non-palindromes) $L = {w | w \neq w^R}$*：
  *核心思想*：必有一对位置 $i$ 和从末尾数的 $i$ 字符不同。
  $ S &-> a S a | b S b | a A b | b A a \
    A &-> a A | b A | epsilon $
  - 前两项 $a S a, b S b$ 用于在首尾递归寻找那一对“不相等”的字符。
  - 后两项 $a A b, b A a$ 用于捕捉那一对“不相等”的字符。
  - $A$ 产生式填充锁定的那对字符之间的任何内容。

=== 2. 从 CFG 构造终态接受 PDA 的通用模板
若要在考试中根据文法快速写出 *终态接受 (Final State)* 的 PDA，遵循这个三段式结构：

1. *初始态 ($q_0 \to q$)*：
   - $delta(q_0, epsilon, Z_0) = {(q, S Z_0)}$ —— 压入开始符号 $S$ 进入模拟状态。
2. *模拟态 ($q \to q$)*：
   - *推导 (Expand)*：对所有文法产生式 $A -> alpha$，添加 $delta(q, epsilon, A) = {(q, alpha)}$。
   - *匹配 (Match)*：对字母表所有字符 $x$，添加 $delta(q, x, x) = {(q, epsilon)}$。
3. *终态 ($q \to q_f$)*：
   - $delta(q, epsilon, Z_0) = {(q_f, Z_0)}$ —— 栈清空回栈底，进入终态。


  #problem[（2024年）构造下述语言的一个以终态方式接受的 PDA:
    $L = {w | w in {a, b}^*, w != w^R, w^R "是" w "的反向串"}$
  ]

  #solution[
    先给出该语言的上下文无关文法 (CFG)，再利用“文法转 PDA”的标准构造法。
    
    1. *CFG 设计*：$w \neq w^R$ 意味着至少存在一对字符在平衡位置上不相等。
       - $S -> a S a | b S b | a A b | b A a$ （由于 $a...a$ 和 $b...b$ 匹配，递归向下直到发现不匹配对 $a...b$ 或 $b...a$）
       - $A -> a A | b A | epsilon$ （中间可以是任意字符串）
    
    2. *PDA 构造*：采用模拟最左派生的标准方法，并将“空栈接受”转换为“终态接受”。
       - 引入状态：$q_0$ (开始状态), $q$ (模拟状态), $q_f$ (接受状态)。
       - 栈操作：初始在栈底压入 $Z_0$，并在上方压入 $S$。
    
    #figure(
      fig_10(),
      caption: [基于 CFG 等价变换构造的 PDA ]
    )

    *Trace 示例 ($w = "aaba"$)*：
    #table(
      columns: (auto, auto, auto),
      align: (left, left, left),
      stroke: none,
      [*ID (状态, 剩余输入, 栈)*], [*推导/匹配操作*], [*备注*],
      [$(q_0, "aaba", Z_0)$], [初始状态], [],
      [$(q, "aaba", S Z_0)$], [$epsilon, Z_0 \/ S Z_0$], [初始化压入 $S$],
      [$(q, "aaba", a S a Z_0)$], [$epsilon, S \/ a S a$], [猜测首尾 $a...a$ 匹配],
      [$(q, "aba", S a Z_0)$], [$a, a \/ epsilon$], [匹配弹出 $a$],
      [$(q, "aba", a A b a Z_0)$], [$epsilon, S \/ a A b$], [锁定不匹配对 $a...b$],
      [$(q, "ba", A b a Z_0)$], [$a, a \/ epsilon$], [匹配弹出 $a$],
      [$(q, "ba", b a Z_0)$], [$epsilon, A \/ epsilon$], [$A$ 展开为空串],
      [$(q, "a", a Z_0)$], [$b, b \/ epsilon$], [匹配弹出 $b$],
      [$(q, epsilon, Z_0)$], [$a, a \/ epsilon$], [匹配弹出 $a$],
      [$(q_f, epsilon, Z_0)$], [$epsilon, Z_0 \/ Z_0$], [进入终态接受],
    )
  ]
  
#linebreak()
#linebreak()

#problem[ 请给出下列语言的文法，并根据文法构造相应的 PDA。
  $ L = {a^n b^m | 3m <= 2n <= 5m} $
]

#solution[
  条件 $3m <= 2n <= 5m$ 等价于 $1.5m <= n <= 2.5m$。
  - 对于偶数个 $b$（设 $m=2k$），有 $3k <= n <= 5k$。
  - 对于奇数个 $b$（设 $m=2k+1$），有 $3k+1.5 <= n <= 5k+2.5$，即 $n$ 可以取中的整数。
  
  *文法设计*：
  利用递归构造。基本块为“2个 $b$ 配对 $3, 4, 5$ 个 $a$”，再加上处理奇数个 $b$ 的情况。
  $ S &-> a^3 S b^2 | a^4 S b^2 | a^5 S b^2 | A \
    A &-> a^2 b | epsilon $
  *(注：当 $m=1$ 时，$n=2$ 满足 $3 <= 4 <= 5$)*

  *PDA 设计思路*：
  - 每个 $a$ 压入 2 个 $X$（栈中总数为 $2n$）。
  - 每个 $b$ 非确定性地弹出 $3, 4, 5$ 个 $X$。
  
  #align(center)[
    #diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      node((0,0), $q_0$, extrude: (0, 0)),
      edge((0,0), (0,0), $a, Z_0 \/ X X Z_0$, "->", bend: 130deg),
      edge((0,0), (0,0), $a, X \/ X X X$, "->", bend: -130deg),
      
      node((2,0), $p_1$),
      edge((0,0), (2,0), $b, X \/ epsilon$, "->"),
      
      node((4,0), $p_2$),
      edge((2,0), (4,0), $epsilon, X \/ epsilon$, "->"),
      
      node((6,0), $p_3$),
      edge((4,0), (6,0), $epsilon, X \/ epsilon$, "->"),
      
      node((8,0), $q_1$),
      edge((6,0), (8,0), $epsilon, epsilon \/ epsilon$, "->"),
      edge((6,0), (8,0), $epsilon, X \/ epsilon$, "->", bend: 40deg),
      
      node((7, 1.5), $p_4$),
      edge((6,0), (7, 1.5), $epsilon, X \/ epsilon$, "->", bend: -20deg),
      edge((7, 1.5), (8,0), $epsilon, X \/ epsilon$, "->", bend: -20deg),

      edge((8,0), (5, -1.5), (2,0), $b, X \/ epsilon$, "->", bend: 40deg),
      
      node((10,0), $q_f$, stroke: 2pt),
      edge((8,0), (10,0), $epsilon, Z_0 \/ Z_0$, "->"),
      edge((0,0), (5, -2.5), (10,0), $epsilon, Z_0 \/ Z_0$, "->", bend: -40deg),
    )
  ]

  *状态说明*：
  - $q_0$：读取 $a$ 阶段，每次压入两个 $X$。
  - $p_1, p_2, p_3$：读取 $b$ 后的强制弹出阶段（必须弹出 3 个 $X$）。
  - $q_1$：弹出完成阶段。可选择不弹、多弹 1 个或多弹 2 个（通过 $p_4$）。
  - $q_f$：接受状态。当输入读完且栈中只剩 $Z_0$ 时接受。

  *应考技巧*：
  这类涉及“比例范围”的题目，核心是 *“压入固定倍数（公分母），弹出非确定范围”*。
]

#problem[（2023年）
  已知语言 $L = {a^n b^m | n, m >= 0, 0 <= m <= 2n <= 4m}$。
  1. 写出其 CFG (8 分)
  2. 写出其空栈接受的 PDA (4 分)
  3. 写出语言 $L = {a^(2n) b^n | n >= 1}$ 的 PDA（空栈接受与终态接受均可） (8 分)
]

#solution[
  *1. CFG 构造*
  
  分析：$0 <= m <= 2n <= 4m$ 等价于 $m / 2 <= n <= 2m$。
  这意味着每个 $b$ 可以对应 $0.5$ 到 $2$ 个 $a$。
  文法核心利用递归构造，覆盖比例边界：
  - 一个 $b$ 配一个 $a$ ($n/m = 1$)
  - 一个 $b$ 配两个 $a$ ($n/m = 2$)
  - 两个 $b$ 配一个 $a$ ($n/m = 0.5$)
  
  文法：
  $ S -> a S b | a a S b | a S b b | epsilon $
  
  *2. 空栈接受的 PDA*
  
  *设计思路*（比例缩放）：
  - 压栈：读 $a$ 时，非确定性压入 1 或 2 个 $X$。
  - 弹栈：读 $b$ 时，非确定性弹出 1 或 2 个 $X$（弹出 2 个需经过辅助状态 $p$）。
  - 匹配：$k_a n = k_b m arrow.r.double n/m = k_b / k_a in {1/2, 1, 2}$。

  #grid(
    columns: (1.2fr, 1fr),
    gutter: 1em,
    [
      *转移方程*：
      1. $delta(q, a, Z_0) = {(q, X Z_0), (q, X X Z_0)}$
      2. $delta(q, a, X) = {(q, X X), (q, X X X)}$
      3. $delta(q, b, X) = {(q, epsilon), (p, epsilon)\}$
      4. $delta(p, epsilon, X) = {(q, epsilon)\}$
      5. $delta(q, epsilon, Z_0) = {(q, epsilon)}$
    ],
    [
      *状态说明*：
      - $q$: 主状态，负责读入与计数。
      - $p$: 辅助状态，实现“读 $b$ 弹双 $X$”。
      - 接受：空栈接受，由 $delta(5.)$ 弹出 $Z_0$。
    ]
  )

  #figure(
    fig_11(),
    caption: [识别 $n/m in {1/2, 1, 2}$ 的 PDA 状态图]
  )
  *3. $L = {a^(2n) b^n | n >= 1}$ 的 PDA*
  
  *思路*：每读入两个 $a$ 压入一个 $X$，每读入一个 $b$ 弹出一个 $X$。
  
  转移方程：
  - $delta(q_0, a, Z_0) = {(q_1, Z_0)}$ （计数第 1、3... 个 $a$）
  - $delta(q_1, a, Z_0) = {(q_0, X Z_0)}$ （计数第 2 个 $a$，压入 $X$）
  - $delta(q_0, a, X) = {(q_1, X)}$ 
  - $delta(q_1, a, X) = {(q_0, X X)}$ （计数偶数个 $a$，压入 $X$）
  - $delta(q_0, b, X) = {(q_2, epsilon)}$ （匹配首个 $b$）
  - $delta(q_2, b, X) = {(q_2, epsilon)}$ （匹配后续 $b$）
  - $delta(q_2, epsilon, Z_0) = {(q_f, Z_0)}$ （终态接受）
  
  #figure(
    fig_12(),
    caption: [识别 $a^{2n} b^n$ 的 PDA #text(fill:blue)[(真题)]]
  )
]

#problemset[
  #problem[（2023年判断题）确定型下推自动机 (DPDA) 是下推自动机 (PDA) 的变体, 当 DPDA 与普通 PDA 在语言识别能力方面具有等价性。]

  #solution[
    ×（错误）。非确定性 PDA (NPDA) 比 DPDA 更强。例如 $L = {w w^R | w in {0,1}^*}$ 是 CFL（由 NPDA 识别）但不是 DCFL（不能由 DPDA 识别）。
  ]


]

= 上下文无关语言的性质

#theorem[CFL 泵引理][
  若 $L$ 是一个上下文无关语言 (CFL)，则存在一个常数 $p$（泵长度），使得对于 $L$ 中任何长度不小于 $p$ 的字符串 $s$，都可以将 $s$ 划分为五部分 $s = u v w x y$，满足：
  1. $|v x| >= 1$ （即 $v$ 和 $x$ 不同时为空）
  2. $|v w x| <= p$
  3. 对所有 $i >= 0$，$u v^i w x^i y in L$。
]

#remark[
  *使用泵引理证明语言不是 CFL 的一般步骤*：
  1. *假设*：假设语言 $L$ 是上下文无关语言 (CFL)。
  2. *常量*：由泵引理得，存在泵长度 $p$。
  3. *选串*：选取字符串 $s in L$ 且 $|s| >= p$。注意 $s$ 通常要用 $p$ 来参数化。
  4. *划分*：考虑 $s$ 满足 $|v w x| <= p$ 且 $|v x| >= 1$ 的所有可能划分 $s = u v w x y$。
  5. *泵出*：通过选择合适的 $i$（通常是 0 或 2），证明 $u v^i w x^i y in.not L$。
  6. *矛盾*：与泵引理矛盾，故 $L$ 不是 CFL。
]

#definition[CFL 的封闭性质][
  上下文无关语言 (CFL) 在以下运算下封闭：
  - *并集* ($L_1 union L_2$)、*连接* ($L_1 L_2$)、*克林闭包* ($L^*$)
  - *同态* 与 *逆同态*
  - *与正则语言的交集* ($L inter R$)
  
  *注意*：CFL 在 *交集* ($L_1 inter L_2$) 和 *补集* ($overline(L)$) 下 *不封闭*！
  - 经典反例：$L_1 = {a^n b^n c^m}$ 与 $L_2 = {a^m b^n c^n}$ 都是 CFL，但其交集 ${a^n b^n c^n}$ 不是 CFL。
]
#note[
  注意 CFL 与 RL 的不同点， CFL 与 RL 都在并、连接、Kleene 闭包等运算下封闭，但 CFL 在交、补等布尔运算下不封闭。
]
#property[CFL 的判定性质][
  - *成员性*：给定 $w, G$，判断 $w in L(G)$ 是可判定的。
  - *空性*：判断 $L(G) = emptyset$ 是可判定的。
  - *有限性*：判断 $L(G)$ 是否为有限集是可判定的。
  - *等价性*：判断 $L(G_1) = L(G_2)$ 是 *不可判定* 的。
]


#problem[
  请判断以下语言是否是 CFL，如果是，请给出对应的 CFG；否则，请给出相应的证明。
  $ L = { a^(n^2) | n >= 1 } $
]

#solution[
  1. *结论*：该语言 $L = { a^(n^2) | n >= 1 }$ *不是* 上下文无关语言 (CFL)。

  2. *证明 (使用泵引理 Pumping Lemma)*：
     - 假设 $L$ 是 CFL，则存在泵长度 $p$。
     - 取字符串 $s = a^(p^2)$，显然 $s in L$ 且 $|s| = p^2 >= p$。
     - 根据泵引理，$s$ 可以划分为 $s = u v w x y$，满足：
       - $|v x| >= 1$ (即 $v$ 和 $x$ 不同时为空)
       - $|v w x| <= p$
       - 对所有 $i >= 0$，$u v^i w x^i y in L$。
     - 设 $|v x| = k$，其中 $1 <= k <= p$。
     - 当 $i = 2$ 时，$s' = u v^2 w x^2 y$ 的长度为 $|s'| = p^2 + k$。
     - 我们考查 $p^2 + k$ 是否能成为完全平方数：
       - 已知 $p^2 < p^2 + k$。
       - 考查下一个平方数 $(p + 1)^2 = p^2 + 2p + 1$。
       - 因为 $k <= p < 2p + 1$，所以：
         $p^2 < p^2 + k < p^2 + 2p + 1 = (p + 1)^2$
     - 因此，$p^2 + k$ 位于两个连续平方数之间，不可能是完全平方数。
     - 所以 $s' = a^(p^2 + k) in.not L$，矛盾。
     - 故 $L$ 不是 CFL。
]

#problem[
  语言 $L = {0^n 2^m 1^n | 0 <= m < n}$ 是否为 CFL? 若是请写出其文法; 若不是请说明理由。(15 分)
]

#solution[
  1. *结论*：该语言 $L$ *不是* 上下文无关语言 (CFL)。

  2. *证明 (使用泵引理 Pumping Lemma)*：
     - 假设 $L$ 是 CFL，则存在泵长度 $p$。
     - 取字符串 $s = 0^p 2^(p-1) 1^p$。由于 $p-1 < p$，故 $s in L$。
     - 根据泵引理，$s = u v w x y$，其中 $|v x| >= 1$ 且 $|v w x| <= p$。
     - *情况分析*：
       - 由于 $|v w x| <= p$，且 $0$ 块与 $1$ 块被 $p-1$ 个 $2$ 隔开，因此 $v w x$ 不可能同时包含 $0$ 和 $1$。
       - (1) 如果 $v x$ 包含 $0$ 或 $1$：泵出 ($i != 1$) 会导致 $n_0 != n_1$ (即 $0$ 和 $1$ 的数量不相等)，不属于 $L$。
       - (2) 如果 $v x$ 只包含 $2$：取 $i = 2$，则 $s' = 0^p 2^(p-1+|v x|) 1^p$。由于 $|v x| >= 1$，新的 $2$ 的个数 $m' = p-1+|v x| >= p$。此时 $m' >= n_0 = n_1 = p$，违背了 $m < n$ 的条件，故 $s' in.not L$。
     - 矛盾，故 $L$ 不是 CFL。
]

#note[
  *期末考避坑指南*：
  - 证明*不属于* CFL 时，务必检查选取的字符串 $s$ 在 $i=0, 2$ 等不同泵出方案下是否都能产生矛盾。
  - 对于带有不等式约束（如 $m < n$）的语言，通常泵入 ($i=2$) 更有利于破坏不等式。
]

#problem[
  *判断题*（期末高频考点）：
  1. 若 $L_1$ 为 CFL，$L_2$ 为正则语言，则 $L_1 inter L_2$ 必为 CFL。 ( )
  2. 若 $L_1 union L_2$ 为 CFL，则 $L_1, L_2$ 至少有一个是 CFL。 ( )
  3. 给定 CFG $G$，判断 $L(G) = Sigma^*$ 是可判定的。 ( )
  4. 任何正则语言都是上下文无关语言。 ( )
]

#solution[
  1. *对*。CFL 与正则语言的交集仍然是 CFL。这常用于证明一个语言 *不是* CFL。
  2. *错*。反例：设 $L_1 = { a^p | p "为质数" }$（非 CFL），$L_2 = overline(L_1)$（非 CFL），但 $L_1 union L_2 = a^*$ 是正则语言，由于正则语言必然是 CFL，故并集是 CFL。
  3. *错*。CFG 的“全集问题”（$L(G) = Sigma^*$）是*不可判定*的（注意：正则语言的全集问题是可判定的）。
  4. *对*。正则语言（3 型）是 CFL（2 型）的真子集。
]

#problem[
  证明语言 $L = { w in {a,b,c}^* | n_a = n_b = n_c }$ 不是上下文无关语言。
]

#solution[
  1. *思路*：直接用泵引理划分 $w$ 会非常麻烦（因为 $a,b,c$ 是交错的）。我们利用 *CFL 在正则交下的封闭性* 来简化证明。
  2. *证明*：
     - 假设 $L$ 是 CFL。
     - 显然 $R = a^* b^* c^*$ 是一个正则语言。
     - 根据封闭性，$L' = L inter R = { a^n b^n c^n | n >= 0 }$ 必须是 CFL。
     - 然而，我们已知 $L' = { a^n b^n c^n | n >= 0 }$ 不是 CFL（经典非 CFL 语言）。
     - 矛盾。
     - 故原语言 $L$ 不是 CFL。
]

#note[
  *期末考避坑指南（续）*：
  - *交集大法*：当你发现一个语言很“乱”（字符没顺序）但要求数量相等时，尝试先交一个 $a^* b^* c^*$ 把它变规整。
  - *判定性大坑*：$L(G) = emptyset$ 是可判定的，但 $L(G) = Sigma^*$ 是 *不可判定* 的！考试常考这个对比。
]


#remark[
  *应考技巧*：
  - *证明是正则/CFL*：直接构造对应的自动机或文法。
  - *证明非正则/非 CFL*：通常使用对应的 *泵引理* (Pumping Lemma)。
  - *封闭性应用*：利用已知的封闭性质（如 RL 对交封闭，CFL 对交不封闭）通过反证法或构造法简化证明。
]

#problemset[
  #problem[（2023年判断题）上下文无关语言在并, 乘, 闭包, 代换等运算下是封闭的, 仅在交, 补运算下才不封闭。]
  #solution[
    √（正确）。上下文无关语言对交和补不封闭是经典的考试考点。
  ]

  #problem[（2023年判断题）存在算法判定上下文无关语言是否为空, 但无法判定其补是否为空。]
  #solution[
    √（正确）。CFL 的空性是可判定的，但 CFL 补的空性（即判断 $L = Sigma^*$）是不可判定的。
  ]
]

= 图灵机 (TM)

#introduction[图灵机定义][计算能力][Chomsky 层级]

#definition[图灵机形式化定义][
  图灵机为七元组 $M = (Q, Sigma, Gamma, delta, q_0, B, F)$：
  - $Q$: 状态集
  - $Sigma$: 输入字母表
  - $Gamma$: 带子字母表 ($Sigma subset.eq Gamma$)
  - $delta: Q times Gamma -> Q times Gamma times {L, R}$ (转移函数)
  - $q_0$: 初始状态
  - $B$: 空白符 ($B in Gamma \\ Sigma$)
  - $F$: 接受状态集
]

#figure(
  align(center)[
    #cetz.canvas({
      import cetz.draw: *
      // Tape
      for i in range(11) {
        rect((i, 0), (i+1, 1))
      }
      content((0.5, 0.5), [$dots$])
      content((1.5, 0.5), [$X_1$])
      content((2.5, 0.5), [$X_2$])
      content((3.5, 0.5), [$dots$])
      content((4.5, 0.5), [$X_i$])
      content((5.5, 0.5), [$dots$])
      content((6.5, 0.5), [$X_n$])
      content((7.5, 0.5), [$B$])
      content((8.5, 0.5), [$B$])
      content((9.5, 0.5), [$B$])
      content((10.5, 0.5), [$dots$])
      
      // Finite control
      rect((2.5, -2), (6.5, -1), fill: rgb("eef5fd"), stroke: blue)
      content((4.5, -1.5), [*有限状态控制器* ($q$)])
      
      // Head with arrows
      line((4.5, -1), (4.5, 0), mark: (end: ">"), stroke: (paint: blue, thickness: 1.5pt))
      content((5, -0.5), text(blue, size: 0.8em)[读写头])
      
      line((4.5, -1.2), (3.5, -1.2), mark: (end: ">"), stroke: blue)
      line((4.5, -1.2), (5.5, -1.2), mark: (end: ">"), stroke: blue)
      content((4.5, -0.8), text(blue, size: 0.7em)[移动方向 (L/R)])
    })
  ],
  caption: [图灵机 (Turing Machine) 结构示意图],
)

== 瞬时描述 (ID)

#figure(
  align(center)[
    #cetz.canvas({
      import cetz.draw: *
      
      // Tape
      for i in range(10) {
        rect((i, 0), (i+1, 1))
      }
      content((0.5, 0.5), [$a$])
      content((1.5, 0.5), [$b$])
      content((2.5, 0.5), [$b$])
      content((3.5, 0.5), [$a$])
      content((4.5, 0.5), [$a$])
      content((5.5, 0.5), [$b$])
      content((6.5, 0.5), [$a$])
      content((7.5, 0.5), [$B$])
      content((8.5, 0.5), [$B$])
      content((9.5, 0.5), [$B$])
      
      // alpha_1 mark
      line((0, 1.2), (0, 1.3), (3, 1.3), (3, 1.2), stroke: gray)
      content((1.5, 1.7), [$alpha_1$ ($a b b$)])

      // alpha_2 mark
      line((3, 1.2), (3, 1.3), (7, 1.3), (7, 1.2), stroke: gray)
      content((5, 1.7), [$alpha_2$ ($a a b a$)])

      // Head
      line((3.5, -0.8), (3.5, 0), mark: (end: ">"), stroke: (paint: red, thickness: 1.5pt))
      content((3.5, -1.2), text(red, size: 0.9em)[状态 $q$ (正读取 $alpha_2$ 首字符)])
    })
  ],
  caption: [瞬时描述 (ID: $alpha_1 q alpha_2$) 示意图],
)

#definition[图灵机的 ID][
  使用字符串 $alpha_1 q alpha_2$ 表示 TM 的当前状态：
  - $q$：图灵机当前所处的状态。
  - $alpha_1 alpha_2$：带子上从最左端非空白符直到最右端非空白符的字符串（或者是包含磁头的必要长度）。
  - *磁头位置*：磁头正指向 $alpha_2$ 的第一个字符。
]

#property[转移关系][
  - $tack.r$：表示一步转移。
  - $tack.r^*$：表示零步或多步转移。
]

== 图灵机语言与停机问题
#definition[接受语言][
  - *通过状态接受*：$L(M) = \{w in Sigma^* | q_0 w tack.r^* alpha_1 p alpha_2, p in F\}$
  - *通过停机接受*：只要磁头停下且没有定义下一步转移，就视为接受。
  - *注意*：对于 TM，通过状态接受和通过停机接受是*等价*的。
]

#theorem[递归可枚举 (RE) 与 递归语言 (Recursive)][
  1. *递归可枚举语言 (RE)*：存在一台 TM $M$，若 $w in L$，则 $M$ 接受 $w$；若 $w in.not L$，则 $M$ 可能进入*死循环*或拒绝。
  2. *递归语言 (Recursive)*：存在一台 TM $M$，若 $w in L$，则 $M$ 接受 $w$；若 $w in.not L$，则 $M$ *必然在有限步内停机并拒绝*。这种语言也称为*可判定语言*。
]

== 编程技巧与扩展
#note[
  *编程技巧：*
  1. *状态存储信息*：状态集变为 $Q times \{a, b, c\}$，利用有限的状态空间记录少量信息。
  2. *多道 (Multi-track)*：将带子字母表 $Gamma$ 设为元组形式（如 $\{0, 1\} times \{X, B\}$），相当于在一条带子上划分出多个物理轨道。
  3. *子程序 (Subroutines)*：将复杂的 TM 划分为多个简单的模块，一个状态的完成跳转到另一个 TM 的初始状态。
]

#property[TM 的等价性][
  以下模型与基本单带 TM 的计算能力完全相同：
  - *多带图灵机*：有 $k$ 条带子和 $k$ 个独立磁头。
  - *非确定图灵机 (NTM)*：下一步转移有多个可能。
  - *多维图灵机*：带子在平面或更高维空间。
]

#remark[
  *图灵机状态转换图符号说明：*
  转换弧上的标签 $a \/ b, D$ 表示：
  - *读入字符* $a  ->  $ *写回字符* $b$，磁头向 *方向* $D$（$L$ 为左，$R$ 为右）移动。
]



#example[常见设计模式总结][
  - *复制字符串* ($w \to w w$)：在原串后面做一个标记位，每次读取原串一个字符，穿梭到后面写下一个。
  - *左右平移*：通过状态记录“当前拿在手里的字符”，写下上一个拿到的字符，直到遇到空白符。
  - *算术运算*：利用一进制表示，例如 $m+n$ 就是把中间的隔离符删掉并平移，乘法则是多次加法（循环调用复制子程序）。
]

#example[接受 $0^n 1^n$ 的图灵机设计]

#solution()[
  这是一个非常经典的图灵机入门例题。图灵机的工作原理类似于“折返跑”：通过把已匹配的 `0` 和 `1` 替换为 `X` 和 `Y`，逐步消减字符串。

  *状态设计核心思路 (应考重点)：*
  设计图灵机时，*每个状态代表一个“任务阶段”*。本题的 4 个状态分工如下：
  - $q_0$：*寻找起点*。定位最左侧未处理的 `0`。若只看到 `Y`，说明 `0` 已找完，转入收尾。
  - $q_1$：*寻找匹配*。由于刚扣掉一个 `0`，需向右寻找第一个 `1` 抵消。
  - $q_2$：*折返复位*。配对完成后，向左划过所有 `0` 和 `Y`，直到撞见标记 `X`，回到起点。
  - $q_3$：*终端审计*。当 $q_0$ 找不到 `0` 时，检查右侧是否还残余 `1`。若全是 `Y` 且撞见空位 $B$，则说明完全匹配。

  *核心步骤说明：*
  + *标记 0*: 在 $q_0$ 看到 `0` 改成 `X`，切至 $q_1$ 并右移。
  + *寻找 1*: $q_1$ 跳过 `0` 和 `Y`，找到第一个 `1` 改成 `Y`，切至 $q_2$ 并左移。
  + *归位*: $q_2$ 向左跳过 `0` 和 `Y` 撞见 `X` 后，右移一格回到 $q_0$ 重启。
  + *收尾*: $q_0$ 撞见 `Y` 进入 $q_3$，一路向右审视，全为 `Y` 则进入接受态 $q_4$。

  这里用状态转移图把刚刚说的逻辑画出来：

  #align(center)[
    fig_15()
  ]

    以识别 $0^n 1^n$ 的图灵机为例，处理字符串 $0011$ 的过程：
  - $q_0 0011 tack.r X q_1 011$ （标记第一个 0，开始找 1）
  - $X 0 q_1 11 tack.r X q_2 0 Y 1$ （找到第一个 1，标记为 Y 并折返）
  - $q_2 X 0 Y 1 tack.r X q_0 0 Y 1$ （回到 X 右侧，开始下一轮）
  - $X X q_1 Y 1 tack.r X X Y q_1 1 tack.r X X q_2 Y Y tack.r X q_2 X Y Y tack.r X X q_0 Y Y$
  - $X X Y q_3 Y tack.r X X Y Y q_3 B tack.r X X Y Y B q_4 B$ （接受）
  *纸带运行移动过程演示*
  #let tstep(state, pos, char-array, desc) = {
    let len = char-array.len()
    box[
      #grid(
        columns: (2em,) * len,
        rows: (1.5em, 2em),
        align: center + horizon,
        ..char-array.enumerate().map(((i, c)) => {
          if i == pos [#text(fill: red, weight: "bold")[$#state$] \ #v(-6pt) #text(fill: red)[$arrow.b$]] else []
        }),
        ..char-array.map(c => rect(width: 100%, height: 100%, stroke: 1pt, inset: 4pt, align(center+horizon)[#c]))
      )
      #v(2pt)
      #align(center)[#text(size: 0.8em, fill: luma(100))[#desc]]
    ]
  }

  #align(center)[
    #grid(
      columns: (1fr, 1fr, 1fr),
      row-gutter: 2em,
      column-gutter: 2em,
      tstep("q_0", 0, ("0", "0", "1", "1", "B", "B"), [1. 初始，遇到0]),
      tstep("q_1", 1, ("X", "0", "1", "1", "B", "B"), [2. 0改X，向右]),
      tstep("q_1", 2, ("X", "0", "1", "1", "B", "B"), [3. 路过0，向右]),
      tstep("q_2", 1, ("X", "0", "Y", "1", "B", "B"), [4. 1改Y，向左折返]),
      tstep("q_2", 0, ("X", "0", "Y", "1", "B", "B"), [5. 路过0，向左]),
      tstep("q_0", 1, ("X", "0", "Y", "1", "B", "B"), [6. 遇X，回弹右移]),
      tstep("q_1", 2, ("X", "X", "Y", "1", "B", "B"), [7. 0改X，向右]),
      tstep("q_1", 3, ("X", "X", "Y", "1", "B", "B"), [8. 路过Y，向右]),
      tstep("q_2", 2, ("X", "X", "Y", "Y", "B", "B"), [9. 1改Y，向左折返]),
      tstep("q_2", 1, ("X", "X", "Y", "Y", "B", "B"), [10. 路过Y，向左]),
      tstep("q_0", 2, ("X", "X", "Y", "Y", "B", "B"), [11. 遇X，回弹右移]),
      tstep("q_3", 3, ("X", "X", "Y", "Y", "B", "B"), [12. 视Y进$q_3$检查]),
      tstep("q_3", 4, ("X", "X", "Y", "Y", "B", "B"), [13. 扫过Y，向右]),
      tstep("q_4", 5, ("X", "X", "Y", "Y", "B", "B"), [14. 遇空B，接受！])
    )
  ]
]

#problem[(作业题目) 设计图灵机识别语言 $L = {0^i 1^j 0^k | i = j + k, i, j, k >= 1}$]
  #solution[
    *设计步骤：*
    - *阶段一（消去 1）*：向右寻找第一个 1 改为 $Y$，向左折返将第一个遇到的 0 改为 $X$。重复直到所有 1 耗尽。
    - *阶段二（消去末尾 0）*：向右跨过所有 $Y$，寻找末尾段的第一个 0 改为 $Z$，向左折返寻找开头段剩余的第一个 0 改为 $X$。
    - *检查*：当末尾 0 耗尽时，需确保开头段的 0 也恰好全部耗尽。

    *状态定义：*
    - $q_0$：*起始/匹配分发*。寻找左侧最开始的 0 并改为 $X$。若遇到 $Y$ 则说明阶段一结束，进入阶段二。
    - $q_1$：*跳过 $0^i$ 段*。寻找 1 或之前的标记 $Y$。
    - $q_6$：*跳过 $Y$ 段*。寻找 1 并改为 $Y$（阶段一），若没 1 则寻找 $0^k$ 段的 0 并改为 $Z$（阶段二）。
    - $q_2$：*寻找 X 回退*。找到 1 改为 $Y$ 后，向左跨过所有 1, 0, $Y$ 回退到 $X$ 的右侧。
    - $q_3$：*第二阶段回退*。找到 0 改为 $Z$ 后，向左跨越 $Y, Z$ 返回寻找 $X$。
    - $q_4$：*最终验证*。当 $q_0$ 处不再有 0 可匹配时，向右扫描确保只剩下 $Y$ 和 $Z$。
    - $q_5$：*接受状态*。扫描到空白符 $B$。

    #figure(
      fig_13(),
      caption: [识别 $L = {0^i 1^j 0^k | i = j + k}$ 的图灵机状态转换图]
    )
  ]


#problem[(作业题目) 设计图灵机识别语言 $L = {1^n 0^m 1^n 0^m | n, m >= 1}$]

#solution[
    *设计思路与运行过程：*
    - *匹配 $1^n$*：标记左侧第 1 个 1 为 $X$，寻到右侧对应块（通过跨过 0 段）的第一个 1 也标记为 $X$。返回寻找下一个 1。
    - *匹配 $0^m$*：1 序列匹配完后，在第一组 0 中标记第一个 0 为 $Y$，在磁带末尾 0 序列块中标记第一个 0 为 $Y$。
    
    *状态功能定义：*
    - $q_0$：*主控制器*。找左侧第一个 1 改为 $X$。若遇到 0 转 $q_3$。
    - $q_1$：*跨向右侧*。跳过 1, 0 以及右侧已标记的 $X$。
    - $q_2$：*匹配 1*。找对应 1 改为 $X$ 后向左回退至标记点。
    - $q_3$：*匹配 0*。标记第一组的 0 为 $Y$。
    - $q_4$：*跨向末尾段*。跳过 0, $X$ 及末尾已标记的 $Y$。
    - $q_5$：*寻找对应 0*。找末尾对应 0 改为 $Y$ 并回退。
    - $q_("acc")$：*结束*。所有符号匹配完（遇 $B$）接受。

    #figure(
      fig_14(),
      caption: [识别 $L = {1^n 0^m 1^n 0^m}$ 的图灵机状态转换图]
    )
  ]


#note[
  *关于“拒绝”与“停机”：*
  - *接受*：进入接受状态并且磁头停下。
  - *拒绝*：进入拒绝状态，或者在当前状态下读到一个*未定义转移*的符号。
  - *死循环*：图灵机可能永远不停。在考试设计中，需确保对于非法串能通过“无定义转移”快速拒绝。
]

#remark[
  *期末考避坑指南：*
  - *磁头“指针”同步*：在 $1^n 0^m 1^n 0^m$ 这类题中，标记第 1 个 1 后，一定要准确跨过 0 段找到目标 1。
  - *左端越界*：图灵机带子通常设为向左无限（或有边界）。回退时，必须用特殊的标记位（如 X）作为停止信号，防止磁头掉下带子。
]

== Chomsky 层次结构 (总结)

#property[Chomsky 层次结构][
  下表总结了形式语言理论中的四类语言及其对应的计算模型：
  
  #align(center, table(
    columns: (auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    fill: (x, y) => if y == 0 { gray.lighten(50%) },
    [*文法层次*], [*语言类型*], [*识别自动机*], [*包含关系*],
    [3 型文法], [正则语言 (RL)], [有限自动机 (FA)], [最内层],
    [2 型文法], [上下文无关语言 (CFL)], [下推自动机 (PDA)], [$subset$],
    [1 型文法], [上下文有关语言 (CSL)], [线性有界自动机 (LBA)], [$subset$],
    [0 型文法], [递归可枚举语言 (RE)], [图灵机 (TM)], [最外层],
  ))


  #figure(
    image("../assets/automachine/image.png", width:95%),
    caption:"Chomsky 文法体系"
  )
]
#problemset[
  #problem[（2023年判断题）对于一个有 k 条道的多道图灵机, 读头一次读入 k × k 个符号。]

  #solution[
    ×（错误）。多道图灵机的读头一次读入 $k$ 个符号（每道一个符号），将其视为字母表的复合符号。
  ]
]

