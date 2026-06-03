#import "../lib.typ": *
#import "../diagrams/machinelearning/diagrams.typ": *
#import "@preview/codly:1.2.0": *
#show: conf
#show table:set align(center)
#default-cover(
  title: [机器学习期末突击讲义],
)

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()
#show table: set align(center)
#default-outline()

 = 引言与机器学习概述

#introduction[机器学习定义][监督/无监督学习][应用实例]

== 什么是机器学习

#definition[机器学习][
  机器学习是计算机从数据中学习规律，从而对新数据做出预测或决策的技术。它是人工智能的核心分支，介于人工智能的宽泛概念与深度学习的特殊技术之间。
]

#property[机器学习的位置][
  - *人工智能*：计算机模拟人类智慧的宽泛概念
  - *机器学习*：计算机从数据中学习规律
  - *深度学习*：机器学习的特殊技术
  - *大模型*：基于深度学习的最新发展
]

== 机器学习的主要类型

#theorem[学习范式分类][
  1. *监督学习 (Supervised Learning)*：数据带有标签，学习从输入到输出的映射
     - 分类：预测离散类别
     - 回归：预测连续值
  
  2. *无监督学习 (Unsupervised Learning)*：数据无标签，发现数据内在结构
     - 聚类：将数据分组
     - 降维：减少数据维度
  
  3. *强化学习 (Reinforcement Learning)*：智能体通过与环境交互学习最优策略
]

#pagebreak(weak: true)
 = 概念学习与一般到特殊序

#introduction[概念定义][假设空间][变型空间][候选消除算法][归纳偏置]

== 核心概念定义

#definition[概念 (Concept)][
  每个概念可被看作对象或事件的集合，它是一个大集合的子集，或者是在这个大集合中定义的布尔函数。
  
  例：$"IsBird"("animal")$ 是一个概念，将动物分为鸟类和非鸟类。
]

#definition[概念学习][
  概念学习是指从有关某个布尔函数的输入输出训练样例中推断出该布尔函数。
]

#definition[假设 (Hypothesis)][
  假设是问题的一个可能解，是基于输入数据进行预测的函数或数学模型。本章中假设表示为实例各属性约束的*合取式*。
  
  约束取值可以是：
  - *特定值*：例如 $"Water"="Warm"$
  - *接受任意值* ($?$)：例如 $"Water"=?$
  - *不接受任何值* ($∅$)：例如 $"Water"=∅$
]

#example[假设示例][
  对于EnjoySport问题，一个假设可以表示为：
  $ h = "<Sunny, ?, ?, Strong, ?, Same>" $
  
  特殊假设：
  - $<?, ?, ?, ?, ?, ?>$：每一天都是正例（最一般）
  - $<∅, ∅, ∅, ∅, ∅, ∅>$：每一天都是反例（最特殊）
]

== 术语体系

#property[核心术语][
  - *实例 (Instance)*：一个特定输入$x$及其期望输出$f(x)$组成的二元组，记为$<x, f(x)>$
  - *目标概念 (Target Concept)*：待学习的概念，记为$c$
  - *训练样例 (Training Examples)*：目标概念的输入输出实例集合$D$
  - *假设空间 (Hypothesis Space)*：所有可能假设构成的集合$H$
]

== 一般到特殊序

#definition[更一般/更特殊][
  假设$h_j$比$h_k$*更一般*，当且仅当：
  $ (forall x in X)[(h_k(x) = 1) => (h_j(x) = 1)] $
  
  记作：$h_j >_g h_k$（$h_j$比$h_k$更一般）
]

#figure(
  caption: [假设空间的一般到特殊序结构],
  {
    set text(size: 8pt)
    fig_1()
  }
)

== Find-S算法

#definition[Find-S算法][
  寻找极大特殊假设：从$H$中最特殊假设开始，然后在假设覆盖正例失败时将其一般化。
]

#figure(
  caption: [Find-S算法流程],
  {
    set text(size: 8pt)
    fig_2()
  }
)

#example[Find-S算法执行示例][
  训练样例（EnjoySport问题）：
  
  #table(
    columns: (auto, auto, auto, auto, auto, auto, auto, auto),
    inset: 5pt,
    align: center,
    table.header([样例], [Sky], [AirTemp], [Humidity], [Wind], [Water], [Forecast], [EnjoySport]),
    [1], [Sunny], [Warm], [Normal], [Strong], [Warm], [Same], [Yes],
    [2], [Sunny], [Warm], [High], [Strong], [Warm], [Same], [Yes],
    [3], [Rainy], [Cold], [High], [Strong], [Warm], [Change], [No],
    [4], [Sunny], [Warm], [High], [Strong], [Cool], [Change], [Yes],
  )
  
  *执行过程*：
  
  1. *初始化*：$h_0 = <∅, ∅, ∅, ∅, ∅, ∅>$
  
  2. *样例1（正例）*：$h_1 = "<Sunny, Warm, Normal, Strong, Warm, Same>"$
  
  3. *样例2（正例）*：比较发现Humidity不同，泛化为$?$
     $h_2 = "<Sunny, Warm, ?, Strong, Warm, Same>"$
  
  4. *样例3（反例）*：*忽略*（Find-S不处理反例）
  
  5. *样例4（正例）*：Water和Forecast不同，都泛化为$?$
     $h_3 = "<Sunny, Warm, ?, Strong, ?, ?>"$
  
  *最终假设*：$h = "<Sunny, Warm, ?, Strong, ?, ?>"$
]

#note[
  *Find-S算法特点*：
  - 只处理正例，反例被忽略
  - 收敛到与正例一致的最特殊假设
  - 不能保证找到与训练样例一致的最一般假设
]

== 变型空间与候选消除算法

#definition[变型空间 (Version Space)][
  变型空间 $"VS"_(H,D)$ 是与训练样例$D$一致的所有假设组成的子集：
  $ "VS"_(H,D) = {h in H | "Consistent"(h, D)} $
]

#definition[一致 (Consistent)][
  假设$h$与训练样例$D$一致，当且仅当：
  $ (forall <x, c(x)> in D) h(x) = c(x) $
]

#property[变型空间的边界表示][
  变型空间可以用*一般边界*$G$和*特殊边界*$S$完全描述：
  - *一般边界G*：变型空间中*最一般*的成员组成的集合
  - *特殊边界S*：变型空间中*最特殊*的成员组成的集合
  
  变型空间包含所有满足 $s <=_g h <=_g g$（对任意$s in S, g in G$）的假设$h$。
]

#figure(
  caption: [变型空间的一般边界G和特殊边界S],
  {
    set text(size: 8pt)
    fig_3()
  }
)

#example[候选消除算法执行示例][
  训练样例：
  
  #table(
    columns: (auto, auto, auto, auto, auto, auto),
    inset: 5pt,
    align: center,
    table.header([样例], [Sky], [AirTemp], [Humidity], [Wind], [EnjoySport]),
    [1], [Sunny], [Warm], [Normal], [Strong], [Yes],
    [2], [Rainy], [Cold], [High], [Strong], [No],
    [3], [Sunny], [Warm], [High], [Strong], [Yes],
  )
  
  *初始化*：
  - $S_0 = {<∅, ∅, ∅, ∅>}$
  - $G_0 = {<?, ?, ?, ?>}$
  
  *样例1（正例）*：
  - $S_1 = "{<Sunny, Warm, Normal, Strong>}"$
  - $G_1 = "{<?, ?, ?, ?>}"$
  
  *样例2（反例）*：
  - $S_2 = "{<Sunny, Warm, Normal, Strong>}"$（不变）
  - $G_2 = "{<Sunny, ?, ?, ?>, <?, Warm, ?, ?>, <?, ?, Normal, ?>, <?, ?, ?, Strong>}"$
  
  *样例3（正例）*：
  - $S_3 = "{<Sunny, Warm, ?, Strong>}"$（Humidity泛化为$?$）
  - $G_3 = "{<Sunny, ?, ?, ?>, <?, Warm, ?, ?>}"$（移除与正例不一致的）
]

#note[
  *候选消除算法要点*：
  - *正例*：使$S$更一般化（泛化$S$中与样例不一致的假设）
  - *反例*：使$G$更特殊化（特化$G$中与样例一致的假设）
  - 当$S = G$时，算法收敛到唯一假设
]


== 归纳偏置

#definition[归纳偏置 (Inductive Bias)][
  归纳学习需要某种*预先假定*，称为*归纳偏置*。它是学习算法在学习概念时从所有候选假设中选择特定假设的偏好。
]

#property[候选消除算法的归纳偏置][
  目标概念可以在假设空间$H$中找到（即$c in H$）。
  
  如果目标概念不在$H$中，候选消除算法无法收敛到正确假设。
]

#problemset[

#example[作业题][
  设 $V S_(H,D)$ 为由假设空间 $H$ 和训练数据 $D$ 定义的变形空间，$S$ 和 $G$ 分别为其边界集合，证明：
  $
    V S_(H,D) = { h in H | exists s in S, exists g in G, s <= h <= g }.
  $
]

#proof[
  为了证明两个集合相等，只需证明它们互为子集。

  *第一步：证明 $V S_(H,D) subset.eq {h in H | exists s in S, exists g in G, s <= h <= g}$*

  设 $h in V S_(H,D)$。由于 $S$ 是变形空间中的极小元集合，在有限假设空间下，必存在某个 $s in S$ 使得 $s <= h$。同理，$G$ 是极大元集合，故必存在某个 $g in G$ 使得 $h <= g$。于是得到 $s <= h <= g$，从而 $h$ 属于右侧集合。

  *第二步：证明 ${h in H | exists s in S, exists g in G, s <= h <= g} subset.eq V S_(H,D)$*

  设 $h in H$，且存在 $s in S, g in G$ 使得 $s <= h <= g$。下证 $h$ 与训练集 $D$ 一致。

  对任意正例 $x in D_+$，因为 $s$ 与 $D$ 一致，所以 $s(x)=1$；又由 $s <= h$ 可知 $h(x)=1$，因此 $h$ 覆盖全部正例。

  对任意反例 $x in D_-$，因为 $g$ 与 $D$ 一致，所以 $g(x)=0$；又由 $h <= g$ 的逆否形式可知 $h(x)=0$，因此 $h$ 排除全部反例。

  于是 $h$ 与 $D$ 一致，即 $h in V S_(H,D)$。两边互为子集，原命题得证。
]

]
#pagebreak()
 = 决策树学习

#introduction[决策树表示][ID3算法][C4.5算法][信息增益][过拟合处理]

== 决策树表示

#definition[决策树][
  决策树通过把实例从根节点排列到某个叶子节点来分类实例，叶子节点即为实例所属的分类。
  
  树上的每一个节点指定了对实例的某个属性的测试，并且该节点的每一个后继分支对应于该属性的一个可能值。
]

#figure(
  caption: [决策树结构示意图],
  {
    set text(size: 7.5pt)
    fig_4()
  }
)

== 信息熵与信息增益

#definition[信息熵 (Entropy)][
  度量样本集合纯度的指标：
  $ "Entropy"(S) = -p_+ log_2(p_+) - p_- log_2(p_-) $
  
  其中$p_+$为正例比例，$p_-$为反例比例。
]

#definition[信息增益 (Information Gain)][
  属性$A$对集合$S$的信息增益：
  $ "Gain"(S, A) = "Entropy"(S) - sum_(v in "Values"(A)) (|S_v|) / (|S|) "Entropy"(S_v) $
  
  其中$S_v$是属性$A$取值为$v$的样本子集。
]
#definition[KL 散度 (相对熵）)][
衡量两个概率分布P（真实分布）、Q（近似分布）之间的差异，决策树、交叉熵损失常用，底数为 2：
$ D_("KL"(P||Q)) = sum_i p_i log_2 p_i / q_i $
1. 当且仅当 $P=Q$ 时等于 0
2. 非对称， 即 $D_("KL"(P||Q)) != D_("KL"(Q||P))$
3. 信息增益本质可等价为原分布与分裂后加权分布的 KL 距离。
]

#example[
  根据训练数据（14天）构建决策树
  
#align(
  center,[
      #table(
    columns: (auto, auto, auto, auto, auto, auto),
    inset: 4pt,
    align: center,
    table.header([Day], [Outlook], [Temperature], [Humidity], [Wind], [PlayTennis]),
    [D1], [Sunny], [Hot], [High], [Weak], [No],
    [D2], [Sunny], [Hot], [High], [Strong], [No],
    [D3], [Overcast], [Hot], [High], [Weak], [Yes],
    [D4], [Rain], [Mild], [High], [Weak], [Yes],
    [D5], [Rain], [Cool], [Normal], [Weak], [Yes],
    [D6], [Rain], [Cool], [Normal], [Strong], [No],
    [D7], [Overcast], [Cool], [Normal], [Strong], [Yes],
    [D8], [Sunny], [Mild], [High], [Weak], [No],
    [D9], [Sunny], [Cool], [Normal], [Weak], [Yes],
    [D10], [Rain], [Mild], [Normal], [Weak], [Yes],
    [D11], [Sunny], [Mild], [Normal], [Strong], [Yes],
    [D12], [Overcast], [Mild], [High], [Strong], [Yes],
    [D13], [Overcast], [Hot], [Normal], [Weak], [Yes],
    [D14], [Rain], [Mild], [High], [Strong], [No],
  )
  ]
)
]
#solution[
  
  *Step 1：计算根节点的熵*
  
  $S$：9正例，5反例
  $ "Entropy"(S) = -9/14 log_2(9/14) - 5/14 log_2(5/14) = 0.940 $
  
  *Step 2：计算各属性的信息增益*
  
  *Outlook*（3个取值）：
  - $S_"sunny"$：2正，3反，$"Entropy" = 0.971$
  - $S_"overcast"$：4正，0反，$"Entropy" = 0$
  - $S_"rain"$：3正，2反，$"Entropy" = 0.971$
  
  $ "Gain"(S, "Outlook") = 0.940 - (5/14 times 0.971 + 4/14 times 0 + 5/14 times 0.971) = 0.247 $
  
  *Humidity*（2个取值）：
  - $S_"high"$：3正，4反，$"Entropy" = 0.985$
  - $S_"normal"$：6正，1反，$"Entropy" = 0.592$
  
  $ "Gain"(S, "Humidity") = 0.940 - (7/14 times 0.985 + 7/14 times 0.592) = 0.151 $
  
  *Wind*（2个取值）：
  - $S_"weak"$：6正，2反，$"Entropy" = 0.811$
  - $S_"strong"$：3正，3反，$"Entropy" = 1.0$
  
  $ "Gain"(S, "Wind") = 0.940 - (8/14 times 0.811 + 6/14 times 1.0) = 0.048 $
  
  *选择Outlook作为根节点*（信息增益最大）
  
  *Step 3：递归构建子树*
  
  - *Overcast分支*：全部为Yes，设为叶子节点
  - *Sunny分支*（5个样例）：继续计算Humidity、Wind的信息增益
  - *Rain分支*（5个样例）：继续计算
]
== ID3算法

#definition[ID3算法][
  贪心算法，自顶向下构建决策树：
  1. 选择信息增益最大的属性作为节点
  2. 为每个属性值创建分支
  3. 递归地对每个分支重复上述过程
]

#figure(
  caption: [ID3算法流程],
  {
    set text(size: 8pt)
    fig_5()
  }
)

== C4.5算法


#property[C4.5 的核心改进][
  - *属性选择度量改进*：采用 *信息增益比 (Gain Ratio)* 替代信息增益，以弥补信息增益偏向于取值较多属性的缺陷。
  - *处理连续属性*：通过 *阈值离散化*（二分法）将连续属性转换为离散属性。
  - *处理缺失值*：在属性缺失的情况下仍能进行增益评估，并能根据属性的已知分布对缺失值进行概率分配。
  - *剪枝策略*：引入了 *后剪枝 (Post-pruning)* 机制（如错误率降低剪枝和规则后修剪），以处理过拟合问题。
]

#theorem[信息增益比 (Gain Ratio)][
  为了消除信息增益对取值较多属性的偏向，引入分裂信息项（Split Information）：
  $ "SplitInformation"(S, A) = -sum_(i=1)^c (|S_i|) / (|S|) log_2 ((|S_i|) / (|S|)) $
  
  则增益比率为：
  $ "GainRatio"(S, A) = frac("Gain"(S, A), "SplitInformation"(S, A)) $
]

#property[ID3 vs. C4.5 差异比较][
  #table(
    columns: (auto, 1fr, 1fr),
    inset: 5pt,
    align: center + horizon,
    table.header([*维度*], [*ID3 算法*], [*C4.5 算法*]),
    [属性选择度量], [信息增益 (Gain)], [信息增益比 (Gain Ratio)],
    [属性类型支持], [仅限于离散属性], [支持离散和连续属性],
    [处理缺失值], [无明确处理机制], [有详细的处理和分配策略],
    [剪枝策略], [无（易过拟合）], [错误率降低修剪、规则后修剪],
    [属性代价处理], [无], [支持引入代价项进行选择],
  )
]

== 过拟合与剪枝

#definition[过拟合 (Overfitting)][
  决策树对训练数据过度拟合，导致在测试数据上表现差。
  
  原因：
  - 训练数据中的噪声
  - 训练样例太少，不具有代表性
]

#property[避免过拟合的方法][
  1. *预剪枝 (Pre-pruning)*：在树完全展开前停止生长
     - 设置最大深度
     - 设置叶子节点最小样本数
     - 当信息增益小于阈值时停止
  
  2. *后剪枝 (Post-pruning)*：先构建完整树，再剪枝
     - 用验证集评估剪枝效果
     - 移除对验证集精度影响不大的子树
]

#problemset[
  #example[作业题目][
  考虑如下训练样例集合，计算：
  (a) 训练集关于目标分类的熵；(b) 属性 $a_2$ 的信息增益。

  #align(center)[
    #table(
      columns: 4,
      [*实例*], [*分类*], [*$a_1$*], [*$a_2$*],
      [1], [+], [T], [T],
      [2], [+], [T], [T],
      [3], [-], [T], [F],
      [4], [+], [F], [F],
      [5], [-], [F], [T],
      [6], [-], [F], [T],
    )
  ]
]

#solution[
  *(a) 熵的计算*：设训练样例集合为 $S$，$|S|=6$，正例 3 个、反例 3 个，因此 $p_+ = 3/6 = 0.5$，$p_- = 3/6 = 0.5$。

  $"Entropy"(S) = -p_+ log_2 p_+ - p_- log_2 p_- = -(0.5 times (-1)) - (0.5 times (-1)) = 1$

  *(b) 信息增益的计算*：按属性 $a_2$ 划分：
  - $a_2 = T$：子集 ${1, 2, 5, 6}$（2正2反），$"Entropy" = 1$
  - $a_2 = F$：子集 ${3, 4}$（1正1反），$"Entropy" = 1$

  $"Gain"(S, a_2) = 1 - (4/6) times 1 - (2/6) times 1 = 0$
]


#example[作业题目][
  判断以下命题是否正确：若树 $D_2$ 是从树 $D_1$ 经过 ID3 扩展得到的，则 $D_1$ 比 $D_2$ 更一般（more general）。若错误，请构造反例。
]

#solution[
  *命题错误*。反例构造：

  1. 令 $D_1$ 只有一个叶节点恒输出负类，即对任意实例都有 $D_1(x)=0$
  2. ID3 在叶节点上按属性 $a_i$ 分裂得到 $D_2$：若 $a_i=T$ 则正类，若 $a_i=F$ 则负类
  3. 取任意满足 $a_i=T$ 的实例 $x_0$，有 $D_2(x_0)=1$ 但 $D_1(x_0)=0$

  因此存在被 $D_2$ 判为正类而不被 $D_1$ 判为正类的样本，$D_1$ 不满足 more-general-than $D_2$ 的定义。
]

#example[2024期末考题 - 信息熵与KL散度计算][
  设P的概率分布为 $[0.1, 0.3, 0.6]$，Q的概率分布为 $[0.1, 0.2, 0.7]$，求：
  
  (1) P和Q的信息熵
  
  (2) P和Q的相对熵（即KL距离）
  
  （对数计算以2为底，结果保留两位小数）
]

#solution[
  *(1) 信息熵计算*
  
  信息熵公式：$H(P) = -sum_i p_i log_2 p_i$
  
  对于P：$H(P) = -(0.1 log_2 0.1 + 0.3 log_2 0.3 + 0.6 log_2 0.6)$
  
  $= -(0.1 times (-3.32) + 0.3 times (-1.74) + 0.6 times (-0.74))$
  
  $= 0.33 + 0.52 + 0.44 = 1.29$
  
  对于Q：$H(Q) = -(0.1 log_2 0.1 + 0.2 log_2 0.2 + 0.7 log_2 0.7)$
  
  $= -(0.1 times (-3.32) + 0.2 times (-2.32) + 0.7 times (-0.51))$
  
  $= 0.33 + 0.46 + 0.36 = 1.15$
  
  *(2) KL散度（相对熵）计算*
  
  KL散度公式：$D_"KL"(P||Q) = sum_i p_i log_2(p_i/q_i)$
  
  $D_"KL"(P||Q) = 0.1 log_2(0.1/0.1) + 0.3 log_2(0.3/0.2) + 0.6 log_2(0.6/0.7)$
  
  $= 0.1 times 0 + 0.3 times 0.58 + 0.6 times (-0.22)$
  
  $= 0 + 0.17 - 0.13 = 0.04$
  
  $D_"KL"(Q||P) = 0.1 log_2(0.1/0.1) + 0.2 log_2(0.2/0.3) + 0.7 log_2(0.7/0.6)$
  
  $= 0 + 0.2 times (-0.58) + 0.7 times 0.22$
  
  $= -0.12 + 0.15 = 0.03$
  
  *注*：KL散度不对称，$D_"KL"(P||Q) != D_"KL"(Q||P)$
]

#example[课堂回顾作业][
  简述 C4.5 算法对于 ID3 算法进行了哪些拓展。
]

#solution[
  C4.5 算法主要从以下几个维度对 ID3 进行了拓展：
  1. *属性选择度量*：使用 *信息增益比* 替代信息增益，解决了 ID3 偏好取值较多属性的问题。
  2. *连续属性处理*：引入了阈值离散化方法，使其能够支持连续型（数值型）属性。
  3. *缺失值处理*：设计了专门的机制处理训练数据中的缺失属性值。
  4. *剪枝策略*：引入了后剪枝技术（如错误率降低剪枝、规则后修剪），以应对过拟合。
  5. *属性代价*：支持在属性选择时考虑属性的获取代价。
]
]
#pagebreak()
= 人工神经网络
#introduction[感知器][Sigmoid单元][BP算法][梯度下降]

== 感知器

#definition[感知器 (Perceptron)][
  感知器是最简单的神经网络单元，输入为实数值向量，计算这些输入的线性组合，如果结果大于某个阈值则输出1，否则输出-1。
  
  $ o(x_1, ..., x_n) = cases(
    1 "if" w_0 + w_1 x_1 + ... + w_n x_n > 0,
    -1 "otherwise"
  ) $
  
  其中$w_0$是偏置（阈值），$w_1, ..., w_n$是权重。
]

#figure(
  caption: [感知器结构],
  cetz.canvas({
    import cetz.draw: *
    
    // 输入节点
    circle((-3, 1), radius: 0.3, fill: rgb("#e3f2fd"), stroke: 1pt)
    circle((-3, 0), radius: 0.3, fill: rgb("#e3f2fd"), stroke: 1pt)
    circle((-3, -1), radius: 0.3, fill: rgb("#e3f2fd"), stroke: 1pt)
    content((-3, 1.6), [$x_1$])
    content((-3, 0.6), [$x_2$])
    content((-3, -0.4), [$x_3$])
    content((-3, -1.4), [$dots.v$])
    
    // 权重标签
    content((-1.8, 1.3), [$w_1$])
    content((-1.8, 0.3), [$w_2$])
    content((-1.8, -0.7), [$w_3$])
    
    // 连接线
    line((-2.7, 1), (-0.8, 0), stroke: 1pt)
    line((-2.7, 0), (-0.8, 0), stroke: 1pt)
    line((-2.7, -1), (-0.8, 0), stroke: 1pt)
    
    // 求和节点
    circle((0, 0), radius: 0.8, fill: rgb("#fff3e0"), stroke: 1.5pt)
    content((0, 0), [$sum$])
    
    // 偏置输入
    content((-1.5, -1.8), [$w_0$ (偏置)])
    line((-1.2, -1.5), (-0.5, -0.5), stroke: 1pt)
    
    // 激活函数
    content((1.2, 0), [$->$])
    
    // 输出
    rect((1.8, -0.5), (3.2, 0.5), fill: rgb("#e8f5e9"), stroke: 1pt, radius: 0.1)
    content((2.5, 0), [阶跃函数])
    
    // 最终输出
    line((3.2, 0), (4, 0), stroke: 1pt)
    circle((4.3, 0), radius: 0.3, fill: rgb("#ffcdd2"), stroke: 1pt)
    content((4.3, 0), [$o$])
  })
)



== Sigmoid单元

#definition[Sigmoid函数][
  $ sigma(x) = 1 / (1 + e^(-x)) $
  
  性质：
输出范围$(0, 1)$; #h(1em)
可微分; #h(1em) \
#h(2em)导数为
$ dif sigma(x)/dif x = sigma(x)(1 - sigma(x)) $
]

#figure(
  caption: [Sigmoid函数图像],
  cetz.canvas({
    import cetz.draw: *
    
    // 坐标轴
    line((-4, 0), (4, 0), stroke: 1pt, mark: (end: ">"))
    line((0, -0.5), (0, 3), stroke: 1pt, mark: (end: ">"))
    content((4.3, 0), [$x$])
    content((0, 3.3), [$sigma(x)$])
    
    // Sigmoid曲线 - 手动绘制关键点
    let sigmoid(x) = 2.5 / (1 + calc.exp(-x))
    
    // 绘制曲线
    let points = ()
    for x in (-40, -35, -30, -25, -20, -15, -10, -5, 0, 5, 10, 15, 20, 25, 30, 35, 40) {
      let x-val = x / 10
      let y-val = sigmoid(x-val)
      points.push((x-val, y-val))
    }
    
    // 用线段连接
    for i in range(points.len() - 1) {
      line(points.at(i), points.at(i + 1), stroke: 2pt + rgb("#2196f3"))
    }
    
    // 标注
    content((0, -0.4), [$0$])
    content((3.5, 1.5), [$sigma(x) = 1/(1+e^(-x))$])
    
    // 关键点标注
    circle((0, 1.25), radius: 0.08, fill: rgb("#f44336"), stroke: none)
    content((0.5, 1.5), [(0, 0.5)])
  })
)
== 训练规则：Delta法则与梯度下降

#definition[感知器训练规则][
  $ w_i <- w_i + Delta w_i $
  $ Delta w_i = eta (t - o) x_i $
  
  其中：
  *$t$*：目标输出 #h(1em)
  *$o$*：实际输出 #h(1em)
  *$eta$*：学习率（如0.1）
]


#definition[Delta法则（最小平方误差下的学习规则）][
  对于输出为连续值的线性单元（$o = w_0 + sum_i w_i x_i$），目标是最小化平方误差
  $E = frac(1,2)(t - o)^2$。对权值做梯度下降得到：

  $Delta w_i = -eta (partial E) / (partial w_i) = eta (t - o) x_i$

  该规则称为Delta法则（或Widrow-Hoff规则）。
]

#definition[感知器规则 vs Delta法则][
  统一实验参数：学习率 $eta=0.1$，单输入特征 $x_i=1$，目标输出 $t=1$

  *感知器规则* \
  基于阶跃输出（离散0/1），仅在误分类、误差不为0时更新权重，预测完全正确时权重不发生变化，无梯度求解，不能用于可微激活函数优化，仅适配线性可分数据集。
  示例：
  - 预测正确：实际输出 $o=1$，误差 $t-o=0$，$Delta w_i=0$，权重不更新
  - 预测错误：实际输出 $o=0$，误差 $t-o=1$，$Delta w_i=0.1 times 1 times 1=0.1$，权重纠错更新

  *Delta法则* \
  基于可微连续输出，依靠梯度下降最小化平方误差，只要存在误差就会更新权重，哪怕预测接近正确，也会微调参数优化精度，适配线性单元、Sigmoid等可微激活函数，支持线性不可分数据集优化。
  示例：
  - 近似正确：实际输出 $o=0.9$，误差 $t-o=0.1$，$Delta w_i=0.1 times 0.1 times 1=0.01$，权重小幅微调
  - 误差较大：实际输出 $o=0.2$，误差 $t-o=0.8$，$Delta w_i=0.1 times 0.8 times 1=0.08$，权重大幅优化
]

#definition[梯度下降（批量）][
  - *批量梯度下降（Batch GD）*：在每次更新时对全部训练样本求和，更新为
    $Delta w_i = eta sum_(d in D) (t_d - o_d) x_(i d)$。
  - 优点：沿总体负梯度方向稳定下降；缺点：每步代价高，可能陷入局部极小值。
]

#definition[随机梯度下降（SGD）及小批量（Mini-batch）][
  - *随机梯度下降（SGD）*：对每个训练样例单独更新：$Delta w_i = eta (t - o) x_i$。
  - *小批量SGD*：每次使用一小批样本计算近似梯度，平衡稳定性与效率。
  - SGD更新噪声较大，但通常收敛更快且能帮助跳出浅局部极小值。
]

#property[学习率与收敛行为][
  - 若学习率$eta$过大：更新可能发散或在最小值附近剧烈震荡（不收敛）。
  - 若$eta$过小：收敛太慢，训练耗时长。
  - 常用技巧：学习率衰减、动量(momentum)项、以及自适应优化器（如AdaGrad、RMSprop、Adam）。
]

== 多层神经网络与BP算法

#figure(
  caption: [多层前馈神经网络结构],
  cetz.canvas({
    import cetz.draw: *
    
    // 输入层
    for i in (-1.5, -0.5, 0.5, 1.5) {
      circle((-3, i), radius: 0.25, fill: rgb("#e3f2fd"), stroke: 1pt)
    }
    content((-3, 2.2), [输入层])
    content((-3, -2.2), [$x_1, x_2, x_3, x_4$])
    
    // 隐藏层
    for i in (-1, 0, 1) {
      circle((0, i), radius: 0.25, fill: rgb("#fff3e0"), stroke: 1pt)
    }
    content((0, 2.2), [隐藏层])
    
    // 输出层
    for i in (-0.5, 0.5) {
      circle((3, i), radius: 0.25, fill: rgb("#e8f5e9"), stroke: 1pt)
    }
    content((3, 2.2), [输出层])
    content((3, -1.5), [$o_1, o_2$])
    
    // 连接（输入到隐藏）
    for i in (-1.5, -0.5, 0.5, 1.5) {
      for j in (-1, 0, 1) {
        line((-2.75, i), (-0.25, j), stroke: 0.5pt + gray)
      }
    }
    
    // 连接（隐藏到输出）
    for i in (-1, 0, 1) {
      for j in (-0.5, 0.5) {
        line((0.25, i), (2.75, j), stroke: 0.5pt + gray)
      }
    }
  })
)

#definition[BP算法（反向传播）][
  通过梯度下降最小化误差平方和：
  $ E = 1/2 sum_(d in D) sum_(k in "outputs") (t_(k d) - o_(k d))^2 $
]

#property[BP算法步骤][
  1. *前向传播*：计算网络输出
  2. *计算误差*：比较输出与目标
  3. *反向传播*：将误差从输出层传回隐藏层
  4. *更新权重*：沿负梯度方向调整权重
  
  权重更新公式：
  $ Delta w_(j i) = eta delta_j x_(j i) $
  
  其中$delta_j$是单元$j$的误差项：
  - 输出单元：$delta_j = o_j (1 - o_j) (t_j - o_j)$
  - 隐藏单元：$delta_j = o_j (1 - o_j) sum_k w_(k j) delta_k$
]

#problemset[]

#example[课堂作业][关于单层感知器的表征能力，以下哪项描述是正确的？

#choices(
 [只要神经元足够多，单层感知器就能解决异或（XOR）问题。],
[ 单层感知器只能处理线性可分的数据。],
[单层感知器无法实现“与（AND）”逻辑。],
[只要学习率足够小，单层感知器在处理线性不可分数据时一定能收敛。]
)
]
#solution[
  答案: B
   单层感知器是线性分类器，只能学习并分离线性可分的数据，无法解决异或等线性不可分问题。
]

#example[课堂作业][在梯度下降算法中，如果学习率 $eta$ 设得过大，最可能出现的结果是？

#choices(
[收敛速度变得极快，迅速到达最小值。],
[权重更新量变为 0。],
[算法在最小值附近剧烈摆动，甚至离最小值越来越远（发散）。],
[算法会陷入局部极小值。],
)
]
#solution[
- 答案: C
- 解释: 学习率过大会导致每步更新幅度太大，梯度下降在最小值附近震荡或直接发散。
]

#example[课堂作业][Delta 法则（梯度下降）相比于感知器训练规则，在处理“非线性可分”数据时有什么核心优势？请简要说明。]

#solution[
- 感知器法则在面对非线性可分数据时会持续振荡、无法收敛，因为它强求零错误。
- Delta 法则通过最小化平方误差，即使在不可分的情况下，也能通过梯度下降找到一个使总误差达到局部或全局最小的权向量 w。它不会死循环，而是停留在 “尽可能好” 的位置。
]

#example[课堂作业][假设有一个单层线性单元（无阈值），初始权重 $w_1 = 0.5, w_2 = 0.5$，偏置 $b = 0$。现在输入一个样本 $x_1 = 1, x_2 = 2$，目标值 $t = 1$。

 (a) 请计算该单元的当前输出 $o$（按 $o = b + w_1 x_1 + w_2 x_2$ 计算）。

 (b) 如果学习率 $eta = 0.1$，请根据 Delta 规则计算 $w_1$ 更新后的新值（只写出 $w_1$ 的新值）。]

#solution[
- (a) 计算: $o = 0 + 0.5 times 1 + 0.5 times 2 = 0.5 + 1 = 1.5$。
- (b) Delta 更新规则: $w_1' = w_1 + eta (t - o) x_1 = 0.5 + 0.1times(1 - 1.5) times 1 = 0.5 - 0.05 = 0.45$。
]

#example[作业题目][
  设计一个两输入的感知器来实现布尔函数 $A and not B$。\ 设计一个两层的感知器网络来实现布尔函数 $A "XOR" B$。
]

#solution[
  *(1) 实现 $A and not B$*：真值表如下（$A, B in {0, 1}$）：

  #align(center)[ 
    #table(
      columns: (auto, auto, auto), align: center,
      [*$A$*], [*$B$*], [*$A and not B$*],
      [0], [0], [0], [0], [1], [0], [1], [0], [1], [1], [1], [0],
    )
  ]

  取权值：偏置 $w_0 = -0.5$，$w_1 = 1$，$w_2 = -1$。验证：
  - $A=0, B=0$：$-0.5 + 0 + 0 = -0.5 <= 0 arrow.r 0$
  - $A=0, B=1$：$-0.5 + 0 - 1 = -1.5 <= 0 arrow.r 0$
  - $A=1, B=0$：$-0.5 + 1 + 0 = 0.5 > 0 arrow.r 1$
  - $A=1, B=1$：$-0.5 + 1 - 1 = -0.5 <= 0 arrow.r 0$
#figure(
  caption: [单层感知器实现 $A "and not" B$],
  cetz.canvas({
    import cetz.draw: *
    
    // 输入节点 (输入层与偏置)
    circle((-2.5, 1.5), radius: 0.35, fill: rgb("#e3f2fd"), stroke: 1pt, name: "bias")
    content("bias", [$+1$])
    content((-2.5, 2.1), [偏置输入])

    circle((-2.5, 0), radius: 0.35, fill: rgb("#e3f2fd"), stroke: 1pt, name: "A")
    content("A", [$A$])
    
    circle((-2.5, -1.5), radius: 0.35, fill: rgb("#e3f2fd"), stroke: 1pt, name: "B")
    content("B", [$B$])
    content((-2.5, -2.1), [输入层])
    
    // 输出节点
    circle((1.5, 0), radius: 0.45, fill: rgb("#e8f5e9"), stroke: 1pt, name: "Y")
    content("Y", [$f$])
    content((1.5, 0.7), [输出层])
    content((2.8, 0), [$A and not B$])
    
    // 带有箭头的连接线
    line("bias", "Y", mark: (end: ">"), stroke: 0.8pt)
    line("A", "Y", mark: (end: ">"), stroke: 0.8pt)
    line("B", "Y", mark: (end: ">"), stroke: 0.8pt)
    
    // 权重标注
    content((-0.5, 1.0), [$w_0 = -0.5$])
    content((-0.5, 0.25), [$w_1 = 1$])
    content((-0.5, -0.5), [$w_2 = -1$])
  })
)
  *(2) 实现 $A "XOR" B$*：XOR 线性不可分，需要两层网络。利用 $A "XOR" B = (A or B) and not (A and B)$：

  - *隐藏层节点 $h_1$*（$A or B$）：$w_0 = -0.5, w_1 = 1, w_2 = 1$
  - *隐藏层节点 $h_2$*（$A and B$）：$w_0 = -1.5, w_1 = 1, w_2 = 1$
  - *输出层*（$h_1 and not h_2$）：$w_0 = -0.5, w_(h 1) = 1, w_(h 2) = -1$
#figure(
  caption: [两层前馈感知器网络实现 $A "XOR" B$],
  cetz.canvas({
    import cetz.draw: *
    
    // 输入层
    circle((-3, 1.0), radius: 0.35, fill: rgb("#e3f2fd"), stroke: 1pt, name: "A")
    content("A", [$A$])
    
    circle((-3, -1.0), radius: 0.35, fill: rgb("#e3f2fd"), stroke: 1pt, name: "B")
    content("B", [$B$])
    content((-3, -1.8), [输入层])
    
    // 隐藏层
    circle((0, 1.2), radius: 0.45, fill: rgb("#fff3e0"), stroke: 1pt, name: "h1")
    content("h1", [$h_1$])
    content((0, 1.9), [$h_1$ (OR)])
    
    circle((0, -1.2), radius: 0.45, fill: rgb("#fff3e0"), stroke: 1pt, name: "h2")
    content("h2", [$h_2$])
    content((0, -1.9), [$h_2$ (AND)])
    content((0, -0.5), [隐藏层])
    
    // 输出层
    circle((3, 0), radius: 0.45, fill: rgb("#e8f5e9"), stroke: 1pt, name: "Y")
    content("Y", [$y$])
    content((3, 0.7), [$y$ (XOR)])
    content((3, -0.9), [输出层])
    
    // 连接线：输入层 -> 隐藏层
    line("A", "h1", mark: (end: ">"), stroke: 0.8pt)
    line("A", "h2", mark: (end: ">"), stroke: 0.8pt)
    line("B", "h1", mark: (end: ">"), stroke: 0.8pt)
    line("B", "h2", mark: (end: ">"), stroke: 0.8pt)
    
    // 连接线：隐藏层 -> 输出层
    line("h1", "Y", mark: (end: ">"), stroke: 0.8pt)
    line("h2", "Y", mark: (end: ">"), stroke: 0.8pt)
    
    // 独立偏置输入箭头与标注
    line((0, 2.7), "h1", mark: (end: ">"), stroke: 0.8pt + gray)
    content((0, 2.9), [偏置 $w_0 = -0.5$])
    
    line((0, -2.7), "h2", mark: (end: ">"), stroke: 0.8pt + gray)
    content((0, -2.9), [偏置 $w_0 = -1.5$])
    
    line((3, 1.6), "Y", mark: (end: ">"), stroke: 0.8pt + gray)
    content((3, 1.8), [偏置 $w_0 = -0.5$])
    
    // 权重标注 (输入到隐藏)
    content((-1.6, 1.3), [$1$])
    content((-1.6, 0.35), [$1$])
    content((-1.6, -0.35), [$1$])
    content((-1.6, -1.3), [$1$])
    
    // 权重标注 (隐藏到输出)
    content((1.5, 0.8), [$1$])
    content((1.5, -0.8), [$-1$])
  })
)
]



#example[作业题][
  感知器 $A$ 权值：$w_0 = 1, w_1 = 2, w_2 = 1$；感知器 $B$ 权值：$w_0 = 0, w_1 = 2, w_2 = 1$。判断：感知器 $A$ 是否 more_general_than 感知器 $B$？
]

#solution[
  *结论：正确*。

  感知器 $B$ 判定为真的条件：$2x_1 + x_2 > 0$ \
  #h(2em)感知器 $A$ 判定为真的条件：$1 + 2x_1 + x_2 > 0 arrow.r.double 2x_1 + x_2 > -1$

  若实例满足 $2x_1 + x_2 > 0$，必然也满足 $2x_1 + x_2 > -1$。即 $B$ 的所有正例 $A$ 也都判为正例，且 $A$ 的正例覆盖范围更大（如满足 $-1 < 2x_1 + x_2 <= 0$ 的点 $B$ 判负但 $A$ 判正）。因此 $A$ 比 $B$ 更一般。
]



#example[作业题][
  推导输出为 $o = w_0 + w_1 x_1 + w_1 x_1^2 + dots + w_n x_n + w_n x_n^2$ 的单个单元梯度下降训练法则。
]

#solution[
  目标：最小化 $E(bold(w)) = 1/2 sum_(d in D) (t_d - o_d)^2$，更新公式 $Delta w_i = -eta frac(partial E, partial w_i)$。

  输出函数可写为 $o = w_0 + sum_(j=1)^n w_j (x_j + x_j^2)$。

  *偏置项 $w_0$*：
  $ frac(partial E, partial w_0) = - sum_(d in D) (t_d - o_d) dot 1 $因此 $Delta w_0 = eta sum_(d in D) (t_d - o_d)$

  *权值 $w_i (i = 1, dots, n)$*：
  $ frac(partial o, partial w_i) = x_i + x_i^2 $因此
  $ frac(partial E, partial w_i) = - sum_(d in D) (t_d - o_d) (x_i + x_i^2) $

  最终：$Delta w_i = eta sum_(d in D) (t_d - o_d) (x_i + x_i^2)$
]

#example[作业题][
  两层前馈 ANN：输入 $a, b$，隐藏单元 $c$，输出单元 $d$。五个权值 $(w_(c a), w_(c b), w_(c 0), w_(d c), w_(d 0))$ 初始化为 $(0.1, 0.1, 0.1, 0.1, 0.1)$。学习率 $eta = 0.3$，冲量 $alpha = 0.9$，增量更新，Sigmoid 激活。

  #align(center)[#table(columns: (1cm, 1cm, 1cm), align: center, [*a*], [*b*], [*d*], [1], [0], [1], [0], [1], [0])]

  给出前两次迭代中每次权值的值。
]

#solution[
  激活函数 $sigma(y) = 1/(1+e^(-y))$，$sigma'(y) = sigma(y)(1-sigma(y))$。

  *第一次迭代（样例 a=1, b=0, target=1）*：
  - 前向：$"net"_c = 0.1 times 1 + 0.1 times 0 + 0.1 = 0.2$，$o_c = sigma(0.2) approx 0.5498$
  - $"net"_d = 0.1 times 0.5498 + 0.1 = 0.1550$，$o_d = sigma(0.1550) approx 0.5387$
  - 反向误差：$delta_d = 0.5387 times 0.4613 times 0.4613 approx 0.1146$，$delta_c = 0.5498 times 0.4502 times (0.1 times 0.1146) approx 0.0028$
  - 更新（初始动量为0）：$Delta w_(d 0) = 0.0344$，$Delta w_(d c) = 0.0189$，$Delta w_(c 0) = 0.0008$，$Delta w_(c a) = 0.0008$，$Delta w_(c b) = 0$
  - *第一轮后权值*：$(0.1008, 0.1000, 0.1008, 0.1189, 0.1344)$

  *第二次迭代（样例 a=0, b=1, target=0）*：
  - 前向：$"net"_c = 0.2008$，$o_c approx 0.5501$；$"net"_d approx 0.1998$，$o_d approx 0.5498$
  - 反向：$delta_d approx -0.1361$，$delta_c approx -0.0040$
  - 含冲量更新 $Delta w(t) = eta delta x + alpha Delta w_(t-1)$：
    $Delta w'_(d 0) approx -0.0098$，$Delta w'_(d c) approx -0.0055$，$Delta w'_(c 0) approx -0.0005$，$Delta w'_(c a) approx 0.0007$，$Delta w'_(c b) approx -0.0012$
  - *第二轮后权值*：$(0.1015, 0.0988, 0.1003, 0.1134, 0.1246)$
]



#pagebreak()
 = 贝叶斯学习

#introduction[贝叶斯定理][MAP/ML假设][朴素贝叶斯][贝叶斯最优分类器][Gibbs算法][交叉熵损失]

== 贝叶斯定理

#definition[贝叶斯定理][
  贝叶斯定理提供了一种从先验概率 $P(h)$ 计算后验概率 $P(h|D)$ 的方法：
  
  $ P(h|D) = (P(D|h) P(h)) / P(D) $
  
  其中：
  - $P(h)$：*先验概率*，在观察数据前假设 $h$ 成立的概率
  - $P(D|h)$：*似然*，假设 $h$ 成立时观察到数据 $D$ 的概率
  - $P(h|D)$：*后验概率*，给定数据 $D$ 时假设 $h$ 成立的概率
  - $P(D)$：*证据*，归一化常数，$P(D) = sum_(h' in H) P(D|h')P(h')$
]

#property[基本概率公式总结][
  - *乘法规则*：$P(A and B) = P(A|B)P(B) = P(B|A)P(A)$
  - *加法规则*：$P(A or B) = P(A) + P(B) - P(A and B)$
  - *全概率公式*：若 $A_1, ..., A_n$ 互斥且完备，则 $P(B) = sum_(i=1)^n P(A_i)P(B|A_i)$
]

== MAP与ML假设

#definition[MAP假设（最大后验）][
  给定数据 $D$，在所有假设 $H$ 中寻找使后验概率最大的假设：
  
  $ h_"MAP" = arg max_(h in H) P(h|D) = arg max_(h in H) P(D|h) P(h) $
  
  由于 $P(D)$ 与 $h$ 无关，最大化时可忽略分母。
]

#definition[ML假设（最大似然）][
  当所有假设具有相同的先验概率时（$P(h_i) = P(h_j)$ 对所有 $i,j$），MAP假设等价于使 $P(D|h)$ 最大的假设：
  
  $ h_"ML" = arg max_(h in H) P(D|h) $
]

#note[
  *MAP vs ML 关键区别*：
  - MAP考虑先验知识 $P(h)$，ML不考虑
  - 当 $P(h)$ 均匀分布时，$h_"MAP" = h_"ML"$
  - 贝叶斯推理强烈依赖于先验概率的选择
]


#example[癌症检测问题 - 完整计算][
  *已知条件*：
  - 假设：$h_1 = "cancer"$，$h_2 = "not cancer"$
  - 先验概率：$P("cancer") = 0.008$，$P("not cancer") = 0.992$
  - 测试准确率：$P(+|"cancer") = 0.98$，$P(-|"cancer") = 0.02$
  - 假阳性率：$P(+|"not cancer") = 0.03$，$P(-|"not cancer") = 0.97$
  
  *问题*：测试结果为阳性，患者是否患癌？
  
]
#solution[

  步骤1：计算似然与先验的乘积
  $ P(+|"cancer")P("cancer") = 0.98 times 0.008 = 0.0078 $
  $ P(+|"not cancer")P("not cancer") = 0.03 times 0.992 = 0.0298 $
  
  步骤2：确定MAP假设
  $ h_"MAP" = "not cancer" $ （因为 $0.0298 > 0.0078$）
  
  步骤3：计算归一化后验概率
  $ P(D) = 0.0078 + 0.0298 = 0.0376 $
  $ P("cancer"|+) = 0.0078 / 0.0376 approx 0.2075 = 20.75% $
  $ P("not cancer"|+) = 0.0298 / 0.0376 approx 0.7925 = 79.25% $
  
  *结论*：尽管测试为阳性，但患癌后验概率只有约21%。这说明*先验概率*的重要性——对于罕见疾病（先验仅0.8%），即使检测准确率很高，阳性结果也不一定意味着患病。
]

== Brute-Force贝叶斯概念学习

#definition[Brute-Force MAP学习算法][
  对于有限假设空间 $H$，学习目标概念 $c: X -> {0,1}$：
  
  1. 对 $H$ 中每个假设 $h$，计算后验概率 $P(h|D) = P(D|h)P(h)/P(D)$
  2. 输出 $h_"MAP" = arg max_(h in H) P(h|D)$
]

#property[概念学习的概率设定][
  在以下假定条件下：
  - 训练数据 $D$ 无噪声（$d_i = c(x_i)$）
  - 目标概念 $c in H$
  - 假设空间上均匀先验：$P(h) = 1/((|H|))$ 对所有 $h in H$
  
  则有：
  $ P(D|h) = cases(1 "if" h "与" D "一致", 0 "otherwise") $
]

#theorem[一致学习器输出MAP假设][
  在上述概率设定下，任意*一致学习器*（输出假设在训练样例上零错误率）都输出一个MAP假设。
  
  对于与 $D$ 一致的假设 $h$：
  $ P(h|D) = (1 times 1/(|H|)) / ((|"VS"_(H,D)|)/(|H|)) = 1/(|"VS"_(H,D)|) $
  
  其中 $"VS"_(H,D)$ 是变型空间（与 $D$ 一致的假设集合）。
]

== 用于预测概率的极大似然假设

#definition[预测概率的学习任务][
  学习目标函数 $f': X -> [0,1]$，使得 $f'(x) = P(f(x)=1)$。
  
  给定训练样例 $D = {chevron.l x_i, d_i chevron.r}$，其中 $d_i in {0, 1}$。
]

#theorem[交叉熵损失与极大似然][
  在上述设定下，最大化 $P(D|h)$ 等价于最小化交叉熵（Cross Entropy）损失：
  
  $ G(h, D) = - sum_(i=1)^m [d_i ln h(x_i) + (1-d_i) ln(1-h(x_i))] $
]

#proof[
  *推导过程*：
  
  对于单个样例：
  $ P(d_i|h) = cases(h(x_i) "if" d_i = 1, 1-h(x_i) "if" d_i = 0) = h(x_i)^(d_i) (1-h(x_i))^(1-d_i) $
  
  对所有独立样例：
  $ P(D|h) = product_(i=1)^m h(x_i)^(d_i) (1-h(x_i))^(1-d_i) $
  
  取对数：
  $ ln P(D|h) = sum_(i=1)^m [d_i ln h(x_i) + (1-d_i) ln(1-h(x_i))] $
  
  最大化 $ln P(D|h)$ 等价于最小化其负值（即交叉熵损失）。
]


== 贝叶斯最优分类器

#definition[贝叶斯最优分类器][
  问题：给定数据 $D$，对新实例 $x$ 的最可能分类是什么？
  
  最优分类通过合并所有假设的预测，用后验概率加权得到：
  
  $ P(v_j|D) = sum_(h_i in H) P(v_j|h_i) P(h_i|D) $
  
  $ v_"optimal" = arg max_(v_j in V) P(v_j|D) $
]

#example[最优分类器 vs MAP假设][
  假设：$P(h_1|D)=0.4$，$P(h_2|D)=0.3$，$P(h_3|D)=0.3$
  
  对新实例 $x$：
  - $h_1(x) = 1$，$h_2(x) = 0$，$h_3(x) = 0$
  
  *MAP假设方法*：选择 $h_1$，输出分类 $1$
  
  *最优分类器方法*：
  $ P(1|D) = P(1|h_1)P(h_1|D) + P(1|h_2)P(h_2|D) + P(1|h_3)P(h_3|D) $
  $ = 1 times 0.4 + 0 times 0.3 + 0 times 0.3 = 0.4 $
  
  $ P(0|D) = 0 times 0.4 + 1 times 0.3 + 1 times 0.3 = 0.6 $
  
  $ v_"optimal" = 0 $（因为 $0.6 > 0.4$）
  
  *结论*：最可能的分类（0）与MAP假设给出的分类（1）可能不同！
]

== Gibbs算法

#definition[Gibbs算法][
  贝叶斯最优分类器计算开销大，Gibbs算法提供了一种近似方法：
  
  1. 按照假设空间 $H$ 上的后验概率分布 $P(h|D)$，随机选择假设 $h$
  2. 使用 $h$ 预测新实例 $x$ 的分类
  
  *理论保证*：Gibbs算法的分类错误率期望至多是贝叶斯最优分类器的两倍。
]

== 朴素贝叶斯分类器

#definition[朴素贝叶斯分类器][
  学习任务：给定属性值 $chevron.l a_1, ..., a_n chevron.r$，预测目标值 $v$
  
  MAP分类：
  $ v_"MAP" = arg max_(v_j in V) P(v_j) P(a_1, ..., a_n|v_j) $
  
  *朴素假设*：在给定目标值时，各属性条件独立
  $ P(a_1, ..., a_n|v_j) = product_i P(a_i|v_j) $
  
  朴素贝叶斯分类器：
  $ v_"NB" = arg max_(v_j in V) P(v_j) product_i P(a_i|v_j) $
]

#example[Play Tennis问题 - 完整计算][
  *训练数据*（14个样例）：
  
  #align(center)[
    #table(
      columns: (auto, auto, auto, auto, auto, auto),
      inset: 4pt, align: center,
      table.header([Day], [Outlook], [Temp], [Humidity], [Wind], [Play]),
      [D1], [Sunny], [Hot], [High], [Weak], [No],
      [D2], [Sunny], [Hot], [High], [Strong], [No],
      [D3], [Overcast], [Hot], [High], [Weak], [Yes],
      [D4], [Rain], [Mild], [High], [Weak], [Yes],
      [D5], [Rain], [Cool], [Normal], [Weak], [Yes],
      [D6], [Rain], [Cool], [Normal], [Strong], [No],
      [D7], [Overcast], [Cool], [Normal], [Strong], [Yes],
      [D8], [Sunny], [Mild], [High], [Weak], [No],
      [D9], [Sunny], [Cool], [Normal], [Weak], [Yes],
      [D10], [Rain], [Mild], [Normal], [Weak], [Yes],
      [D11], [Sunny], [Mild], [Normal], [Strong], [Yes],
      [D12], [Overcast], [Mild], [High], [Strong], [Yes],
      [D13], [Overcast], [Hot], [Normal], [Weak], [Yes],
      [D14], [Rain], [Mild], [High], [Strong], [No],
    )
  ]
  
  *测试样例*：$chevron.l "Sunny", "Cool", "High", "Strong" chevron.r$
]
#solution[
  
  先验概率：
  $ P("Yes") = 9/14 = 0.64 $ $ P("No") = 5/14 = 0.36 $
  
  条件概率（频率估计）：
  $ P("Sunny"|"Yes") = 2/9 = 0.22 $ $ P("Sunny"|"No") = 3/5 = 0.60 $
  $ P("Cool"|"Yes") = 3/9 = 0.33 $ $ P("Cool"|"No") = 1/5 = 0.20 $
  $ P("High"|"Yes") = 3/9 = 0.33 $ $ P("High"|"No") = 4/5 = 0.80 $
  $ P("Strong"|"Yes") = 3/9 = 0.33 $ $ P("Strong"|"No") = 3/5 = 0.60 $
  
  计算后验分子：
  $ P("Yes") P("Sunny"|"Yes") P("Cool"|"Yes") P("High"|"Yes") P("Strong"|"Yes") $
  $ = 0.64 times 0.22 times 0.33 times 0.33 times 0.33 approx 0.0053 $
  
  $ P("No") P("Sunny"|"No") P("Cool"|"No") P("High"|"No") P("Strong"|"No") $
  $ = 0.36 times 0.60 times 0.20 times 0.80 times 0.60 approx 0.0206 $
  
  *结论*：$v_"NB" = "No"$（因为 $0.0206 > 0.0053$）
]
== 平滑估计
#definition[m-估计（平滑处理）][
  当样本量小时，用频率估计概率可能出现零概率问题。m-估计引入先验：
  
  $ P(a_i|v_j) = (n_c + m p) / (n + m) $
  
  其中：
  - $n$：训练样例中 $v_j$ 出现的次数
  - $n_c$：其中属性 $a_i$ 出现的次数
  - $p$：先验估计（如均匀先验 $p = 1/k$，$k$ 为属性取值数）
  - $m$：等效样本大小（虚拟样本数）
]

== 应考要点

#property[贝叶斯学习考点][
  1. *贝叶斯公式应用*：会计算后验概率，注意归一化
  2. *MAP vs ML*：理解区别，当先验相等时二者等价
  3. *癌症检测问题*：理解先验概率对结果的影响（罕见疾病阳性≠患病）
  4. *平方误差与ML*：记住高斯噪声下二者等价，能写出推导
  5. *交叉熵*：二分类问题中，最大化似然 = 最小化交叉熵
  6. *最优分类器*：会计算 $P(v_j|D) = sum_h P(v_j|h)P(h|D)$
  7. *朴素贝叶斯*：条件独立性假设，会计算分类结果
  8. *m-估计*：处理零概率问题
]

#problemset[

#example[作业6.1 - 两次化验问题][
  在6.2.1节癌症检测例中，医生对该病人做第二次独立化验测试，结果也为正。根据两次测试，$"cancer"$ 和 $not "cancer"$ 的后验概率分别是多少？假定两个测试在给定患病状态下相互独立。

  已知：$P("cancer") = 0.008$，$P(not "cancer") = 0.992$，$P(+ | "cancer") = 0.98$，$P(+ | not "cancer") = 0.03$。
]

#solution[
  设两次化验结果 $D = (+_1, +_2)$，由条件独立性：

  $P(D | "cancer") = 0.98 times 0.98 = 0.9604$
  $P(D | not "cancer") = 0.03 times 0.03 = 0.0009$

  未归一化的后验分子：
  - $P(D | "cancer") P("cancer") = 0.9604 times 0.008 = 0.0076832$
  - $P(D | not "cancer") P(not "cancer") = 0.0009 times 0.992 = 0.0008928$

  归一化：$P(D) = 0.0076832 + 0.0008928 = 0.008576$

  $P("cancer" | +, +) = 0.0076832 / 0.008576 approx 0.8959 approx 89.6%$
  $P(not "cancer" | +, +) = 0.0008928 / 0.008576 approx 0.1041 approx 10.4%$
  
  *结论*：两次阳性结果后，患癌概率从约21%上升到约90%。
]

#example[作业6.2 - 归一化方法证明][
  证明6.2.1节中通过将 $P(+|"cancer")P("cancer")$ 和 $P(+|not"cancer")P(not"cancer")$ 归一化来计算后验概率的方法是正确的（即等价于贝叶斯公式）。
]

#proof[
  需证：$P("cancer" | +) = (P(+ | "cancer") P("cancer")) / (P(+ | "cancer") P("cancer") + P(+ | not "cancer") P(not "cancer"))$

  1. *贝叶斯公式*：$P("cancer" | +) = (P(+ | "cancer") P("cancer")) / P(+)$
  2. *全概率公式*：由于 $"cancer"$ 和 $not "cancer"$ 构成完备事件组，
     $P(+) = P(+ | "cancer") P("cancer") + P(+ | not "cancer") P(not "cancer")$
     
  3. 代入即得。分母 $P(+)$ 本质上是所有假设的"似然×先验"之和，起归一化作用。
]

#example[补充习题 - Brute-Force MAP][
  考虑一个概念学习问题，假设空间 $H$ 包含10个假设，训练数据 $D$ 与其中3个假设一致。若假设空间上均匀先验，计算与 $D$ 一致的假设的后验概率。
]

#solution[
  给定条件：
  - $(|H|) = 10$，$|"VS"_(H,D)| = 3$（变型空间大小）
  - 均匀先验：$P(h) = 1/10$ 对所有 $h in H$
  - 对与 $D$ 一致的 $h$：$P(D|h) = 1$
  - 对与 $D$ 不一致的 $h$：$P(D|h) = 0$
  
  计算 $P(D)$：
  $ P(D) = sum_(h in H) P(D|h)P(h) = 3 times (1 times 1/10) + 7 times (0 times 1/10) = 3/10 $
  
  对与 $D$ 一致的假设：
  $ P(h|D) = (P(D|h)P(h)) / P(D) = (1 times 1/10) / (3/10) = 1/3 $
  
  与 $D$ 不一致的假设后验概率为0。
]

#example[补充习题 - 最优分类器计算][
  假设有3个假设 $h_1, h_2, h_3$，后验概率分别为 $P(h_1|D)=0.5$，$P(h_2|D)=0.3$，$P(h_3|D)=0.2$。对新实例 $x$：
  - $h_1(x)=1$，$h_2(x)=0$，$h_3(x)=0$
  
  求：(1) MAP假设给出的分类；(2) 贝叶斯最优分类器给出的分类。
]

#solution[
  *(1) MAP假设*：
  $h_1$ 后验概率最大（0.5），所以MAP分类为 $h_1(x) = 1$
  
  *(2) 贝叶斯最优分类器*：
  $ P(1|D) = sum_h P(1|h)P(h|D) = 1 times 0.5 + 0 times 0.3 + 0 times 0.2 = 0.5 $
  $ P(0|D) = sum_h P(0|h)P(h|D) = 0 times 0.5 + 1 times 0.3 + 1 times 0.2 = 0.5 $
  
  两者相等，可任意选择（通常选1或根据额外规则）。
  
  *注意*：若 $P(h_2|D)=0.4$，$P(h_3|D)=0.1$，则 $P(0|D)=0.5 > P(1|D)=0.5$，此时最优分类与MAP不同！
]

#example[][
  给定以下训练数据，用朴素贝叶斯分类器预测新实例 $x = chevron.l a_1=T, a_2=T chevron.r$ 的类别。
  
  #align(center)[
    #table(
      columns: (auto, auto, auto),
      inset: 5pt, align: center,
      table.header([实例], [$a_1$], [$a_2$], [类别]),
      [1], [T], [T], [+],
      [2], [T], [F], [+],
      [3], [F], [T], [-],
      [4], [F], [F], [-],
    )
  ]
]

#solution[
  计算先验：
  $ P(+) = 2/4 = 0.5 $$ P(-) = 2/4 = 0.5 $
  
  计算条件概率：
  $ P(a_1=T|+) = 2/2 = 1 $$ P(a_1=T|-) = 0/2 = 0 $
  $ P(a_2=T|+) = 1/2 = 0.5 $$ P(a_2=T|-) = 1/2 = 0.5 $
  
  计算后验分子：
  $ P(+) P(a_1=T|+) P(a_2=T|+) = 0.5 times 1 times 0.5 = 0.25 $
  $ P(-) P(a_1=T|-) P(a_2=T|-) = 0.5 times 0 times 0.5 = 0 $
  
  *结论*：$v_"NB" = +$（正类）
  
  *注意*：由于 $P(a_1=T|-)=0$ 导致零概率问题，实践中应使用m-估计平滑。
]

#example[课堂回顾作业：交叉熵损失与极大似然][
  对于二分类问题，训练神经网络，请证明其最大似然估计（MLE）的损失对应交叉熵损失。
]

#proof[
  *1. 模型设定*：
  在二分类任务中，目标值 $d_i in {0, 1}$。神经网络的输出 $h(x_i)$ 通常经过 Sigmoid 激活函数，表示预测结果为正例（类"1"）的概率：
  $ P(d_i = 1 | x_i, h) = h(x_i) $
  $ P(d_i = 0 | x_i, h) = 1 - h(x_i) $
  
  这可以统一写成伯努利分布的形式：
  $ P(d_i | x_i, h) = h(x_i)^(d_i) (1 - h(x_i))^(1 - d_i) $

  *2. 建立似然函数*：
  假设训练样本 $(x_i, d_i)$ 是独立同分布（i.i.d.）的，则整个数据集 $D$ 的似然函数为所有样本概率的乘积：
  $ P(D | h) = product_(i=1)^m h(x_i)^(d_i) (1 - h(x_i))^(1 - d_i) $

  *3. 最大化对数似然*：
  为了数值计算方便，对似然函数取对数：
  $ ln P(D | h) = sum_(i=1)^m [ln(h(x_i)^(d_i) (1 - h(x_i))^(1 - d_i))] = sum_(i=1)^m [d_i ln h(x_i) + (1 - d_i) ln (1 - h(x_i))] $

  *4. 结论*：
  极大似然估计的目标是最大化 $ln P(D | h)$。在机器学习中，我们习惯于最小化损失函数。因此，定义损失函数为负对数似然（NLL）：
  $ E = - ln P(D | h) = - sum_(i=1)^m [d_i ln h(x_i) + (1 - d_i) ln (1 - h(x_i))] $
  
  这正是二分类问题的*交叉熵损失函数*。证明完毕。
]
]



#pagebreak(weak: true)
 = 基于实例的学习

#introduction[K近邻][局部加权回归][惰性学习]

== K近邻算法

#definition[K近邻 (KNN)][
  给定查询实例$x_q$，在训练样例中找出距离$x_q$最近的$k$个实例，然后根据这$k$个邻居的类别进行投票。
]

#property[距离度量][
  - *欧氏距离*：$d(x, y) = sqrt(sum_i (x_i - y_i)^2)$
  - *曼哈顿距离*：$d(x, y) = sum_i |x_i - y_i|$
  - *闵可夫斯基距离*：$d(x, y) = (sum_i |x_i - y_i|^p)^(1/p)$
]

#property[KNN算法流程][
  *训练阶段*：
  对于每个训练样例 $<x, f(x)>$，将其存入训练样例列表

  *分类阶段*（对查询实例 $x_q$）：
  1. 在训练样例中选择 $k$ 个与 $x_q$ 最近的实例 $x_1, ..., x_k$
  2. 返回 $hat(f)(x_q) = arg max_(v in V) sum_(i=1)^k delta(v, f(x_i))$

  其中 $delta(a,b) = cases(1 "if" a=b, 0 "otherwise")$
]

#property[学习实值目标函数][
  对于实值函数 $f: RR^n -> RR$，KNN用 $k$ 个最近邻训练样本的均值作为预测：
  $ hat(f)(x_q) = 1/k sum_(i=1)^k f(x_i) $
]

#example[KNN分类例题 - 离散值][
  给定以下训练数据（二维特征空间）：

  #align(center)[
    #table(
      columns: (auto, auto, auto, auto),
      inset: 5pt, align: center,
      table.header([样本], [$x_1$], [$x_2$], [类别]),
      [$x_1$], [1], [1], [A],
      [$x_2$], [2], [1], [A],
      [$x_3$], [1], [2], [A],
      [$x_4$], [5], [5], [B],
      [$x_5$], [6], [5], [B],
      [$x_6$], [5], [6], [B],
    )
  ]

  查询点 $x_q = (3, 3)$，分别用 $k=1$ 和 $k=3$ 进行分类。
]

#solution[
  *(1) 计算欧氏距离*：

  $d(x_q, x_1) = sqrt((3-1)^2 + (3-1)^2) = sqrt(8) approx 2.83$

  $d(x_q, x_2) = sqrt((3-2)^2 + (3-1)^2) = sqrt(5) approx 2.24$

  $d(x_q, x_3) = sqrt((3-1)^2 + (3-2)^2) = sqrt(5) approx 2.24$

  $d(x_q, x_4) = sqrt((3-5)^2 + (3-5)^2) = sqrt(8) approx 2.83$

  $d(x_q, x_5) = sqrt((3-6)^2 + (3-5)^2) = sqrt(13) approx 3.61$

  $d(x_q, x_6) = sqrt((3-5)^2 + (3-6)^2) = sqrt(13) approx 3.61$

  *(2) $k=1$ 分类*：

  最近邻是 $x_2$ 或 $x_3$（距离均为2.24），类别为A

  $hat(f)(x_q) = "A"$

  *(3) $k=3$ 分类*：

  3个最近邻：$x_2$(A), $x_3$(A), $x_1$或$x_4$(距离相同)

  - 若选 $x_1$：3个邻居为 A, A, A $->$ 类别A
  - 若选 $x_4$：3个邻居为 A, A, B $->$ 类别A（2票>1票）

  无论哪种情况，$hat(f)(x_q) = "A"$
]


#figure(
  caption: [KNN分类示意图],
  cetz.canvas({
    import cetz.draw: *
    
    // 绘制一些训练样本点
    // 类别A（蓝色）
    circle((-2, 1.5), radius: 0.15, fill: rgb("#2196f3"), stroke: none)
    circle((-1.5, 2), radius: 0.15, fill: rgb("#2196f3"), stroke: none)
    circle((-2.5, 0.5), radius: 0.15, fill: rgb("#2196f3"), stroke: none)
    circle((-1, 1), radius: 0.15, fill: rgb("#2196f3"), stroke: none)
    circle((-3, 2), radius: 0.15, fill: rgb("#2196f3"), stroke: none)
    
    // 类别B（红色）
    circle((2, 1.5), radius: 0.15, fill: rgb("#f44336"), stroke: none)
    circle((1.5, 2), radius: 0.15, fill: rgb("#f44336"), stroke: none)
    circle((2.5, 0.5), radius: 0.15, fill: rgb("#f44336"), stroke: none)
    circle((1, 1), radius: 0.15, fill: rgb("#f44336"), stroke: none)
    circle((3, 2), radius: 0.15, fill: rgb("#f44336"), stroke: none)
    
    // 查询点
    circle((0, 1), radius: 0.2, fill: rgb("#ffeb3b"), stroke: 2pt)
    content((0, 0.5), [$x_q$ (查询点)])
    
    // K=3的圆圈
    circle((0, 1), radius: 1.2, stroke: 1pt + rgb("#4caf50"), fill: none)
    content((0.8, 2.3), [$k=3$])
    
    // 图例
    circle((-2.5, -1), radius: 0.15, fill: rgb("#2196f3"), stroke: none)
    content((-1.8, -1), [类别A])
    circle((0, -1), radius: 0.15, fill: rgb("#f44336"), stroke: none)
    content((0.7, -1), [类别B])
    circle((2.5, -1), radius: 0.15, fill: rgb("#ffeb3b"), stroke: 1pt)
    content((3.2, -1), [查询点])
  })
)

== 距离加权KNN

#definition[距离加权KNN][
  根据距离对k-近邻样本进行加权，距离越近权重越大。

  *离散值目标函数*：
  $ hat(f)(x_q) = arg max_(v in V) sum_(i=1)^k w_i delta(v, f(x_i)) $，其中 $w_i = 1/(d(x_q, x_i)^2)$

  *实值目标函数*：
  $ hat(f)(x_q) = (sum_(i=1)^k w_i f(x_i)) / (sum_(i=1)^k w_i) $
]

#property[距离加权KNN算法细节][
  *特殊情况处理*：
  - 如果 $d(x_q, x_i)^2 = 0$（即查询点与训练样例重合），则 $hat(f)(x_q) = f(x_i)$
  - 如果存在多个零距离样本，取其中样本数最多的类别

  *权重函数选择*：
  - 常用：$w_i = 1/d(x_q, x_i)^2$（反距离平方加权）
  - 也可使用：$w_i = 1/d(x_q, x_i)$ 或其他核函数
]


#example[距离加权KNN例题][
  使用上例数据，查询点 $x_q = (3, 3)$，取 $k=3$，用距离加权KNN进行分类。
]

#solution[
  3个最近邻及其距离：
  - $x_2 = (2, 1)$，类别A，$d = sqrt(5) approx 2.236$
  - $x_3 = (1, 2)$，类别A，$d = sqrt(5) approx 2.236$
  - $x_1 = (1, 1)$，类别A，$d = sqrt(8) approx 2.828$ 或 $x_4 = (5, 5)$，类别B，$d = sqrt(8) approx 2.828$

  由于 $x_1$ 和 $x_4$ 距离相同，考虑两种情况的加权投票：

  *情况1*：选择 $x_1$（类别A）
  - $w_2 = 1/5 = 0.2$，$w_3 = 1/5 = 0.2$，$w_1 = 1/8 = 0.125$
  - A类权重：$0.2 + 0.2 + 0.125 = 0.525$
  - B类权重：$0$
  - 结果：A

  *情况2*：选择 $x_4$（类别B）
  - $w_2 = 1/5 = 0.2$，$w_3 = 1/5 = 0.2$，$w_4 = 1/8 = 0.125$
  - A类权重：$0.2 + 0.2 = 0.4$
  - B类权重：$0.125$
  - 结果：A（$0.4 > 0.125$）

  无论哪种情况，距离加权KNN都预测为类别A。
]

#note[
  *考点*：距离加权KNN对噪声更鲁棒，因为距离远的邻居权重小，可以平滑掉孤立噪声点的影响。
]

== 维度灾难

#definition[维度灾难 (Curse of Dimensionality)][
  随着维数$d$增加，空间体积呈指数增长，固定数量的训练样本变得极度稀疏，任意两点间的距离趋于相等，导致KNN分类器失效。
]

#property[维度灾难的数学解释][
  考虑$d$维单位超立方体 $[0,1]^d$：
  - 要覆盖一定比例的体积，需要的边长随$d$指数增长
  - 在$d$维空间中，两点间的距离分布变得更加集中
  - 最近邻的距离与最远邻的距离比值趋近于1

  *后果*：
  - 距离度量失去区分能力
  - KNN算法需要指数级增长的训练样本
]

#property[克服维度灾难的方法][
  1. *属性加权/坐标轴缩放*：
     - 对第$j$维乘缩放因子$z_j$，相当于伸展第$j$个坐标轴
     - 用交叉验证选取最佳$z_j$
     - 极端情况：$z_j = 0$ 即删除该属性

  2. *特征选择*：
     - 采用基于留一法（leave-one-out）的交叉验证
     - 选择对分类有贡献的属性子集

  3. *变化的值伸展属性坐标轴*：
     - 自由度高，但也增加了过拟合风险
]

#example[维度灾难例题][
  解释为什么在高维空间中，KNN算法会失效？并说明如何通过属性加权来缓解这一问题。
]

#solution[
  *(1) 失效原因*：

  在高维空间中，数据点变得极度稀疏。假设训练样本均匀分布在$d$维单位超立方体中，要使邻域包含固定比例的样本，邻域边长需要随$d$指数增长。这导致：
  - 近邻概念变得模糊（所有点距离都很大且相近）
  - 距离度量失去区分不同类别的能力

  *(2) 属性加权缓解方法*：

  实际中类别相关属性只占少数，通过属性加权：
  - 给重要属性较大的权重$z_j$，增加其在距离计算中的贡献
  - 给无关属性较小的权重（甚至$z_j=0$），减少其干扰
  - 使用交叉验证确定最优权重组合

  修改后的距离：$d(x, y) = sqrt(sum_j z_j (x_j - y_j)^2)$
]

#note[
  *考点*：维度灾难是KNN等基于距离的方法在高维数据上的根本限制，特征选择和降维是主要解决手段。
]

== 局部加权回归

#definition[局部加权回归 (Locally Weighted Regression)][
  对KNN的推广：在查询点$x_q$的局部邻域内，用加权训练样本构造目标函数的局部逼近$hat(f)$，然后用$hat(f)(x_q)$作为预测值。

  *局部加权线性回归*：用线性函数$hat(f)(x) = w_0 + w_1 a_1(x) + ... + w_n a_n(x)$逼近邻域内的目标函数。
]

#property[三种误差准则][
  设 $hat(f)(x) = sum_(j=0)^n w_j a_j(x)$，其中 $a_0(x) = 1$（偏置项）：

  *准则1* - 仅k近邻的误差平方和最小：
  $ E_1(x_q) = 1/2 sum_(x in "k-NN"(x_q)) (f(x) - hat(f)(x))^2 $

  *准则2* - 全部样本的距离加权误差平方和：
  $ E_2(x_q) = 1/2 sum_(x in D) K(d(x_q, x))(f(x) - hat(f)(x))^2 $

  *准则3* - 两者结合（k近邻且距离加权）：
  $ E_3(x_q) = 1/2 sum_(x in "k-NN"(x_q)) K(d(x_q, x))(f(x) - hat(f)(x))^2 $

  其中 $K(d(x_q, x))$ 是核函数（距离权重函数），如 $K(d) = e^(-d^2/(2sigma^2))$
]

#property[梯度下降更新公式][
  对准则3，梯度下降更新公式为：
  $ Delta w_j = eta sum_(x in "k-NN"(x_q)) K(d(x_q, x))(f(x) - hat(f)(x)) a_j(x) $

  *推导思路*：
  $ frac(partial E_3, partial w_j) = - sum_(x in "k-NN"(x_q)) K(d(x_q, x))(f(x) - hat(f)(x)) a_j(x) $

  因此 $Delta w_j = -eta frac(partial E_3, partial w_j)$ 得到上述公式。
]

#property[准则选择分析][
  - *准则2*：考虑全部样本，效果最好但计算量大
  - *准则3*：准则2的近似，只考虑k近邻，计算代价低
  - *准则1*：不考虑距离权重，对噪声不够鲁棒
]

#note[
  *术语说明*：
  - *回归（Regression）*：逼近实值目标函数
  - *残差（Residual）*：$f(x) - hat(f)(x)$，逼近误差
  - *核函数（Kernel function）*：$K(d(x_q, x))$，决定训练样例权值的距离函数
]

#example[局部加权回归例题][
  假设有一维数据：$(1, 2), (2, 3), (3, 5), (4, 4), (5, 6)$，用局部加权线性回归预测 $x_q = 2.5$ 处的值，取 $k=3$，使用距离平方的倒数作为权重。
]

#solution[
  *(1) 选择k近邻*：

  距离 $|x - 2.5|$：
  - $(1, 2)$：距离1.5
  - $(2, 3)$：距离0.5
  - $(3, 5)$：距离0.5
  - $(4, 4)$：距离1.5
  - $(5, 6)$：距离2.5

  3个最近邻：$(2, 3), (3, 5), (1, 2)$ 或 $(4, 4)$

  取 $(2, 3), (3, 5), (4, 4)$（距离分别为0.5, 0.5, 1.5）

  *(2) 计算权重*：
  - $w_1 = 1/(0.5)^2 = 4$
  - $w_2 = 1/(0.5)^2 = 4$
  - $w_3 = 1/(1.5)^2 = 4/9 approx 0.44$

  *(3) 加权平均预测*（简化版）：

  $hat(f)(2.5) = (4 times 3 + 4 times 5 + 0.44 times 4) / (4 + 4 + 0.44)$

  $= (12 + 20 + 1.76) / 8.44 = 33.76 / 8.44 approx 4.0$

  （注：完整解法应通过最小化加权误差求解线性函数参数）
]

== 径向基函数网络

#definition[径向基函数 (Radial Basis Function, RBF)][
  RBF提供目标函数的全局逼近，由多个局部核函数的线性组合实现：
  $ hat(f)(x) = w_0 + sum_(u=1)^k w_u K_u(d(x_u, x)) $

  其中核函数$K_u$通常为高斯函数：
  $ K_u(d(x_u, x)) = e^(-1/(2 sigma_u^2) d(x_u, x)^2) $

  $x_u$ 是核函数的中心，$sigma_u^2$ 控制核函数的宽度（影响范围）。
]

#property[RBF网络结构][
  *RBF可看作两层神经网络*：
  - *第一层（隐藏层）*：计算各核函数 $K_u(d(x_u, x))$，具有局部化特性
  - *第二层（输出层）*：第一层输出的线性组合

  *高斯核的性质*：
  - 当 $d(x_u, x) = 0$ 时，$K_u = 1$（最大值）
  - 当 $d(x_u, x) -> infinity$ 时，$K_u -> 0$
  - 宽度 $sigma_u$ 越大，影响范围越广
]

#property[两阶段训练][
  *阶段1* - 确定网络结构：
  - 确定核数目 $k$
  - 选择核中心 $x_u$（常用方法：每样本一个核，或聚类中心）
  - 确定宽度 $sigma_u^2$（可统一或分别设置）

  *阶段2* - 学习输出层权重：
  - 固定第一层参数
  - 通过最小化误差平方和 $E = 1/2 sum_(x in D) (f(x) - hat(f)(x))^2$ 学习 $w_u$
  - 这是线性优化问题，可用解析解或梯度下降
]

#property[核数目的选择][
  1. *每样本一个核*：$k = |D|$，每个训练样本作为核中心
     - 优点：可精确拟合训练数据
     - 缺点：计算量大，可能过拟合

  2. *聚类减少核数*：
     - 在实例空间均匀分布核中心
     - 或用聚类算法（如K-means）找到代表性中心
     - 提高计算效率，减少过拟合
]

#property[RBF与KNN/ANN的关系][
  - *RBF = IBL + ANN的混合*：局部核函数（类似IBL）+ 神经网络结构
  - *vs KNN*：RBF提供全局逼近，KNN对每个查询点重新计算
  - *vs ANN*：RBF训练更高效（两层分别训练），且局部核函数使逼近具有局部有效性
]

#example[RBF网络例题][
  给定一维数据：$(0, 0), (1, 1), (2, 0)$，构建RBF网络，取3个高斯核，中心分别为0, 1, 2，宽度$sigma^2 = 1$。求输出层权重$w_0, w_1, w_2, w_3$的表达式。
]

#solution[
  RBF网络输出：$hat(f)(x) = w_0 + w_1 K_1(x) + w_2 K_2(x) + w_3 K_3(x)$

  其中 $K_u(x) = e^(-(x-x_u)^2/2)$

  对每个训练样本建立方程：

  $hat(f)(0) = w_0 + w_1 e^0 + w_2 e^(-1/2) + w_3 e^(-2) = 0$

  $hat(f)(1) = w_0 + w_1 e^(-1/2) + w_2 e^0 + w_3 e^(-1/2) = 1$

  $hat(f)(2) = w_0 + w_1 e^(-2) + w_2 e^(-1/2) + w_3 e^0 = 0$

  这是关于 $w_0, w_1, w_2, w_3$ 的线性方程组（3个方程4个未知数），可添加正则化项或使用伪逆求解最小二乘解。

  *数值近似*（$e^(-0.5) approx 0.607, e^(-2) approx 0.135$）：

  $w_0 + w_1 + 0.607 w_2 + 0.135 w_3 = 0$

  $w_0 + 0.607 w_1 + w_2 + 0.607 w_3 = 1$

  $w_0 + 0.135 w_1 + 0.607 w_2 + w_3 = 0$
]

#note[
  *考点*：RBF的核心是局部核函数的全局线性组合，训练高效且具有良好的逼近能力。
]

== 惰性学习 vs 积极学习

#property[对比][
  - *惰性学习 (Lazy)*：KNN、局部加权回归。训练时只存储样本，泛化时考虑查询点信息，用多个局部逼近组合表示目标函数
  - *积极学习 (Eager)*：RBF、决策树、ANN。训练时完成全局逼近函数的学习，泛化时不考虑查询点
  - *核心差异*：泛化时是否利用查询点$x_q$的信息
]

#property[惰性学习特点][
  *优点*：
  - 用不太复杂的局部逼近函数集构造复杂目标函数
  - 不会损失训练样例的任何信息（保存全部原始数据）
  - 训练时间极短（只需存储）

  *缺点*：
  - 分类/预测效率低（需要实时计算距离和搜索）
  - 合适的实例距离度量函数难以构造
  - 无关特征对距离计算的副作用大
]

#property[积极学习特点][
  *优点*：
  - 泛化时计算速度快（只需前向传播）
  - 训练阶段完成知识提取和压缩

  *缺点*：
  - 训练时间较长
  - 可能丢失训练数据中的细节信息
]

#property[计算时间对比][
  #align(center)[
    #table(
      columns: (auto, auto, auto),
      inset: 6pt, align: center,
      table.header([方法], [训练时间], [泛化时间]),
      [KNN], [短（存储）], [长（搜索近邻）],
      [局部加权回归], [短（存储）], [长（局部优化）],
      [RBF], [中等], [短],
      [决策树], [中等], [短],
      [ANN], [长], [短],
    )
  ]
]

#property[RBF的特殊性][
  RBF可看作*IBL + ANN的混合*：
  - 由多个局部核函数的线性组合实现全局逼近
  - 但*并非针对查询点的局部逼近*（泛化时不考虑$x_q$）
  - 因此属于积极学习方法
]

#example[惰性vs积极学习例题][
  分析以下算法属于惰性学习还是积极学习，并说明理由：
  (1) K近邻算法
  (2) 径向基函数网络
  (3) 多层神经网络
  (4) 局部加权回归
]

#solution[
  *(1) K近邻算法* - 惰性学习

  理由：训练时只存储训练样本，分类时才根据查询点$x_q$搜索最近邻。泛化时利用了$x_q$的位置信息。

  *(2) 径向基函数网络* - 积极学习

  理由：训练时完成两层网络参数的学习，泛化时只需前向传播计算输出，不再考虑查询点的具体位置信息。

  *(3) 多层神经网络* - 积极学习

  理由：训练时学习网络权重，泛化时直接使用训练好的网络进行预测。

  *(4) 局部加权回归* - 惰性学习

  理由：训练时只存储样本，预测时为每个查询点$x_q$单独构造局部逼近函数。
]

== 应考要点

#property[基于实例的学习考点][
  1. *KNN算法*：
     - 算法流程（训练+分类）
     - 距离度量公式（欧氏、曼哈顿、闵可夫斯基）
     - $k$值选择的影响

  2. *距离加权KNN*：
     - 权重公式 $w_i = 1/d^2$
     - 离散值和实值目标函数的预测公式

  3. *维度灾难*：
     - 产生原因（高维空间稀疏性）
     - 解决方法（属性加权、特征选择）

  4. *局部加权回归*：
     - 三种误差准则的区别
     - 梯度下降更新公式的推导思路

  5. *RBF网络*：
     - 高斯核函数公式
     - 两层网络结构
     - 两阶段训练过程

  6. *惰性学习vs积极学习*：
     - 核心区别（泛化时是否利用$x_q$信息）
     - 各类算法的分类
]

#problemset[

#example[课堂作业][考虑以下一维数据集：$(1, 2), (2, 4), (3, 3), (4, 5), (5, 4)$。使用 $k=3$ 的KNN算法预测 $x_q = 2.5$ 处的值。
]

#solution[
  *(1) 计算欧氏距离*：

  $|2.5 - 1| = 1.5$，$|2.5 - 2| = 0.5$，$|2.5 - 3| = 0.5$，$|2.5 - 4| = 1.5$，$|2.5 - 5| = 2.5$

  *(2) 选择3个最近邻*：$(2, 4), (3, 3), (1, 2)$ 或 $(4, 5)$

  若选 $(2, 4), (3, 3), (1, 2)$：$hat(f)(2.5) = (4 + 3 + 2)/3 = 3$

  若选 $(2, 4), (3, 3), (4, 5)$：$hat(f)(2.5) = (4 + 3 + 5)/3 = 4$

  取平均：$hat(f)(2.5) approx 3.5$
]

#example[作业8.1 - KNN分类][
  考虑以下二维数据集，两类问题：

  正类(+)：$(0,0), (0,1), (1,0), (1,1)$

  负类(-)：$(3,3), (3,4), (4,3), (4,4)$

  (a) 用1-NN预测点 $(2, 2)$ 的类别

  (b) 用3-NN预测点 $(2, 2)$ 的类别
]

#solution[
  *(a) 1-NN*：

  点$(2,2)$到正类最近距离：$sqrt((2-1)^2 + (2-1)^2) = sqrt(2) approx 1.41$

  点$(2,2)$到负类最近距离：$sqrt((2-3)^2 + (2-3)^2) = sqrt(2) approx 1.41$

  距离相等，可任意选择或根据具体规则（如先遇到的）。假设选正类。

  *(b) 3-NN*：

  3个最近邻居：$(1,1)$[正], $(1,0)$或$(0,1)$[正], $(3,3)$[负]

  正类2票，负类1票，预测为正类(+)。
]

#example[作业题 - 距离计算][
  给定点 $x = (1, 2, 3)$ 和 $y = (4, 0, 3)$，计算：

  (a) 欧氏距离

  (b) 曼哈顿距离

  (c) 闵可夫斯基距离（p=3）
]

#solution[
  *(a) 欧氏距离*：

  $d(x, y) = sqrt((1-4)^2 + (2-0)^2 + (3-3)^2) = sqrt(9 + 4 + 0) = sqrt(13) approx 3.61$

  *(b) 曼哈顿距离*：

  $d(x, y) = |1-4| + |2-0| + |3-3| = 3 + 2 + 0 = 5$

  *(c) 闵可夫斯基距离（p=3）*：

  $d(x, y) = (|1-4|^3 + |2-0|^3 + |3-3|^3)^(1/3) = (27 + 8 + 0)^(1/3) = 35^(1/3) approx 3.27$
]

#example[题目][
  在距离加权局部线性逼近中，查询点 $x_q$ 附近的线性逼近函数为 $hat(f)(x) = sum_(j=0)^n w_j a_j(x)$（其中 $a_0(x) = 1$）。已知权值训练法则为：
  $ Delta w_j = eta sum_{x in x_q "的" k "个近邻"} K(d(x_q, x)) (f(x) - hat(f)(x)) a_j(x) $
  请推导该梯度下降法则。
]

#proof[
  定义局部误差函数（引入距离权重 $K(d(x_q, x))$ 使近邻影响更大）：
  $ E(w) = 1/2 sum_{x in "k-NN"(x_q)} K(d(x_q, x)) (f(x) - hat(f)(x))^2 $

  对 $w_j$ 求偏导：
  $ frac(partial E, partial w_j) = 1/2 sum_{x} K(d(x_q, x)) dot 2(f(x) - hat(f)(x)) dot frac(partial, partial w_j)(f(x) - hat(f)(x)) $

  由于 $hat(f)(x) = sum_(i=0)^n w_i a_i(x)$，故 $frac(partial, partial w_j)(f(x) - hat(f)(x)) = -a_j(x)$。代入：

  $ frac(partial E, partial w_j) = - sum_{x} K(d(x_q, x)) (f(x) - hat(f)(x)) a_j(x) $

  梯度下降更新：$Delta w_j = -eta frac(partial E, partial w_j) = eta sum_{x in "k-NN"(x_q)} K(d(x_q, x)) (f(x) - hat(f)(x)) a_j(x)$

  与题目公式一致，得证。
]

#example[题目][
  说明KNN算法中"维度灾难"的产生原因，并给出两种缓解方法。
]

#solution[
  *原因*：随特征维数$d$增加，空间体积呈指数增长，固定数量的训练样本变得极度稀疏，任意两点间的距离趋于相等，最近邻失去区分能力。

  *缓解方法*：
  1. *属性加权/坐标轴缩放*：对第$j$维乘缩放因子$z_j$，用交叉验证选取最优$z_j$。极端情况$z_j=0$即删除该属性
  2. *特征选择*：用留一法交叉验证选择属性子集，只保留对分类有贡献的属性
]

#example[补充习题 - 三种误差准则比较][
  局部加权回归中有三种误差准则：

  $E_1$：仅k近邻的误差平方和

  $E_2$：全部样本的距离加权误差平方和

  $E_3$：k近邻的距离加权误差平方和

  比较三者的计算复杂度和对噪声的鲁棒性。
]

#solution[
  *计算复杂度*（从低到高）：$E_1 < E_3 < E_2$
  - $E_1$：只考虑k个近邻，不考虑距离权重，计算最简单
  - $E_3$：只考虑k个近邻，但需计算距离权重
  - $E_2$：考虑全部样本，计算量最大

  *对噪声的鲁棒性*（从低到高）：$E_1 < E_2 approx E_3$
  - $E_1$：k近邻中可能包含噪声点，且无距离加权
  - $E_3$：k近邻且距离加权，远处噪声影响小
  - $E_2$：全部样本距离加权，远处样本权重极小，效果类似$E_3$

  *实际选择*：$E_3$是较好的折中，计算量适中且鲁棒性好。
]

#example[补充习题 - RBF核函数][
  高斯核函数 $K(d) = e^(-d^2/(2sigma^2))$，分析宽度参数 $sigma$ 对核函数的影响：

  (a) 当 $sigma$ 很大时，核函数有什么特性？

  (b) 当 $sigma$ 很小时，核函数有什么特性？
]

#solution[
  *(a) $sigma$ 很大时*：

  $d^2/(2sigma^2) -> 0$，因此 $K(d) -> e^0 = 1$

  核函数变得平坦，影响范围广，不同核之间重叠严重。

  *(b) $sigma$ 很小时*：

  即使$d$稍大，$d^2/(2sigma^2)$也会很大，$K(d) -> 0$

  核函数变得尖锐，只在中心附近有影响，不同核之间几乎不重叠。

  *实际应用*：$sigma$ 的选择需要在平滑性和局部性之间权衡。
]

#example[补充习题 - 综合计算][
  给定二维数据集：$A(1,1), B(2,2), C(3,1), D(5,4), E(6,5)$，其中A,B,C为正类，D,E为负类。

  (a) 用 $k=3$ 的KNN预测点 $(4, 2)$ 的类别（用欧氏距离）

  (b) 用距离加权KNN（$w = 1/d^2$）重新预测
]

#solution[
  *(a) KNN ($k=3$)*：

  计算距离：
  - $d((4,2), A) = sqrt(9+1) = sqrt(10) approx 3.16$
  - $d((4,2), B) = sqrt(4+0) = 2$
  - $d((4,2), C) = sqrt(1+1) = sqrt(2) approx 1.41$
  - $d((4,2), D) = sqrt(1+4) = sqrt(5) approx 2.24$
  - $d((4,2), E) = sqrt(4+9) = sqrt(13) approx 3.61$

  3个最近邻：C(正), B(正), D(负)

  投票：正类2票，负类1票，预测为正类。

  *(b) 距离加权KNN*：

  同样选择C, B, D三个近邻

  权重：
  - $w_C = 1/2 = 0.5$
  - $w_B = 1/4 = 0.25$
  - $w_D = 1/5 = 0.2$

  正类权重：$0.5 + 0.25 = 0.75$

  负类权重：$0.2$

  加权投票结果：正类
]
]


#pagebreak()
= 遗传算法

#introduction[生物进化启发][位串编码][选择交叉变异][适应度函数][GA参数][拥挤效应][TSP问题]

== 动机与背景

#property[为什么要用遗传算法][
  - *进化是健壮的*：自然界进化能处理复杂、难以建模的相互作用
  - *非梯度搜索*：不需要计算损失函数的梯度，适用于不可导或离散问题
  - *并行性*：群体中的多个个体可同时评估，易于并行化
  - *全局搜索*：不易陷入局部最优，能探索复杂搜索空间
]

#definition[从盲目搜索到GA][
  *盲目生成-测试*：随机生成解，测试性能，直到足够好
  - 问题：解空间太大时无法穷举

  *遗传算法改进*：
  1. 生成一个解的集合（群体）
  2. 测试并排序集合中每个解
  3. 移除不好的解，复制好的解
  4. 对解做出小改变（交叉、变异）
  5. 重复直到收敛
]

== GA基本流程示例

以下通过函数优化问题展示GA的完整流程：

#example[GA求解函数最大值][
  *问题*：在 $x in [0, 63]$ 范围内寻找使 $f(x)$ 最大的 $x$

  *Step 1: 编码*
  - 用6位二进制串表示 $x$：$000000_2 = 0$ 到 $111111_2 = 63$
  - 例：$101011_2 = 43$，$100011_2 = 35$

  *Step 2: 生成初始群体*（设群体大小为20）
  #align(center)[
    #table(
      columns: (auto, auto, auto, auto),
      inset: 4pt, align: center,
      table.header([编号], [编码], [$x$], [$f(x)$]),
      [pop 1], [011101], [29], [23250.63],
      [pop 2], [101010], [42], [29885.96],
      [pop 3], [011111], [31], [24989.97],
      [...], [...], [...], [...],
      [pop 20], [001111], [15], [8779.25],
    )
  ]

  *Step 3: 选择*（适应度比例选择）
  - 计算每个个体的*生存率*：$"Survival Rate"_i = "Fitness"_i / sum_j "Fitness"_j$
  - 例：pop 2 生存率 $= 29885.96 / 403200 approx 7.41%$
  - 按概率选择进入下一代的个体

  *Step 4: 交叉*
  - 随机选择父代对（如 pop 1 和 pop 2）
  - 随机选择交叉点（如第3位后）
  - 父代：$011|101$ 和 $100|011$
  - 后代：$011|011$（对应 $x=27$）和 $100|101$（对应 $x=37$）

  *Step 5: 变异*
  - 随机选择变异位点（如后代第1位）
  - $011011 -> 111011$（对应 $x=59$）

  *Step 6: 回到Step 2，直到收敛*
  - 当群体中所有个体相同或相似时停止
  - 例：最终群体全为 $101010$（$x=42$，$f(x)=29885.96$）
]

== GA原型算法

#definition[遗传算法原型 GA(Fitness, fitness_threshold, p, r, m)][
  *参数说明*：
  - $"Fitness"$：适应度评分函数
  - $"fitness_threshold"$：终止阈值
  - $p$：群体大小（假设数量）
  - $r$：每代通过交叉取代的成员比例
  - $m$：变异率

  *算法流程*：

  ```fake
  初始化群体 P
  评估：对P中每个h，计算 Fitness(h)

  while [max Fitness(h)] < fitness_threshold do
  {
    创建新世代 PS：

    1. 选择：按概率选择 (1-r)p 个成员加入PS
       Pr(h_i) = Fitness(h_i) / Σ_j Fitness(h_j)

    2. 交叉：从P中选择 r·p/2 对假设
       应用交叉算子，将所有后代加入PS

    3. 变异：以概率m翻转PS中成员的随机位

    4. 更新：P = PS

    5. 评估：对P中每个h，计算 Fitness(h)
  }

  返回P中适应度最高的假设
  ```
]

== 假设表示（编码）

#property[位串编码][
  假设常用二进制位串表示，便于使用变异和交叉算子。

  *属性编码示例*（Play Tennis问题）：
  - Wind：Strong(1), Weak(0) — 2位
  - Outlook：Sunny(100), Overcast(010), Rain(001) — 3位
  - "不关心"：所有位为1（如Outlook=111表示任意天气）
]

#example[规则编码示例][
  规则：`IF Wind=Strong AND Outlook=Sunny THEN PlayTennis=Yes`

  编码结构：
  #align(center)[
    #table(
      columns: (auto, auto, auto, auto),
      inset: 6pt, align: center,
      table.header([Outlook], [Wind], [PlayTennis], [完整编码]),
      [111 或 100], [10], [10], [100 10 10],
    )
  ]

  - 前件（条件）：Outlook=100, Wind=10
  - 后件（结论）：PlayTennis=10（Yes）

  *规则集*：将多个规则编码连接

  *适应度函数*：$"Fitness"(h) = ("correct"(h))^2$，其中correct是分类正确率
]

== 遗传算子

#definition[交叉算子 (Crossover)][
  通过复制双亲的选定位，从双亲位串产生两个新后代。

  *单点交叉*：随机选一个交叉点，交换该点之后的片段
  #align(center)[
    ```
    父代A: 10110|11100      后代A': 10110|11111
    父代B: 00011|10011  →   后代B': 00011|10000
    ```
  ]

  *两点交叉*：选两个交叉点，交换中间片段
  #align(center)[
    ```
    父代A: 101|1001|100      后代A': 101|1111|100
    父代B: 000|1111|001  →   后代B': 000|1001|001
    ```
  ]

  *均匀交叉*：每位以0.5概率随机来自父代A或B
  #align(center)[
    ```
    父代A: 1011011100
    父代B: 0001110011
    掩码:  1100101010  (随机生成)
    后代:  1011111010  (掩码1取A，0取B)
    ```
  ]
]

#definition[变异算子 (Mutation)][
  对单亲位串的随机位进行翻转（0↔1）。

  *作用*：
  - 引入新的遗传物质，防止群体过早收敛
  - 帮助跳出局部最优解
  - 恢复群体中丢失的等位基因

  *时机*：通常在交叉之后进行
]

== 选择方法

#definition[适应度比例选择（轮盘赌选择）][
  每个假设被选中的概率正比于其适应度：
  $ P(h_i) = ("Fitness"(h_i)) / (sum_j "Fitness"(h_j)) $

  *特点*：
  - 适应度高的个体被选中概率大
  - 但仍有概率选中较差的个体，保持多样性
  - 可能导致高适应度个体迅速占据主导（拥挤问题）
]

#definition[锦标赛选择 (Tournament Selection)][
  1. 随机选择两个（或多个）假设 $h_"high"$ 和 $h_"low"$
  2. 以概率 $p$ 选择适应度高的，以概率 $1-p$ 选择低的
  3. 重复直到选够所需数量

  *优点*：比轮盘赌产生更多样化的群体，缓解拥挤问题
]

#definition[排序选择 (Rank Selection)][
  1. 按适应度对假设进行排序
  2. 选中概率与排序成比例，而非与适应度值成比例

  *优点*：避免高适应度个体过度主导，保持多样性
]

== 旅行商问题（TSP）的GA解法

#example[用GA求解TSP][
  *问题*：6个城市，寻找最短路径访问所有城市并返回起点

  *Step 1: 编码*
  - 用城市序号序列表示路径
  - 例：`3-1-2-4-5-6` 表示从城市3出发，经过1,2,4,5,6，最后回到3

  *Step 2: 适应度评估*
  - 适应度与路径总距离成反比
  - 距离越短，适应度越高

  *Step 3: 交叉（注意合法性）*
  - 问题：普通交叉可能产生重复城市
  - 父代1: `3 1 2 | 4 5 6`
  - 父代2: `1 2 5 | 6 4 3`
  - 普通交叉后代：`1 2 2 4 5 6`（非法！城市2重复）

  *解决方案——修复算子*：
  - 后代1: `1 2 3 4 5 6`（修复重复）
  - 后代2: `3 1 5 6 4 2`（修复重复）

  *Step 4: 变异*
  - *交换变异*：随机交换两个城市位置
    `3 1 2 4 5 6` → `3 5 2 4 1 6`
  - *移位变异*：将一段序列移到另一位置
    `3 1 2 4 5 6` → `3 5 6 1 2 4`
  - *简单倒置变异*：倒置一段序列
    `3 1 2 4 5 6` → `3 4 2 1 5 6`
]

== 假设空间搜索

#property[GA vs 梯度下降][
  *梯度下降*：
  - 从一个假设平滑地移动到新的假设
  - 沿着梯度方向小步前进
  - 容易陷入局部最优

  *遗传算法*：
  - 移动可能非常突然，用完全不同的假设替代双亲
  - 每代产生的是全新群体，而非单点更新
  - 不太可能陷入局部极小值
]

#definition[拥挤问题 (Crowding)][
  *问题*：适应度高的个体迅速繁殖，导致群体中该个体及其相似个体占据很大比例，减少群体多样性，减缓进一步进化。

  *缓解策略*：
  1. *修改选择函数*：使用锦标赛选择或排序选择
  2. *适应度共享*：根据群体中相似个体数量减小该个体适应度
  3. *限制重组*：只允许最相似的个体重组，或按空间分布只允许相邻个体重组
]

== GA优缺点总结

#property[GA优点][
  1. *无需梯度信息*：不需要计算损失函数的梯度
  2. *多目标优化*：可同时优化多个目标函数
  3. *可并行*：群体评估天然并行
  4. *处理复杂空间*：易于处理庞大、难以理解的搜索空间
  5. *应用广泛*：广泛用于优化问题求解
]

#property[GA缺点][
  1. *编码设计难*：假设的编码表示较难定义
  2. *适应度函数难*：理想的适应度函数较难设计
  3. *过早收敛*：容易发生收敛到局部最优
  4. *参数调优难*：种群规模、变异率、交叉率等参数选择困难
  5. *无法利用梯度*：不能使用梯度信息加速收敛
  6. *终止条件难*：判断何时停止较困难
  7. *计算开销大*：需要大量的适应度计算
]

== GA参数设置

#property[关键参数及影响][
  #align(center)[
    #table(
      columns: (auto, auto, auto),
      inset: 6pt, align: left,
      table.header([参数], [典型值], [影响]),
      [群体大小 $p$], [20-200], [越大搜索越充分，但计算开销增加],
      [交叉率 $r$], [0.6-0.9], [过低进化慢，过高可能破坏优良结构],
      [变异率 $m$], [0.001-0.1], [过低易早熟，过高变成随机搜索],
      [选择压力], [适度], [过高减少多样性，过低收敛慢],
    )
  ]

  *注意*：没有通用理论帮助调整参数，需要针对特定问题尝试。
]

== 应考要点

#property[遗传算法考点][
  1. *GA基本流程*：编码→初始群体→选择→交叉→变异→迭代
  2. *编码方式*：位串编码，属性编码，规则编码
  3. *选择方法*：轮盘赌、锦标赛、排序选择，会计算选择概率
  4. *交叉算子*：单点、两点、均匀交叉的特点
  5. *变异作用*：引入新基因，防止早熟
  6. *拥挤问题*：原因（高适应度个体过度繁殖）及解决方法
  7. *适应度函数设计*：常用分类正确率或其平方
  8. *TSP编码*：城市序列，注意交叉后的合法性修复
]

#problemset[
#example[习题9.1 - PlayTennis编码设计][
  为第3章中描述的 PlayTennis 问题设计一个遗传算法，学习合取的分类规则。精确描述其中假设的位串编码和一组交叉算子。
]

#solution[
  *1. 属性编码*（共10位）：
  #align(center)[
    #table(
      columns: (auto, auto, auto),
      inset: 6pt, align: left,
      table.header([属性], [取值], [编码]),
      [Outlook], [Sunny, Overcast, Rain], [3位],
      [Temperature], [Hot, Mild, Cool], [3位],
      [Humidity], [High, Normal], [2位],
      [Wind], [Strong, Weak], [2位],
    )
  ]

  *2. 规则编码*：
  规则 `IF Outlook=Sunny AND Humidity=Normal THEN PlayTennis=Yes`

  编码为：`100 111 01 10`
  - Outlook：100（仅Sunny）
  - Temperature：111（任意）
  - Humidity：01（仅Normal）
  - Wind：10（仅Strong）
  - 后件：Yes

  *3. 交叉算子*：
  - *单点交叉*：随机选位置，交换之后片段
  - *两点交叉*：选两个位置，交换中间片段
  - *均匀交叉*：每位以0.5概率随机来自父代A或B
  - *按属性交叉*：交叉点只在属性边界（保护语义）

  *4. 适应度函数*：$f(h) = ("分类正确率")^2$
]

#example[习题 - 选择概率计算][
  假设群体中有4个个体，适应度分别为：$f(h_1)=100$，$f(h_2)=50$，$f(h_3)=30$，$f(h_4)=20$。

  (1) 用轮盘赌选择，计算每个个体被选中的概率。
  (2) 若要进行锦标赛选择（两两比较，p=0.8），$h_1$ vs $h_2$ 时，$h_1$ 被选中的概率是多少？
]

#solution[
  *(1) 轮盘赌选择概率*：

  总适应度：$sum f = 100 + 50 + 30 + 20 = 200$

  $P(h_1) = 100/200 = 0.50 = 50%$
  $P(h_2) = 50/200 = 0.25 = 25%$
  $P(h_3) = 30/200 = 0.15 = 15%$
  $P(h_4) = 20/200 = 0.10 = 10%$

  *(2) 锦标赛选择*：

  $h_1$ vs $h_2$ 时：
  - $h_1$ 适应度更高
  - 选中概率 $p = 0.8$
]

#example[习题 - 交叉操作][
  给定两个父代位串：
  - 父代A：`10110111`
  - 父代B：`00011100`

  (1) 在位置4后进行单点交叉，写出后代。
  (2) 在位置2和6后进行两点交叉，写出后代。
  (3) 给定掩码 `11001010`，进行均匀交叉，写出后代。
]

#solution[
  *(1) 单点交叉（位置4后）*：
  ```
  父代A: 1011|0111
  父代B: 0001|1100
  后代A': 10111100
  后代B': 00010111
  ```

  *(2) 两点交叉（位置2和6后）*：
  ```
  父代A: 10|1101|11
  父代B: 00|0111|00
  后代A': 10011111
  后代B': 00110100
  ```

  *(3) 均匀交叉（掩码11001010）*：
  ```
  父代A: 1 0 1 1 0 1 1 1
  父代B: 0 0 0 1 1 1 0 0
  掩码:  1 1 0 0 1 0 1 0  (1取A，0取B)
  后代:  1 0 0 1 0 1 1 0
  ```
]

#example[习题 - TSP合法性修复][
  在6城市TSP中，两个父代路径为：
  - 父代1：`3 1 2 4 5 6`
  - 父代2：`1 2 5 6 4 3`

  在位置3后进行单点交叉，产生两个后代。检查后代是否合法（无重复城市），若不合法，用修复算子修复。
]

#solution[
  *交叉操作*：
  ```
  父代1: 3 1 2 | 4 5 6
  父代2: 1 2 5 | 6 4 3
  ```

  *后代1*：`3 1 2 6 4 3`
  - 问题：城市3重复（第1位和第6位），城市5缺失
  - 修复：将第6位的3替换为缺失的5
  - 修复后：`3 1 2 6 4 5`

  *后代2*：`1 2 5 4 5 6`
  - 问题：城市5重复（第3位和第5位），城市3缺失
  - 修复：将第5位的5替换为缺失的3
  - 修复后：`1 2 5 4 3 6`
]

#example[习题 - GA参数分析][
  分析以下GA参数设置的影响：\
  (1) 群体大小 $p$ 过小（如 $p=5$）\
  (2) 变异率 $m$ 过高（如 $m=0.5$） \
  (3) 交叉率 $r$ 过低（如 $r=0.1$）\
]

#solution[
  *(1) 群体大小过小*：
  - 搜索空间覆盖不足
  - 容易早熟收敛到局部最优
  - 遗传多样性不足

  *(2) 变异率过高*：
  - 破坏优良个体的结构
  - 算法退化为随机搜索
  - 难以收敛到最优解

  *(3) 交叉率过低*：
  - 进化速度缓慢
  - 缺乏有效的信息交换
  - 难以组合优良子结构
]
]


#example[课题设计 - 基于轮盘赌选择的TSP遗传算法求解流程][
  旅行商问题（TSP）是一个典型的组合优化问题，其目标是寻找遍历所有城市且总距离最短的路径。由于该问题属于最小化优化，在利用遗传算法（GA）中的轮盘赌机制进行选择时，需要构建合理的数学模型与操作步骤。

  请设计该算法的编码、适应度函数转换方式、轮盘赌选择的具体数学描述以及完整的算法迭代流程。
]

#solution[
  1. 染色体编码与路径表示
  对于含有 $N$ 个城市的 TSP 问题，采用*实数排列编码*（Permutation Encoding）。
  每个个体（染色体）表示为一个城市索引的排列：
  $ X_i = (c_1, c_2, dots, c_N) $
  其中 $c_k in \{1, 2, dots, N\}$ 且互不重复，代表旅行商访问城市的顺序。

  2. 目标函数与适应度函数设计
  由于 TSP 的目标是最小化总路径长度，而轮盘赌选择要求适应度值非负且越大越好。因此，需要对目标函数进行转换。

  - *路径总长度（代价函数）*：
    $ L(X_i) = sum_(j=1)^(N-1) d(c_j, c_(j+1)) + d(c_N, c_1) $
    其中 $d(c_a, c_b)$ 表示城市 $a$ 与城市 $b$ 之间的距离。

  - *适应度函数映射*：
    为防止因个别极差路径导致的选择概率过低，通常采用倒数法或线性尺度变换。此处采用倒数映射：
    $ f(X_i) = 1 / L(X_i) $

  3. 轮盘赌选择算子设计
  设种群规模为 $M$，第 $t$ 代种群为 $\{X_1, X_2, dots, X_M\}$。

  - *步骤 1：计算选择概率 $P(X_i)$*
    每个个体被选中的概率与其适应度成正比：
    $ P(X_i) = f(X_i) / (sum_(j=1)^M f(X_j)) $

  - *步骤 2：计算累计概率 $C_i$*
    构造累加概率区间，用于模拟轮盘的扇区划分：
    $ C_i = sum_(k=1)^i P(X_k), quad (i = 1, 2, dots, M) $
    显而易见，$C_M = 1$。

  - *步骤 3：随机抽样选择*
    1. 产生一个在 $[0, 1)$ 区间均匀分布的随机数 $r$。
    2. 若 $r < C_1$，则选择个体 $X_1$。
    3. 若 $C_(k-1) <= r < C_k$，则选择个体 $X_k$。

  4. 算法整体运行流程
  轮盘赌选择在算法迭代过程中用于挑选亲代个体，进而通过交叉（如顺序交叉 OX）和变异（如变异算子 Swap）产生子代。流程如下：

  #align(center)[
    fig_6()
  ]
]

#pagebreak()
= 回归分析

#introduction[线性回归][逻辑回归][Softmax][交叉熵][正则化]

== 回归学习概念

#definition[回归学习][
  回归学习是有监督学习的一种，核心思想是从连续型统计数据中建立数学模型，用于预测或分类。处理的数据可以是多维的，目标值可以是连续值或离散值。

  *起源*：由达尔文的表兄弟 Francis Galton 于1877年提出。Galton研究豌豆种子尺寸时发现"回归"现象——如果双亲的高度比平均高，子女的身高倾向于向平均身高回归。
]

#example[房屋销售价格预测][
  问题引入：
  #align(center)[
    #table(
      columns: (auto, auto),
      inset: 5pt, align: center,
      table.header([面积($m^2$)],[销售价格（万元）]),
      [123],[250],
      [150],[320],
      [87],[160],
      [102],[220],
      [...],[...],
    )
  ]

  新输入一个面积，如何预测价格？用一条曲线最准确地拟合这些数据。
]

== 单变量线性回归

#definition[单变量线性回归模型][
  假设回归模型为线性函数：
  $ h_theta(x) = theta_0 + theta_1 x $

  其中 $x$ 为特征（如房屋面积），$h_theta(x)$ 为预测值（如房价）。
]

#definition[代价函数 (Cost Function)][
  评价假设好坏的指标——拟合误差越小越好：
  $ J(theta_0, theta_1) = 1/(2m) sum_(i=1)^m (h_theta(x^((i))) - y^((i)))^2 $

  其中 $m$ 为训练样例数量，系数 $1/2$ 是为了后续求导方便。
]

#example[代价函数计算示例][
  给定数据集：$(1,1), (2,2), (3,3)$

  *预测1*：$theta_0 = 0, theta_1 = 1$，则 $h(x) = x$
  $ J(0,1) = 1/(2 times 3) times [(1-1)^2 + (2-2)^2 + (3-3)^2] = 0 $

  *预测2*：$theta_0 = 0, theta_1 = 0.5$，则 $h(x) = 0.5x$
  $ J(0,0.5) = 1/(2 times 3) times [(0.5-1)^2 + (1-2)^2 + (1.5-3)^2] $
  $ = 1/6 times [0.25 + 1 + 2.25] = 0.58 $

  *结论*：$theta_0=0, theta_1=1$ 拟合更好（代价函数值更小）。
]

#figure(
  caption: [线性回归拟合示意图],
  cetz.canvas({
    import cetz.draw: *
    line((-0.5, 0), (5, 0), stroke: 1pt, mark: (end: ">"))
    line((0, -0.5), (0, 4), stroke: 1pt, mark: (end: ">"))
    content((5.3, 0), [$x$])
    content((0, 4.3), [$y$])
    let points = ((0.5, 0.8), (1, 1.5), (1.5, 1.2), (2, 2.3), (2.5, 2.1), (3, 3.0), (3.5, 2.8), (4, 3.5))
    for p in points { circle(p, radius: 0.08, fill: rgb("#2196f3"), stroke: none) }
    line((0.3, 0.4), (4.5, 3.8), stroke: 2pt + rgb("#f44336"))
    line((2, 2.3), (2, 1.9), stroke: 1pt + rgb("#4caf50"))
    content((1.7, 2.1), [残差])
  })
)

#theorem[线性回归代价函数的凸性][
  对于线性回归，代价函数 $J(theta_0, theta_1)$ 与参数的关系一定是碗状的（凸函数），只有一个全局最小值，没有局部极小值。这使得梯度下降一定能收敛到全局最优。
]

== 线性回归求解方法

#property[求解方法][
  1. *最小二乘法（正规方程）*：直接使用数学求解公式，要求 $X$ 列满秩
     $ theta = (X^T X)^(-1) X^T bold(y) $
  2. *梯度下降法*：迭代逼近最优解，适用于大规模数据
]

== 梯度下降详解

#definition[梯度下降 (Gradient Descent)][
  原理：将代价函数比作一座山，站在某个山坡上，寻找下降最快的方向迈出一小步。

  算法步骤：
  1. 确定学习率 $eta$（步长大小）
  2. 给定初始值 $(theta_0, theta_1)$
  3. 确定下降方向（梯度反方向），更新参数
  4. 当下降高度小于某个阈值时停止

  *参数更新规则*：
  $ theta_j := theta_j - eta frac(partial J, partial theta_j) $

  对线性回归展开：
  $ theta_0 := theta_0 - eta/m sum_(i=1)^m (h_theta(x^((i))) - y^((i))) $
  $ theta_1 := theta_1 - eta/m sum_(i=1)^m (h_theta(x^((i))) - y^((i))) dot x^((i)) $
]

#property[梯度下降关键点][
  - *学习率 $eta$ 的选取*：太小收敛慢，太大可能越过最小值（overshoot），需要动态调整
  - *初始点的影响*：非凸函数中不同初始点可能收敛到不同局部最小值；线性回归代价函数是凸函数，只有全局最小值
  - *越接近最小值，下降步伐自然越小*（因为梯度趋近于0）
  - *观察J值*：如果J增大了，说明 $eta$ 太大，需要减小
]

#figure(
  caption: [梯度下降示意——不同初始点收敛到不同局部极小值],
  cetz.canvas({
    import cetz.draw: *
    line((-0.5, 0), (5, 0), stroke: 1pt, mark: (end: ">"))
    line((0, -0.5), (0, 4), stroke: 1pt, mark: (end: ">"))
    content((5.3, 0), [$theta$])
    content((0, 4.3), [$J(theta)$])
    let pts = ((0.5, 3.2), (0.8, 2.0), (1.2, 2.8), (1.5, 1.5), (2.0, 3.5), (2.5, 1.2), (3.0, 2.5), (3.3, 1.0), (3.8, 2.0), (4.2, 2.8))
    for (x, y) in pts { circle((x, y), radius: 0.06, fill: rgb("#2196f3"), stroke: none) }
    for i in range(pts.len() - 1) {
      let (x1, y1) = pts.at(i); let (x2, y2) = pts.at(i + 1)
      line((x1, y1), (x2, y2), stroke: 2pt + rgb("#f44336"))
    }
    circle((0.8, 2.0), radius: 0.12, fill: rgb("#4caf50"), stroke: 2pt)
    content((0.5, 1.6), [局部最小])
    circle((2.5, 1.2), radius: 0.12, fill: rgb("#ff9800"), stroke: 2pt)
    content((2.0, 0.8), [全局最小])
  })
)

== 二分类与逻辑回归

#definition[二分类问题][
  预测值 $y$ 只有两个取值（0或1）。例如垃圾邮件分类、肿瘤诊断、金融欺诈检测。

  如果用线性回归解决二分类：
  - $y$ 的取值并不为0或1，难以解释
  - 离群点会显著影响直线拟合的方向，导致较大偏差
]

#definition[逻辑回归模型][
  使用Sigmoid函数将线性输出映射到 $(0,1)$ 区间，可视为分类概率：

  $ h_theta(x) = sigma(theta^T x) = 1 / (1 + e^(-theta^T x)) $
]

#figure(
  caption: [Sigmoid函数（Logistic函数）图像],
  cetz.canvas({
    import cetz.draw: *
    line((-0.5, 0), (5.5, 0), stroke: 1pt, mark: (end: ">"))
    line((0, -0.5), (0, 3), stroke: 1pt, mark: (end: ">"))
    content((5.8, 0), [$z$])
    content((0, 3.3), [$g(z)$])
    
    // 绘制Sigmoid曲线
    let pts = ()
    let steps = 60
    for i in range(steps + 1) {
      let z = -4.5 + i * (9.0/steps)
      let g = 1.0 / (1.0 + calc.exp(-z))
      pts.push((z + 0.5, g * 2.5))
    }
    for i in range(pts.len() - 1) {
      let (x1, y1) = pts.at(i); let (x2, y2) = pts.at(i + 1)
      line((x1, y1), (x2, y2), stroke: 2pt + rgb("#f44336"))
    }
    
    // 渐近线标注
    content((-0.3, 2.45), [$1$])
    content((-0.3, 0.0), [$0$])
    line((-0.3, 2.5), (5.5, 2.5), stroke: (paint: rgb("#9e9e9e"), dash: "dashed"))
    content((5.2, 0.1), [$0.5$])
    line((-0.3, 1.25), (5.5, 1.25), stroke: (paint: rgb("#9e9e9e"), dash: "dashed"))
  })
)

#property[Sigmoid函数的性质][
  - $sigma(z) in (0,1)$，将任意实数映射到概率区间
  - $sigma(0) = 0.5$，原点处为决策边界
  - $z arrow.r +infinity$ 时 $sigma(z) arrow.r 1$
  - $z arrow.r -infinity$ 时 $sigma(z) arrow.r 0$
  - *求导性质*：$sigma'(z) = sigma(z) (1 - sigma(z))$ （推导中非常有用！）
]

#property[逻辑回归讨论][
  - 逻辑回归本质上是一个线性回归模型 + Sigmoid映射
  - 除Sigmoid外，其他步骤和算法都与线性回归一致
  - Sigmoid函数对离群点带来的偏差有一定的抑制作用
  - 输出 $h_theta(x)$ 可解释为 $P(y=1|x)$ — 分类为1的概率
  - *非线性扩展*：引入高阶项（如 $x_1^2, x_1 x_2$）可实现非线性分类
]

== 逻辑回归的概率输出

#definition[概率输出解释][
  对于输入 $x$，分类结果为类别1和类别0的概率分别为：
  $ P(y=1|x; theta) = h_theta(x) $
  $ P(y=0|x; theta) = 1 - h_theta(x) $

  统一写作：
  $ P(y|x; theta) = h_theta(x)^y (1 - h_theta(x))^(1-y) $
]

== 交叉熵损失函数推导

#theorem[逻辑回归的交叉熵损失][
  基于极大似然估计（MLE）推导：

  似然函数：
  $ P(D|h) = product_(i=1)^m h_theta(x^((i)))^(y^((i))) (1 - h_theta(x^((i))))^(1-y^((i))) $

  取对数：
  $ ell(theta) = sum_(i=1)^m [y^((i)) log h_theta(x^((i))) + (1-y^((i))) log(1-h_theta(x^((i))))] $

  最大化似然等价于最小化负对数似然（交叉熵损失）：
  $ J(theta) = - 1/m sum_(i=1)^m [y^((i)) log h_theta(x^((i))) + (1-y^((i))) log(1-h_theta(x^((i))))] $
]

== 逻辑回归的梯度下降求解

#definition[梯度下降更新规则][
  利用 $sigma'(z) = sigma(z)(1-sigma(z))$ 推导梯度：

  $ frac(partial J, partial theta_j) = 1/m sum_(i=1)^m (h_theta(x^((i))) - y^((i))) x_j^((i)) $

  *参数更新*：
  $ theta_j := theta_j - eta/m sum_(i=1)^m (h_theta(x^((i))) - y^((i))) x_j^((i)) $

  形式上与线性回归完全一致，区别在于 $h_theta(x)$ 不同（线性 vs Sigmoid）。
]

#example[决策边界示例][
  线性决策边界：
  $ theta_0 + theta_1 x_1 + theta_2 x_2 = 0 $

  非线性决策边界（引入高阶项）：
  $ theta_0 + theta_1 x_1 + theta_2 x_2 + theta_3 x_1^2 + theta_4 x_2^2 = 0 $
  可实现圆形、椭圆形等非线性分界。
]

== 过拟合与正则化

#definition[过拟合问题][
  逻辑回归也存在过拟合风险，特别是引入高阶项时：

  #align(center)[
    #table(
      columns: (auto, auto, auto),
      inset: 6pt, align: center,
      table.header([欠拟合], [合适拟合], [过拟合]),
      [模型过于简单], [泛化能力好], [模型过于复杂],
      [偏差大], [偏差方差平衡], [方差大],
    )
  ]

  *表现*：训练误差低、测试误差高 — 模型记住了训练数据的噪声。
  *主因*：过多特征 + 高度复杂的模型。
]

#property[解决方法][
  1. *减少特征数量*：人工选择或模型选择算法（交叉验证），但会丢失信息
  2. *正则化*：保留所有特征，减小参数值，在经验风险上添加结构风险（惩罚项）
]

#definition[经验风险与结构风险][
  *经验风险*：模型关于训练数据集的平均损失
  $ R_"emp"(f) = 1/m sum_(i=1)^m L(y_i, f(x_i)) $

  *结构风险*：经验风险 + 正则化项（惩罚模型复杂度）
  $ R_"sr"(f) = R_"emp"(f) + lambda J(f) $
]

#definition[正则化][
  在代价函数中添加惩罚项防止过拟合：

  *L2正则化（Ridge，岭回归）*：
  $ J(theta) = J_0(theta) + lambda/(2m) sum_(j=1)^n theta_j^2 $
  使权重趋向于小值（权重衰减）

  *L1正则化（Lasso）*：
  $ J(theta) = J_0(theta) + lambda/m sum_(j=1)^n |theta_j| $
  产生稀疏解，可用于特征选择
]

#note[
  *$lambda$ 的作用*：
  - $lambda$ 很大：对模型复杂度惩罚大，可能欠拟合
  - $lambda$ 很小：注重拟合训练数据，可能过拟合
  - 需通过交叉验证选择最优 $lambda$
]

== Softmax回归（多分类逻辑回归）

#definition[Softmax回归][
  当分类数 $K > 2$ 时，逻辑回归扩展到 Softmax 回归。输入 $x$ 属于第 $k$ 类的概率：

  $ P(y=k | x; theta) = e^(theta_k^T x) / (sum_(j=1)^K e^(theta_j^T x)) $

  分母是对所有类别概率的归一化，使得 $sum_(k=1)^K P(y=k|x) = 1$。
]

#property[Softmax的神经网络表示][
  Softmax回归可看作一个单层神经网络：
  - 输入层：特征 $x$
  - 输出层：$K$ 个神经元，分别对应 $K$ 个类别的权重 $theta_k$
  - 激活函数：Softmax（将线性输出归一化为概率）
  - 损失函数：交叉熵 $H = - sum_k y_k log p_k$
]

#theorem[Softmax回归的代价函数][
  基于极大似然估计的交叉熵损失：

  $ J(theta) = - 1/m sum_(i=1)^m sum_(k=1)^K I{y_i = k} log (e^(theta_k^T x_i) / (sum_(j=1)^K e^(theta_j^T x_i))) $

  其中 $I$ 是指示函数（当条件为真时取1，否则取0）。

  对于第 $i$ 个样本的交叉熵损失（假设该样本属于第 $y^((i))$ 类）：
  $ L_i = - log P(y^((i)) | x^((i)); theta) $
]

#definition[Softmax的梯度下降更新][
  对第 $l$ 类权重 $theta_l$ 求偏导：

  $ frac(partial J, partial theta_l) = - 1/m sum_(i=1)^m (I{y_i = l} - P(y=l|x_i; theta)) x_i $

  *更新规则*：
  $ theta_l := theta_l + eta/m sum_(i=1)^m (I{y_i = l} - P(y=l|x_i; theta)) x_i $

  形式上与二分类逻辑回归一致：真实标签指示函数与预测概率之差。
]

== 应考要点

#property[回归分析考点][
  1. *线性回归模型*：单变量、多变量的表达式、代价函数定义
  2. *代价函数计算*：会给数据算 $J$ 值
  3. *最小二乘法*：正规方程求解
  4. *梯度下降*：更新公式、学习率影响、凸函数性质
  5. *逻辑回归*：sigmoid函数、概率输出解释、与线性回归的关系
  6. *交叉熵损失*：从极大似然估计推导交叉熵损失
  7. *逻辑回归梯度*：会推导 $gradient = 1/m sum (h - y) x$
  8. *非线性扩展*：引入高阶项实现非线性分类
  9. *过拟合*：原因及解决方法，L1 vs L2正则化
  10. *Softmax回归*：多分类概率输出、代价函数、梯度
]

#problemset[

#example[作业 - 线性回归代价函数计算][
  给定数据集：$(1,1), (2,2), (3,3)$

  计算 $theta_0 = 0, theta_1 = 0.8$ 时的代价函数 $J(0, 0.8)$。
]

#solution[
  $h(x) = 0.8x$

  $ J(0, 0.8) = 1/(2 times 3) times [(0.8-1)^2 + (1.6-2)^2 + (2.4-3)^2] $

  $ = 1/6 times [0.04 + 0.16 + 0.36] = 1/6 times 0.56 approx 0.093 $
]

#example[作业 - 推导逻辑回归交叉熵梯度][
  推导逻辑回归交叉熵代价函数关于权重的梯度公式。
]

#solution[
  设 $h_theta(x) = sigma(theta^T x) = 1/(1 + e^(-theta^T x))$，交叉熵代价函数：
  $ J(theta) = - 1/m sum_(i=1)^m [y_i log(h_theta(x_i)) + (1 - y_i) log(1 - h_theta(x_i))] $

  记 $a_i = h(x_i)$，利用 $sigma'(z) = sigma(z)(1-sigma(z))$：

  $ frac(partial J, partial theta_j) = - 1/m sum_(i=1)^m [y_i/a_i frac(partial a_i, partial theta_j) + (1-y_i)/(1-a_i)(-frac(partial a_i, partial theta_j))] $

  其中 $frac(partial a_i, partial theta_j) = a_i(1-a_i) x_(i j)$

  $ = - 1/m sum_(i=1)^m [y_i/a_i - (1-y_i)/(1-a_i)] dot a_i(1-a_i) x_(i j) $

  $ = - 1/m sum_(i=1)^m frac(y_i - a_i, a_i(1-a_i)) dot a_i(1-a_i) x_(i j) = 1/m sum_(i=1)^m (a_i - y_i) x_(i j) $

  即：$ gradient J = 1/m sum_(i=1)^m (h_theta(x_i) - y_i) x_i $
]

#example[作业 - 推导 Softmax 回归梯度][
  推导 Softmax 回归代价函数关于第 $l$ 类权重向量的梯度公式。
]

#solution[
  $K$ 类，第 $k$ 类预测概率：$P(y=k | x) = e^(theta_k^T x) / (sum_(j=1)^K e^(theta_j^T x))$

  代价函数：$J(theta) = - 1/m sum_(i=1)^m sum_(k=1)^K I{y_i = k} log P(y=k|x_i)$

  记 $o_k = theta_k^T x_i$，$p_k = e^(o_k) / sum_(j=1)^K e^(o_j)$

  对第 $l$ 类权重求梯度：

  $ frac(partial J, partial theta_l) = - 1/m sum_(i=1)^m sum_(k=1)^K I{y_i = k} dot 1/p_k dot frac(partial p_k, partial theta_l) $

  $ frac(partial p_k, partial theta_l) = cases(
    p_k(1-p_l) x_i "if" k = l,
    -p_k p_l x_i "if" k != l
  ) $

  代入后化简：
  $ gradient_(theta_l) J = 1/m sum_(i=1)^m (P(y=l|x_i) - I{y_i = l}) x_i $

  形式与二分类逻辑回归一致：预测概率减指示函数，乘输入。
]

#example[习题 - 梯度下降更新计算][
  假设线性回归模型 $h(x) = theta_0 + theta_1 x$，学习率 $eta = 0.1$，单个样本 $(x=2, y=5)$，当前参数 $theta_0 = 0, theta_1 = 1$，计算一次梯度更新后的参数值。
]

#solution[
  $h(x) = 0 + 1 times 2 = 2$

  梯度的各个分量：
  $ frac(partial J, partial theta_0) = (2 - 5) = -3 $
  $ frac(partial J, partial theta_1) = (2 - 5) times 2 = -6 $

  更新参数：
  $ theta_0 := 0 - 0.1 times (-3) = 0.3 $
  $ theta_1 := 1 - 0.1 times (-6) = 1.6 $

  更新后：$h(x) = 0.3 + 1.6 times 2 = 3.5$（更接近目标值5）。
]

#example[2024期末考题 - 线性回归梯度下降推导][
  线性回归使用误差平方和作为损失函数，目标值 $y$，输入向量 $x$。请：
  
  (1) 写出误差平方和的表达式
  
  (2) 推导梯度计算和参数更新公式（使用梯度下降法优化）
  
  （其他参数符号自行定义，如学习率、权重、偏置等）
]

#solution[
  *(1) 误差平方和（SSE）表达式*
  
  对于 $m$ 个训练样本，线性回归模型为：$h_theta(x) = theta^T x = w_0 + w_1 x_1 + ... + w_n x_n$
  
  误差平方和：$J(theta) = sum_(i=1)^m (h_theta(x^((i))) - y^((i)))^2$
  
  或带系数形式：$J(theta) = 1/(2m) sum_(i=1)^m (h_theta(x^((i))) - y^((i)))^2$
  
  *(2) 梯度计算与参数更新推导*
  
  对于单个样本，误差：$E = 1/2 (h_theta(x) - y)^2$
  
  对参数 $theta_j$ 求偏导：
  
  $ frac(partial E, partial theta_j) = (h_theta(x) - y) dot frac(partial, partial theta_j)(h_theta(x) - y) $
  
  由于 $h_theta(x) = theta_0 + theta_1 x_1 + ... + theta_j x_j + ...$
  
  所以 $frac(partial h_theta(x), partial theta_j) = x_j$
  
  因此：$ frac(partial E, partial theta_j) = (h_theta(x) - y) x_j $
  
  *批量梯度下降更新规则*：
  
  $ theta_j := theta_j - eta frac(partial J, partial theta_j) = theta_j - eta/m sum_(i=1)^m (h_theta(x^((i))) - y^((i))) x_j^((i)) $
  
  其中 $eta$ 为学习率。
]

#example[2024期末考题 - 多项式回归与MSE计算][
  多项式回归使用适当阶数的多项式拟合数据。已知最终得到的多项式为 $y = 0.8x^2$，求下表测试集样本的均方误差（MSE）。
  
  #align(center)[
    #table(
      columns: (auto, auto, auto, auto),
      inset: 5pt, align: center,
      table.header([类型], [样本序号], [$x$], [$y$]),
      [训练集], [...], [...], [...],
      [测试集], [6], [4.0], [14.8],
      [], [7], [5.0], [22.0],
    )
  ]
]

#solution[
  *多项式回归基本原理*：
  
  多项式回归是线性回归的扩展，将原始特征 $x$ 映射为高阶多项式特征：
  
  $h(x) = theta_0 + theta_1 x + theta_2 x^2 + ... + theta_n x^n$
  
  通过引入高阶项，可以拟合非线性关系，但本质上仍可用线性回归方法求解。
  
  *MSE计算*：
  
  均方误差公式：$"MSE" = 1/n sum_(i=1)^n (y_i - hat(y)_i)^2$
  
  对于样本6：$hat(y)_6 = 0.8 times (4.0)^2 = 0.8 times 16 = 12.8$
  
  对于样本7：$hat(y)_7 = 0.8 times (5.0)^2 = 0.8 times 25 = 20.0$
  
  $"MSE" = 1/2 [(14.8 - 12.8)^2 + (22.0 - 20.0)^2]$
  
  $= 1/2 [(2.0)^2 + (2.0)^2] = 1/2 [4 + 4] = 4.0$
]

#example[2024期末考题 - 逻辑回归与Sigmoid函数][
  逻辑回归使用Sigmoid函数将线性回归的结果映射到0-1之间，概率表征样本属于正类的可能性。请：
  
  (1) 写出Sigmoid函数表达式
  
  (2) 逻辑回归与线性回归有什么区别？
]

#solution[
  *(1) Sigmoid函数表达式*
  
  $ sigma(z) = 1 / (1 + e^(-z)) $
  
  其中 $z = theta^T x = w_0 + w_1 x_1 + ... + w_n x_n$ 是线性组合。
  
  Sigmoid函数性质：
  - 输出范围 $(0, 1)$，可解释为概率
  - $sigma(0) = 0.5$（决策边界）
  - 当 $z -> +infinity$ 时，$sigma(z) -> 1$
  - 当 $z -> -infinity$ 时，$sigma(z) -> 0$
  - 导数：$sigma'(z) = sigma(z)(1 - sigma(z))$
  
  *(2) 逻辑回归与线性回归的区别*
  
  #align(center)[
    #table(
      columns: (auto, auto, auto),
      inset: 6pt, align: left,
      table.header([区别维度], [线性回归], [逻辑回归]),
      [问题类型], [回归问题（连续值预测）], [分类问题（离散类别预测）],
      [输出范围], [$y in (-infinity, +infinity)$], [$y in (0, 1)$（概率）],
      [输出解释], [目标值的预测], [属于正类的概率 $P(y=1|x)$],
      [损失函数], [均方误差（MSE）], [交叉熵损失（Cross-Entropy）],
      [激活函数], [无（直接输出）], [Sigmoid函数],
      [应用场景], [房价预测、股票预测等], [二分类问题（垃圾邮件、肿瘤诊断等）],
    )
  ]
]
]


#pagebreak()
 = 线性分类器

#introduction[线性判别函数][最小距离准则][感知器准则][MSE准则][多类决策]

== 引言：为什么需要线性判别函数

#definition[贝叶斯分类器的局限][
  基于样本的贝叶斯分类器需要估计类条件概率密度函数，但面临两个问题：
  1. 样本空间的类条件概率密度很难确定
  2. 非参数估计需要大量样本，且随特征维数增加所需样本急剧增加
  
  *解决办法*：利用样本集直接设计分类器，给定某个判别函数类，用样本集确定未知参数。
]

#property[线性判别函数的特点][
  - *优点*：形式简单、计算量小、容易实现
  - *缺点*：相对于贝叶斯分类器，错误率或风险可能更大（"次优"）
  - *地位*：对准则函数而言，线性判别函数是最好的；对错误率而言，它只是"次优"
]

#definition[线性分类器设计三要素][
  1. *确定分类器类型*：选择判别函数的形式（线性）
  2. *确定准则函数*：定义什么是最优分类器（如最小化错分数）
  3. *设计优化算法*：利用训练数据搜索准则函数的最优参数
]

== 线性判别函数

#definition[线性判别函数与决策规则][
  设模式 $bold(x) = (x_1, x_2, ..., x_d)^T$ 是 $d$ 维的，线性判别函数的一般形式为：
  $ g(bold(x)) = bold(w)^T bold(x) + w_0 = sum_(i=1)^d w_i x_i + w_0 $

  二类决策规则：
  $ cases(
    g(bold(x)) > 0 => "类别" C_1,
    g(bold(x)) < 0 => "类别" C_2,
    g(bold(x)) = 0 => "拒绝或任意"
  ) $
]

#definition[增广形式][
  将偏置纳入向量，得到齐次形式：
  $ bold(y) = (1, x_1, x_2, ..., x_d)^T $，$ bold(a) = (w_0, w_1, w_2, ..., w_d)^T $
  
  则：$ g(bold(x)) = bold(a)^T bold(y) $
]

#property[决策面的几何意义][
  - *决策面方程*：$g(bold(x)) = 0$ 是一个超平面 $H$
  - *法向量*：$bold(w)$ 是决策面 $H$ 的法向量，方向指向 $C_1$ 类（正侧）
  - *$g(x)$的代数意义*：正比于点 $x$ 到决策面的有向距离
  - *有向距离公式*：$ g(bold(x)) = r ||bold(w)|| $，其中 $r$ 是有向距离
  - *原点到决策面距离*：$ r_0 = w_0 / ||bold(w)|| $（$w_0 = 0$ 时决策面过原点）

  #align(center)[
    线性分类界面是 $d$ 维空间中的一个超平面。判别函数的权向量 $bold(w)$ 垂直于分类界面，方向指向 $C_1$ 区域。偏置 $w_0$ 与原点到分类界面的距离有关。
  ]
]

== 最小距离准则

#definition[最小距离分类器][
  同类模式在模式空间中应相互靠近。设有 $m$ 类样本集，计算 $omega_i$ 类中所有样本的均值 $bold(mu)_i$，样本 $bold(x)$ 到 $omega_i$ 类的欧氏距离为：
  $ D_i(bold(x)) = (bold(x) - bold(mu)_i)^T (bold(x) - bold(mu)_i) $

  *决策规则*：若 $D_i(x) < D_j(x)$ 对所有 $j != i$ 成立，则判 $x$ 属于 $omega_i$ 类。
]

#theorem[最小距离分类器是线性分类器][
  展开距离公式：
  $ D_i(x) = x^T x - 2 bold(mu)_i^T x + bold(mu)_i^T bold(mu)_i $

  由于 $x^T x$ 与类别无关，可定义线性判别函数：
  $ g_i(x) = 2 bold(mu)_i^T x - bold(mu)_i^T bold(mu)_i = bold(w)^T x + w_0 $

  其中 $bold(w) = 2 bold(mu)_i$，$w_0 = - bold(mu)_i^T bold(mu)_i$
]

#note[
  *最小距离分类器的局限*：分类效果常常不理想，因为判别函数的权向量及阈值仅利用了各类样本的均值信息，没有充分利用样本的其他分布信息（如方差、协方差）。
]

== 感知器准则函数

#definition[线性可分性][
  假设已知一组容量为 $n$ 的样本集 $bold(y)_1, ..., bold(y)_n$（$d'$ 维增广样本向量），来自由 $omega_1$ 和 $omega_2$。如果存在权向量 $bold(w)$ 使得：
  - 对任意 $bold(y) in omega_1$，有 $bold(w)^T bold(y) > 0$
  - 对任意 $bold(y) in omega_2$，有 $bold(w)^T bold(y) < 0$
  
  则称样本集为*线性可分*的，否则为*线性不可分*。
]

#definition[样本规范化][
  对来自 $omega_2$ 类的样本 $bold(y)_j$ 前面加上负号：
  $ bold(y)'_j = - bold(y)_j $，其中 $bold(y)_j in omega_2 $

  则问题转化为：寻找 $bold(w)$ 使得 $bold(w)^T bold(y)'_i > 0$ 对所有 $i = 1,...,n$ 成立。
]

#property[解向量与解区][
  - 方程 $bold(w)^T bold(y)_i = 0$ 确定了一个以 $bold(y)_i$ 为法向量的超平面
  - $n$ 个样本产生 $n$ 个超平面，每个把权空间分为两个半空间
  - 解向量 $bold(w)$ 必在 $n$ 个正半空间的交迭区，称为*解区*
  - 解区中任意向量都是解向量（通常有无穷多解）

  *引入余量*：为了使解向量更可靠（不在解区边界上），引入 $b > 0$：
  $ bold(w)^T bold(y)_i >= b > 0 $
]

#definition[感知器准则函数][
  对于规范化后的样本 $bold(y)_1, ..., bold(y)_n$，构造准则函数：
  $ J_p(bold(w)) = sum_(bold(y) in Y) (-bold(w)^T bold(y)) $

  其中 $Y$ 是被 $bold(w)$ 错分类的样本集合。当 $bold(w)$ 错分 $bold(y)$ 时，$bold(w)^T bold(y) <= 0$，所以 $-bold(w)^T bold(y) >= 0$。

  *性质*：$J_p >= 0$，仅当 $bold(w)$ 正确分类所有样本时 $J_p = 0$。
]

== 感知器的梯度下降求解

#definition[梯度下降迭代公式][
  对 $J_p(bold(w))$ 求梯度：
  $ nabla J_p(bold(w)) = sum_(bold(y) in Y) (-bold(y)) $

  *批处理梯度下降更新*：
  $ bold(w)_(k+1) = bold(w)_k + rho_k sum_(bold(y) in Y_e) bold(y) $

  其中 $rho_k$ 是学习率（步长），$Y_e$ 是被 $bold(w)_k$ 错分的样本集合。
]

#property[三种变体][
  1. *批修正法*：每次迭代用所有错分样本
  2. *单样本修正法*：将样本集看作不断重复的序列逐个考虑，对错分的当前样本进行修正
  3. *固定增量法*：令 $rho_k = 1$（常数），每次对错分样本修正固定步长
]

#note[
  *感知器收敛定理*：若训练样本线性可分，感知器算法在有限步内收敛到解向量。若线性不可分，算法不收敛（永不停机）。
]

== 最小平方误差（MSE）准则

#definition[MSE准则的动机][
  感知器准则只适用于线性可分情况，不可分时迭代永不终止。
  
  *MSE准则的目标*：
  - 线性可分时：得到类似感知器的解向量
  - 线性不可分时：得到使某种误差度量最小的解向量
]

#definition[MSE准则函数][
  设 $bold(y)_i$ 为规范化增广样本，$bold(w)$ 为增广权向量。对于两类线性可分问题，存在 $bold(w)$ 和 $b_i > 0$ 使得：
  $ bold(w)^T bold(y)_i = b_i > 0 $，$i = 1, 2, ..., n $

  写成矩阵形式：$ Y bold(w) = bold(b) $

  定义误差向量 $bold(e) = Y bold(w) - bold(b)$，MSE准则函数为：
  $ J(bold(w)) = ||bold(e)||^2 = ||Y bold(w) - bold(b)||^2 = sum_(k=1)^n (bold(w)^T bold(y)_k - b_k)^2 $
]

#theorem[MSE解（伪逆解）][
  令梯度为0：
  $ nabla J(bold(w)) = 2 Y^T(Y bold(w) - bold(b)) = 0 $

  得正规方程：$ Y^T Y bold(w) = Y^T bold(b) $

  *MSE解*：$ bold(w) = (Y^T Y)^(-1) Y^T bold(b) = Y^(dagger) bold(b) $
  
  其中 $Y^(dagger)$ 称为 $Y$ 的*伪逆*（左逆矩阵）。
]

#note[
  *MSE解的注意事项*：
  - 要求 $Y^T Y$ 可逆，若不可逆则得不到解
  - 直接求伪逆计算量大，实际中常用梯度下降迭代求解
  - MSE解的超平面本质是最小化样本到超平面距离的平方和，不一定是分类面
]

#definition[Widrow-Hoff算法（迭代MSE）][
  MSE准则函数的梯度：$ nabla J(bold(w)) = 2 Y^T(Y bold(w) - bold(b)) $

  梯度下降迭代：
  $ bold(w)_1 = "任意值" $
  $ bold(w)_(k+1) = bold(w)_k - rho_k Y^T(Y bold(w)_k - bold(b)) $

  其中 $rho_k = rho_1/k$（随迭代递减），$rho_1$ 取任意值。

  *优点*：无论矩阵是否可逆，总能产生有用的权向量，且计算量小得多。
]

== 多类分类策略

#definition[一对余 (One-vs-Rest, OvR)][
  训练 $K$ 个二分类器，第 $i$ 个分类器区分类别 $omega_i$ 与其他所有类别。
  
  *判别规则*：若 $d_i(x) > 0$ 且对所有 $j != i$ 有 $d_j(x) <= 0$，则判为 $omega_i$ 类。
  
  *缺点*：存在不确定区域（如多个 $d_i > 0$ 或全部 $d_i < 0$）。
]

#definition[一对一 (One-vs-One, OvO)][
  对每两类 $(omega_i, omega_j)$ 建立一个判别函数 $d_(i j)$，共 $m(m-1)/2$ 个。
  
  *判别规则*：若对所有 $j != i$ 有 $d_(i j)(x) > 0$，则判为 $omega_i$ 类。
  
  *缺点*：同样存在不确定区域。$m$ 较大时判别函数数量多。
]

#definition[多对多 / 最大值判别 (arg max)][
  定义 $m$ 个判别函数 $d_i(x)$（$i = 1, ..., m$），决策面为 $d_i(x) = d_j(x)$。
  
  *判别规则*：若 $d_i(x) > d_j(x)$ 对所有 $j != i$ 成立，则判为 $omega_i$ 类，即：
  $ "class" = arg max_i d_i(x) $
  
  *优点*：不存在不确定区域，是最常用的多类分类方案。
]

== 应考要点

#property[线性分类器考点][
  1. *线性判别函数*：$g(x) = w^T x + w_0$，增广形式 $g(x) = a^T y$
  2. *几何意义*：$w$ 是决策面法向量，$g(x)$ 正比于有向距离
  3. *设计三要素*：分类器类型 + 准则函数 + 优化算法
  4. *最小距离分类器*：等价于线性分类器，$g_i(x)=2mu_i^T x - mu_i^T mu_i$
  5. *线性可分性*：定义、样本规范化
  6. *感知器准则*：$J_p(w) = sum_(Y) (-w^T y)$，梯度下降求解
  7. *感知器收敛定理*：线性可分时有限步收敛，不可分时不收敛
  8. *MSE准则*：$J(w) = ||Y w - b||^2$，伪逆解 $w = Y^(dagger) b$
  9. *Widrow-Hoff算法*：迭代MSE，不要求矩阵可逆
  10. *多类策略*：OvR（有不确定区）、OvO（有不确定区）、arg max（无不确定区）
]

#problemset[

#example[作业 - 线性判别函数基本形式][
  对二维线性判别函数 $g(x) = x_1 + 2x_2 - 2$：(1) 写成 $g(x) = bold(w)^T bold(x) + w_0$ 形式；(2) 写成 $g(x) = bold(a)^T bold(y)$ 增广形式并画图。
]

#solution[
  *(1)* 取 $bold(w) = (1, 2)^T$，$w_0 = -2$，则 $g(x) = mat(1, 2) mat(x_1; x_2) - 2$

  决策边界 $g(x) = 0$：$x_2 = -1/2 x_1 + 1$，过点 $(0, 1)$ 和 $(2, 0)$ 的直线。

  *(2)* 增广特征 $bold(y) = (x_1, x_2, 1)^T$，增广权向量 $bold(a) = (1, 2, -2)^T$：
  $g(x) = mat(1, 2, -2) mat(x_1; x_2; 1) = bold(a)^T bold(y)$
]

#example[作业 - 多类判别函数计算][
  三类问题 $omega_1, omega_2, omega_3$，判别函数分别为：
  $d_1(x) = -x_1$，$d_2(x) = x_1 + x_2 - 1$，$d_3(x) = x_1 - x_2 - 1$
  
  求当 $x = (0, 0)^T$ 时属于哪一类？
]

#solution[
  $d_1(0,0) = 0$，$d_2(0,0) = -1$，$d_3(0,0) = -1$
  
  $d_1 > d_2$ 且 $d_1 > d_3$，按最大值判别法，$x$ 属于 $omega_1$ 类。
]

#example[习题 - 最小距离分类器][
  已知三类样本均值：$mu_1 = (0,0)^T$，$mu_2 = (1,0)^T$，$mu_3 = (0,1)^T$。用最小距离分类器判断 $x = (0.3, 0.4)^T$ 的类别，并写出线性判别函数。
]

#solution[
  计算到各类的欧氏距离：
  $ D_1(x) = (0.3-0)^2 + (0.4-0)^2 = 0.25 $
  $ D_2(x) = (0.3-1)^2 + (0.4-0)^2 = 0.49 + 0.16 = 0.65 $
  $ D_3(x) = (0.3-0)^2 + (0.4-1)^2 = 0.09 + 0.36 = 0.45 $
  
  最小距离为 $D_1 = 0.25$，所以 $x$ 属于 $omega_1$ 类。

  对应的线性判别函数：
  $ g_1(x) = 2 mu_1^T x - mu_1^T mu_1 = 0 $
  $ g_2(x) = 2 x_1 - 1 $
  $ g_3(x) = 2 x_2 - 1 $
]

#example[习题 - 感知器梯度下降计算][
  给定两个规范化样本 $bold(y)_1 = (1, 2)^T$（类1）和 $bold(y)_2 = (-2, -1)^T$（类2，已规范化），初始权向量 $bold(w)_1 = (0, 0)^T$，学习率 $rho = 1$。用单样本固定增量法更新权向量，直到正确分类所有样本。
]

#solution[
  *第1次迭代*：对 $bold(y)_1 = (1,2)^T$：
  $bold(w)_1^T bold(y)_1 = 0 times 1 + 0 times 2 = 0$（等于0，错分）
  更新：$bold(w)_2 = bold(w)_1 + 1 dot (1,2)^T = (1,2)^T$

  *第2次迭代*：对 $bold(y)_2 = (-2,-1)^T$：
  $bold(w)_2^T bold(y)_2 = 1 dot (-2) + 2 dot (-1) = -4 < 0$（错分）
  更新：$bold(w)_3 = (1,2)^T + 1 dot (-2,-1)^T = (-1,1)^T$

  *第3次迭代*：对 $bold(y)_1 = (1,2)^T$：
  $bold(w)_3^T bold(y)_1 = (-1) dot 1 + 1 dot 2 = 1 > 0$（正确分类）

  *第4次迭代*：对 $bold(y)_2 = (-2,-1)^T$：
  $bold(w)_3^T bold(y)_2 = (-1)(-2) + 1(-1) = 1 > 0$（正确分类）
  
  所有样本正确分类，收敛。解向量 $bold(w)^* = (-1, 1)^T$。
]

#example[习题 - MSE伪逆解][
  给定三个规范化样本：$bold(y)_1 = (1,1)^T$，$bold(y)_2 = (1,0)^T$，$bold(y)_3 = (-1,-1)^T$，取 $bold(b) = (1,1,1)^T$。求MSE解。
]

#solution[
  构造矩阵：
  $ Y = mat(1, 1; 1, 0; -1, -1) $，$ bold(b) = mat(1; 1; 1) $

  计算：
  $ Y^T Y = mat(1, 1, -1; 1, 0, -1) mat(1, 1; 1, 0; -1, -1) = mat(3, 2; 2, 2) $
  
  $ (Y^T Y)^(-1) = 1/(3 dot 2 - 2 dot 2) mat(2, -2; -2, 3) = 1/2 mat(2, -2; -2, 3) = mat(1, -1; -1, 1.5) $

  $ Y^T bold(b) = mat(1, 1, -1; 1, 0, -1) mat(1; 1; 1) = mat(1+1-1; 1+0-1) = mat(1; 0) $

  $ bold(w) = (Y^T Y)^(-1) Y^T bold(b) = mat(1, -1; -1, 1.5) mat(1; 0) = mat(1; -1) $

  所以MSE解为 $bold(w) = (1, -1)^T$。
]

#example[2024期末考题 - SVM超平面与支持向量][
  下图为二维特征空间的二分类数据点分布图，使用完全线性可分情况下的SVM，结合图中信息，分别解释：
  
  (1) 超平面（分离超平面）
  
  (2) 支持向量
  
  (3) 样本点与分离超平面的几何间隔
  
  #figure(
    caption: [SVM线性可分情况示意图],
    image("../assets/machinelearning/exam_svm_linear.png", width: 50%)
  )
]

#solution[
  *(1) 超平面（分离超平面）*
  
  在二维特征空间中，分离超平面是一条直线（在高维空间中是超平面），其方程为：
  
  $ bold(w)^T bold(x) + b = 0 $
  
  超平面将样本空间划分为两部分：
  - 正类区域：$bold(w)^T bold(x) + b > 0$
  - 负类区域：$bold(w)^T bold(x) + b < 0$
  
  SVM的目标是找到*最优分离超平面*，使得两类样本之间的间隔最大。
  
  *(2) 支持向量*
  
  支持向量是距离分离超平面最近的样本点，即位于间隔边界上的样本点，满足 $bold(w)^T bold(x) + b = plus.minus 1$。
  
  支持向量的特点：
  - 决定了分离超平面的位置和方向
  - 只有支持向量影响模型，其他样本不影响（稀疏性）
  
  *(3) 几何间隔*
  
  几何间隔是指样本点到分离超平面的实际距离：
  
  $ gamma = (bold(w)^T bold(x) + b) / ||bold(w)|| $
  
  SVM的目标是最大化最小几何间隔。
]

#example[2024期末考题 - SVM软间隔与核技巧][
  (1) 不完全线性可分情况下的SVM，说明软间隔最大化分类的约束条件和基本原理。
  
  (2) 非线性可分情况下的SVM，说明核技巧的基本原理。
  
  #figure(
    caption: [SVM核技巧示意图],
    image("../assets/machinelearning/exam_svm_kernel.png", width: 50%)
  )
]

#solution[
  *(1) 软间隔最大化*
  
  引入松弛变量 $xi_i >= 0$，允许部分样本违反约束。
  
  *约束条件*：$y_i(bold(w)^T bold(x)_i + b) >= 1 - xi_i$
  
  *优化目标*：$min 1/2 ||bold(w)||^2 + C sum xi_i$
  
  其中 $C$ 是惩罚参数，控制对误分的容忍度。
  
  *(2) 核技巧*
  
  通过映射函数 $phi$ 将数据映射到高维特征空间，使其线性可分。
  
  核函数：$K(bold(x)_i, bold(x)_j) = phi(bold(x)_i)^T phi(bold(x)_j)$
  
  常用核函数：多项式核、高斯核（RBF）、Sigmoid核等。
  
  优点：避免显式计算高维映射，将非线性问题转化为线性问题求解。
]

#example[课堂回顾习题][
  设有两类样本：
  - *第一类 ($omega_1$)*：$x_1 = [1, 1]^T, x_2 = [2, 1]^T$
  - *第二类 ($omega_2$)*：$x_3 = [3, 3]^T, x_4 = [4, 2]^T$

  要求：
  1. 写出增广样本向量及归一化后的训练样本集。
  2. 设置初始增广权向量 $a(1) = [0, 0, 0]^T$。
  3. 使用学习率 $rho = 1$ 的固定增量感知器算法，进行单步迭代（即一个样本修正一次），写出前 3 次迭代的权向量更新过程。
]

#solution[
   1. 增广并归一化（规范化）训练样本集

  *步骤 1：写出增广样本向量*  
  对每个二维样本向量末尾添加偏置项 $1$，得到三维增广样本向量 $y_i = [x_i^T, 1]^T$：
  - 对于 $omega_1$：  
    $y_1 = [1, 1, 1]^T, quad y_2 = [2, 1, 1]^T$
  - 对于 $omega_2$：  
    $y_3 = [3, 3, 1]^T, quad y_4 = [4, 2, 1]^T$

  *步骤 2：对第二类样本进行归一化（规范化）*  
  为了统一判别公式，将第二类样本 $omega_2$ 乘以 $-1$，使得当分类正确时，对所有样本均有 $a^T y > 0$。  
  归一化后的训练样本集为：
  - $y_1 = [1, 1, 1]^T$
  - $y_2 = [2, 1, 1]^T$
  - $y_3 = [-3, -3, -1]^T$
  - $y_4 = [-4, -2, -1]^T$

   2. 初始状态与更新规则

  - 初始权向量：$a(1) = [0, 0, 0]^T$
  - 学习率：$rho = 1$
  - 迭代更新判别规则：
    对于输入的第 $k$ 个样本 $y_k$（循环输入）：
    - 若 $a^T (k) y_k <= 0$，说明分类错误，需要修正：$a(k+1) = a(k) + rho y_k$
    - 若 $a^T (k) y_k > 0$，说明分类正确，无需修正：$a(k+1) = a(k)$

   3. 前 3 次迭代的权向量更新过程

  *第 1 次迭代*：输入样本 $y_1 = [1, 1, 1]^T$
  - 计算判别值：
    $ a^T (1) y_1 = [0, 0, 0] vec(1, 1, 1) = 0 <= 0 $
  - 分类错误，更新权向量：
    $ a(2) = a(1) + 1 dot y_1 = vec(0, 0, 0) + vec(1, 1, 1) = vec(1, 1, 1) $

  *第 2 次迭代*：输入样本 $y_2 = [2, 1, 1]^T$
  - 计算判别值：
    $ a^T (2) y_2 = [1, 1, 1] vec(2, 1, 1) = 2 + 1 + 1 = 4 > 0 $
  - 分类正确，权向量保持不变：
    $ a(3) = a(2) = vec(1, 1, 1) $

  *第 3 次迭代*：输入样本 $y_3 = [-3, -3, -1]^T$
  - 计算判别值：
    $ a^T (3) y_3 = [1, 1, 1] vec(-3, -3, -1) = -3 - 3 - 1 = -7 <= 0 $
  - 分类错误，更新权向量：
    $ a(4) = a(3) + 1 dot y_3 = vec(1, 1, 1) + vec(-3, -3, -1) = vec(-2, -2, 0) $


  经过前 3 次单步迭代，权向量的变化历程如下：
  - 初始状态：$a(1) = [0, 0, 0]^T$
  - 第 1 步后：$a(2) = [1, 1, 1]^T$
  - 第 2 步后：$a(3) = [1, 1, 1]^T$
  - 第 3 步后：$a(4) = [-2, -2, 0]^T$
]

]


#pagebreak()
 = 特征选择与稀疏学习

#introduction[子集搜索与评价][过滤式Relief][包裹式LVW][嵌入式L1/LASSO][稀疏表示]

== 为什么需要特征选择

#definition[特征选择][
  从给定的特征集合中选出与当前学习任务相关的特征子集。

  *目标*：
  - 减轻维度灾难：在少量属性上构建模型
  - 降低学习难度：去除无关和冗余特征
  - 提高模型可解释性
]

#property[特征分类][
  - *相关特征*：对当前学习任务有用的属性
  - *无关特征*：与当前学习任务无关的属性
  - 特征选择必须确保不丢失重要特征
]

== 子集搜索与评价

#definition[子集搜索 (Subset Search)][
  如何根据评价结果生成下一个候选特征子集，避免组合爆炸。

  *三种搜索策略*：
  - *前向搜索 (Forward)*：从空集开始，逐渐增加相关特征。每轮选中使评价最优的单个特征加入，直到评价不再提升
  - *后向搜索 (Backward)*：从全集开始，逐渐删除无关特征。每轮删除使评价下降最少（或提升最多）的特征
  - *双向搜索 (Bidirectional)*：每轮同时增相关特征和删无关特征
]

#note[
  *贪心策略的局限*：前向/后向搜索使用贪心策略，只能得到局部最优解，不一定达到全局最优。
]

#definition[子集评价 (Subset Evaluation)][
  特征子集$A$确定了对数据集$D$的一个划分，样本标记$Y$对应真实划分。两个划分的差异越小，特征子集越好。

  *常用评价准则*：信息增益
  $ "Gain"(A) = "Entropy"(D) - sum_(v in "Values"(A)) |D_v|/|D| "Entropy"(D_v) $

  与决策树中信息增益的差异：这里$A$是属性集合，决策树中是单个属性。
]

== 过滤式选择：Relief算法

#definition[Relief算法][
  一种著名的过滤式特征选择方法，根据特征对近距离样本的区分能力赋予权重。

  *核心思想*：
  1. 从训练集随机选一个样本$x_i$
  2. 找同类最近邻（猜中近邻 near-hit）和异类最近邻（猜错近邻 near-miss）
  3. 若特征$j$在$x_i$与near-hit上的距离小于与near-miss的距离，则增加$j$的权重；反之降低权重
  4. 重复$m$次，取平均权重

  *权重更新公式*：
  $ w_j := w_j - "diff"(j, x_i, "near-hit")^2 / m + "diff"(j, x_i, "near-miss")^2 / m $

  其中$"diff"(j, x, y)$为样本$x$与$y$在特征$j$上的差异值。
]

#property[Relief算法特点][
  - *优点*：运行效率高，时间开销随采样次数和特征数线性增长
  - *局限*：原始Relief仅适用于二分类。扩展版ReliefF支持多分类和回归
  - *ReliefF改进*：对每个异类均找$k$个猜错近邻，加权更新
]

== 包裹式选择：LVW

#definition[LVW (Las Vegas Wrapper)][
  直接把最终学习器的性能作为特征子集的评价准则，为给定学习器"量身定做"特征子集。

  *算法流程*：
  1. 随机产生一个特征子集
  2. 在该子集上通过交叉验证估计学习器误差
  3. 重复多次，选择误差最小的特征子集

  *特点*：
  - 从最终学习器性能看，包裹式优于过滤式
  - 计算开销大：每轮都需要训练学习器
  - 若特征数多且$T$（停止条件参数）大，可能长时间不停止
]

== 嵌入式选择：L1正则化

#definition[嵌入式特征选择][
  将特征选择过程与学习器训练过程融为一体，在训练中自动进行特征选择。

  *LASSO (L1正则化)*：
  $ J(bold(w)) = sum_(i=1)^m (y_i - bold(w)^T bold(x)_i)^2 + lambda sum_(j=1)^n |w_j| $

  - L2正则化（岭回归）：使权重趋向小值，但不为零
  - *L1正则化（LASSO）*：易获得稀疏解，即$bold(w)$有更少的非零分量，天然实现特征选择
]

#figure(
  caption: [L1与L2正则化解的稀疏性差异],
  {
    set text(size: 8pt)
    fig_7()
  }
)

== 稀疏表示与字典学习

#definition[稀疏表示][
  将数据集视为矩阵，每行一个样本，每列一个特征。若矩阵中有很多零元素且非整行整列出现，则为稀疏表示。

  *优势*：
  - 稀疏表达使大部分问题变得线性可分（如文本数据）
  - 存储高效
  - 降低学习难度，提高可解释性
]

#definition[字典学习][
  为普通稠密表达的样本找到合适的字典，将样本转化为稀疏表示的过程。

  *基本思想*：将数据向量建模为基元素的稀疏线性组合。
  $ bold(x) approx bold(D) bold(alpha) $，其中$bold(D)$为字典，$bold(alpha)$为稀疏系数。
]

== 特征选择方法对比

#figure(
  caption: [三类特征选择方法对比],
  table(
    columns: (2.5cm, 3cm, 3cm, 3cm, 3cm),
    inset: 6pt,
    align: center,
    table.header([方法], [评价准则], [与学习器关系], [计算开销], [典型算法]),
    [过滤式], [统计度量], [独立于学习器], [低], [Relief],
    [包裹式], [学习器性能], [依赖学习器], [高], [LVW],
    [嵌入式], [损失+正则项], [融为一体], [中], [LASSO (L1)],
  )
)

#problemset[
#example[题目][
  简述前向搜索和后向搜索的区别，为什么它们都属于贪心策略？
]

#solution[
  *前向搜索*：从空集出发，每轮加入一个使评价最优的特征，直到评价不再提升。
  
  *后向搜索*：从全集出发，每轮删除一个使评价下降最少（或提升最多）的特征，直到评价开始下降。

  *贪心本质*：两者每轮只考虑当前最优的局部决策（加入/删除一个特征），不从全局考虑所有可能的特征组合，因此只能得到局部最优解。例如，前向搜索中先选入的特征可能阻碍后续更优组合的形成。
]

#example[题目][
  解释为什么L1正则化能产生稀疏解，而L2正则化不能。
]

#solution[
  *几何解释*：
  - L2正则化约束$sum w_j^2 <= C$在参数空间中是一个球体，最优解通常不在坐标轴上，因此$w_j ≠ 0$对所有$j$
  - L1正则化约束$sum |w_j| <= C$是一个菱形（$L_1$球），其"尖角"在坐标轴上，最优解更容易落在坐标轴上，使得部分$w_j = 0$

  *数学解释*：L1正则化的次梯度在$w_j = 0$处不光滑，使$w_j$有被"推"到零的趋势。LASSO的KKT条件使得很多系数恰好为零。
]
]

#pagebreak()
 = 无监督学习：聚类

#introduction[K-Means][层次聚类][距离度量][聚类评估]

== K-Means算法

#definition[K-Means][
  将$n$个样本划分为$k$个簇，使得簇内样本相似度高，簇间样本相似度低。
  
  目标函数：
  $ J = sum_(j=1)^k sum_(x in C_j) ||x - mu_j||^2 $
]

#figure(
  caption: [K-Means算法流程],
  {
    set text(size: 8pt)
    fig_8()
  }
)

#example[K-Means执行示例][
  假设有6个样本：$A(1,1), B(1,2), C(2,1), D(5,4), E(5,5), F(6,5)$，$k=2$
  
  *初始化*：随机选择$A(1,1)$和$D(5,4)$作为质心
  
  *第1轮*：
  - 簇1：$A, B, C$（距离质心1近）
  - 簇2：$D, E, F$（距离质心2近）
  - 新质心：$mu_1 = (1.33, 1.33), mu_2 = (5.33, 4.67)$
  
  *第2轮*：
  - 簇分配不变
  - 算法收敛
]

#note[
  *K-Means特点*：
  - *优点*：简单高效，时间复杂度$O(n k t)$
  - *缺点*：需要预先指定$k$；对初始质心敏感；对异常值敏感
  - *改进*：K-Means++（更好的初始化）
]

== 层次聚类

#definition[层次聚类][
  构建树状的聚类结构（树状图）。
  
  *凝聚式（自底向上）*：
  1. 每个样本作为一个簇
  2. 合并最相似的两个簇
  3. 重复直到所有样本在一个簇中
  
  *分裂式（自顶向下）*：
  1. 所有样本在一个簇中
  2. 递归地分裂簇
]

#figure(
  caption: [层次聚类树状图],
  cetz.canvas({
    import cetz.draw: *
    
    // 绘制树状图
    // 叶子节点
    for i in (0, 1, 2, 3, 4) {
      line((i, 0), (i, 0.5 + i * 0.1), stroke: 1pt)
    }
    
    // 合并层级
    line((0, 0.5), (0, 1), stroke: 1pt)
    line((1, 0.6), (1, 1.2), stroke: 1pt)
    line((0, 1), (0.5, 1), stroke: 1pt)
    line((0.5, 1), (0.5, 1.5), stroke: 1pt)
    line((1, 1.2), (0.5, 1.5), stroke: 1pt)
    
    line((2, 0.7), (2, 1.5), stroke: 1pt)
    line((0.5, 1.5), (1.25, 2), stroke: 1pt)
    line((2, 1.5), (1.25, 2), stroke: 1pt)
    
    line((3, 0.8), (3, 1.3), stroke: 1pt)
    line((4, 0.9), (4, 1.6), stroke: 1pt)
    line((3, 1.3), (3.5, 1.6), stroke: 1pt)
    line((3.5, 1.6), (3.5, 2.2), stroke: 1pt)
    line((4, 1.6), (3.5, 2.2), stroke: 1pt)
    
    line((1.25, 2), (2.375, 2.8), stroke: 1pt)
    line((3.5, 2.2), (2.375, 2.8), stroke: 1pt)
    
    // 标签
    for i in (0, 1, 2, 3, 4) {
      content((i, -0.3), [样本#{i+1}])
    }
    
    // 距离刻度
    line((-0.5, 0), (-0.5, 3), stroke: 0.5pt)
    for i in (0, 1, 2, 3) {
      line((-0.6, i), (-0.4, i), stroke: 0.5pt)
    }
    content((-1, 1.5), [距离])
  })
)

== 层次聚类的链接方法

#property[簇间距离计算方法][
  - *单链接 (Single-link)*：两簇中最近的两个点之间的距离。适合任意形状聚类，但对噪声敏感
  - *全链接 (Complete-link)*：两簇中最远的两个点之间的距离。倾向生成紧凑球形聚类，对噪声不敏感
  - *平均链接 (Average-link)*：两簇中所有点对距离的平均值。介于单链接和全链接之间的折衷
  - *质心链接 (Centroid-link)*：两簇质心之间的距离。对噪声不敏感，偏向球形聚类
]

#example[层次聚类执行示例][
  数据点：$(1,1), (1,2), (2,1), (2,2), (3,4), (3,5), (4,4), (4,5)$，目标簇数$k=2$

  #table(
    columns: (auto, auto, auto, auto),
    inset: 5pt, align: center,
    table.header([步骤], [最近距离], [合并簇], [合并后簇集合]),
    [1], [1], [{1},{2}], [{1,2},{3},{4},{5},{6},{7},{8}],
    [2], [1], [{3},{4}], [{1,2},{3,4},{5},{6},{7},{8}],
    [3], [1], [{5},{6}], [{1,2},{3,4},{5,6},{7},{8}],
    [4], [1], [{7},{8}], [{1,2},{3,4},{5,6},{7,8}],
    [5], [1], [{1,2},{3,4}], [{1,2,3,4},{5,6},{7,8}],
    [6], [1], [{5,6},{7,8}], [{1,2,3,4},{5,6,7,8}],
  )

  达到目标簇数2，停止。复杂度：层次聚类至少$O(n^2)$，全链接和平均链接达$O(n^2 log n)$。
]

== 距离度量

#property[数值型属性距离][
  - *闵可夫斯基距离*：$d(x_i, x_j) = (|x_(i 1) - x_(j 1)|^h + ... + |x_(i r) - x_(j r)|^h)^(1/h)$
  - $h=2$：欧氏距离；$h=1$：曼哈顿距离
  - *切比雪夫距离*：$d(x_i, x_j) = max_k |x_(i k) - x_(j k)|$
  - *加权欧氏距离*：$d(x_i, x_j) = sqrt(sum_k w_k (x_(i k) - x_(j k))^2)$
]


#property[文本相似度][
  - *余弦相似度*：$"sim"(x, y) = (x dot y) / (||x|| ||y||)$，是文本聚类最常用的相似度函数
  - 文本表示为词袋模型（Bag of Words），忽略词序和位置
]

== 数据标准化

#definition[为何需要标准化][
  当属性量纲不同（如 $(0.1, 20)$ 与 $(0.9, 720)$），距离完全由量纲大的属性主导（$700 >> 0.8$），标准化强制各属性在相同范围变化。
]

#property[标准化方法][
  - *范围标准化 (Min-Max)*：$x_"norm" = (x - x_min) / (x_max - x_min)$，将值映射到$[0,1]$
  - *Z-score标准化*：$z = (x - mu) / s$，其中$mu$为均值，$s$为标准差。指出偏离均值的标准差倍数
]

== K-Means深入分析

#property[K-Means的劣势与应对][
  - *异常值敏感*：异常值会显著拉偏质心。解决方法：(1) 去除远离质心的点；(2) 随机采样后预聚类再分配
  - *对初始种子敏感*：不同初始质心可能导致不同结果。改进：多轮随机初始化选最优；K-Means++
  - *不适合非球形聚类*：K-Means假设簇是超球体形状，对拉长或不规则形状的聚类效果差
]

#property[聚类表示][
  - *质心表示*：用聚类中心和半径/标准差描述，适用于球形聚类
  - *分类模型表示*：将聚类结果作为标签，训练分类器得到if-then规则，可解释性强
  - *众数表示*：用簇中最常见的值表示，适用于范畴属性和文本聚类
]


#problemset[
#example[2024期末考题 - EM算法与GMM聚类][
  可以用EM算法估计高斯混合模型（GMM）的参数 $theta$。请：
  
  (1) 写出EM算法的核心思想和具体步骤
  
  (2) 在GMM聚类算法中，哪些步骤对应体现了E步和M步
]

#solution[
  *(1) EM算法的核心思想和步骤*
  
  EM算法（期望最大化算法）是一种迭代优化算法，用于含有隐变量的概率模型参数估计。
  
  *核心思想*：
  - 当模型含有隐变量（如样本属于哪个高斯分布）时，直接使用MLE难以求解
  - EM算法通过迭代方式进行：先猜测隐变量（E步），再基于猜测更新参数（M步）
  - 每次迭代都保证似然函数不减小，最终收敛到局部最优
  
  *算法步骤*：
  
  *E步（Expectation，期望步）*：
  - 根据当前参数 $theta^(t)$，计算隐变量的后验概率（期望）
  - 对每个样本，计算它属于每个高斯分布的概率（责任值）
  
  *M步（Maximization，最大化步）*：
  - 基于E步计算的责任值，更新模型参数 $theta^(t+1)$
  - 最大化完全数据的对数似然函数的期望
  
  *迭代*：重复E步和M步，直到参数收敛或似然函数变化小于阈值。
  
  *(2) GMM中的E步和M步*
  
  高斯混合模型（GMM）：假设数据来自 $K$ 个高斯分布的混合，每个分布有自己的均值 $mu_k$、协方差 $Sigma_k$ 和混合系数 $pi_k$。
  
  *E步（计算责任值）*：
  对每个样本 $x_i$ 和每个高斯成分 $k$，计算：
  $ gamma_(i k) = (pi_k N(x_i | mu_k, Sigma_k)) / (sum_(j=1)^K pi_j N(x_i | mu_j, Sigma_j)) $
  
  其中 $gamma_(i k)$ 表示样本 $x_i$ 属于第 $k$ 个高斯分布的后验概率（责任值）。
  
  *M步（更新参数）*：
  基于责任值更新GMM参数：
  
  - 更新混合系数：$pi_k = (sum_(i=1)^N gamma_(i k)) / N$
  
  - 更新均值：$mu_k = (sum_(i=1)^N gamma_(i k) x_i) / (sum_(i=1)^N gamma_(i k))$
  
  - 更新协方差：$Sigma_k = (sum_(i=1)^N gamma_(i k) (x_i - mu_k)(x_i - mu_k)^T) / (sum_(i=1)^N gamma_(i k))$
  
  *对应关系*：
  - E步对应计算样本属于各簇的后验概率（软分配）
  - M步对应根据分配更新各高斯分布的参数（类似于K-Means的质心更新，但是软分配版本）
]
]

#pagebreak()
// = 期末应考总结
//
//== 核心概念速查表
//
//#table(
//  columns: (2.5cm, 4cm, 8cm),
//  inset: 8pt,
//  align: (center, center, left),
//  table.header([章节], [核心概念], [关键公式/算法]),
//  [概念学习], [假设空间、变型空间、归纳偏置], [Find-S: 从特殊到一般; 候选消除: 维护S/G边界],
//  [决策树], [信息熵、信息增益、ID3], [$"Entropy" = -sum p_i log p_i$; 选择信息增益最大的属性],
//  [神经网络], [感知器、Sigmoid、BP算法], [感知器规则: $Delta w = eta(t-o)x$; BP: 反向传播误差],
//  [贝叶斯], [MAP/ML假设、朴素贝叶斯], [$h_"MAP" = arg max P(D|h)P(h)$; 独立性假设],
//  [实例学习], [KNN、距离加权、局部加权回归、RBF], [K个最近邻投票; 局部加权; 惰性vs积极学习],
//  [遗传算法], [编码、交叉、变异、选择], [轮盘赌; 锦标赛选择; 单点/两点/均匀交叉],
//  [回归分析], [线性回归、逻辑回归、正则化], [梯度下降; Sigmoid交叉熵; L1/L2正则化],
//  [线性分类器], [线性判别、感知器准则、多分类], [OvR/OvO/MvM; 决策边界几何意义],
//  [特征选择], [Relief、LVW、LASSO、稀疏表示], [过滤/包裹/嵌入式; L1稀疏解; 字典学习],
//  [聚类], [K-Means、层次聚类、标准化], [K-Means迭代; 单/全/平均链接; Z-score标准化],
//)
//
//== 算法对比
//
//#figure(
//  caption: [监督学习算法对比],
//  table(
//    columns: (2.5cm, 3cm, 3cm, 3cm, 3cm),
//    inset: 6pt,
//    align: center,
//    table.header([算法], [模型类型], [训练方式], [优点], [缺点]),
//    [决策树], [非参数], [贪心分裂], [可解释性强], [易过拟合],
//    [神经网络], [参数], [梯度下降], [表达能力强], [黑盒、需调参],
//    [朴素贝叶斯], [概率], [频率估计], [简单高效], [独立性假设],
//    [KNN], [非参数], [惰性学习], [无需训练], [预测慢、存储大],
//    [逻辑回归], [参数], [梯度下降], [概率输出], [线性决策边界],
//    [遗传算法], [进化], [选择+交叉+变异], [全局搜索、可并行], [收敛速度不确定],
//    [线性分类器], [参数], [准则优化], [简单、可解释], [仅线性可分],
//    [K-Means], [非参数], [迭代分配], [简单高效], [需指定K、对初值敏感],
//  )
//)
//
//== 易错点提醒
//
//#property[常见错误][
//  1. *概念学习*：
//     - 混淆一般/特殊假设的方向
//     - 忘记Find-S只处理正例
//     - 候选消除算法中S/G边界更新方向搞反
//  
//  2. *决策树*：
//     - 信息增益计算时忘记加权平均
//     - 熵的计算公式记错（注意负号）
//     - 混淆信息增益和信息增益率
//  
//  3. *神经网络*：
//     - 感知器只能处理线性可分问题
//     - Sigmoid导数公式：$sigma' = sigma(1-sigma)$
//     - BP算法中误差项的传递方向
//  
//  4. *贝叶斯*：
//     - MAP vs ML的区别（是否考虑先验）
//     - 癌症检测类问题的直觉错误
//     - 朴素贝叶斯的独立性假设
//  
//  5. *聚类*：
//     - K-Means对初始质心敏感
//     - K值需要预先指定
//     - 不同距离度量的适用场景
//
//  6. *线性分类器*：
//     - 感知器准则只适用于线性可分问题
//     - OvR和OvO存在不确定区域
//     - 增广形式中不要忘记偏置项$w_0$
//
//  7. *特征选择*：
//     - 过滤式/包裹式/嵌入式的区别
//     - Relief通过near-hit和near-miss更新权重
//     - L1产生稀疏解的原因（菱形约束 vs 球形约束）
//     - 前向/后向搜索是贪心策略，只能得到局部最优
//]
//
//== 典型计算题步骤
//
//#definition[信息增益计算步骤][
//  1. 计算数据集的总熵：$"Entropy"(S) = -p_+ log_2 p_+ - p_- log_2 p_-$
//  2. 按属性值划分数据集
//  3. 计算每个子集的熵
//  4. 计算加权平均熵：$sum (|S_v|/|S|) "Entropy"(S_v)$
//  5. 信息增益 = 总熵 - 加权平均熵
//]
//
//#definition[贝叶斯计算步骤][
//  1. 列出所有假设的先验概率$P(h)$
//  2. 列出似然$P(D|h)$
//  3. 计算$P(D|h)P(h)$对每个假设
//  4. MAP假设 = $arg max P(D|h)P(h)$
//  5. （可选）计算后验概率$P(h|D)$
//]
//
//#definition[神经网络前向/反向传播步骤][
//  *前向传播*：
//  1. 输入层接收输入
//  2. 隐藏层计算加权和，应用激活函数
//  3. 输出层计算最终输出
//  
//  *反向传播*：
//  1. 计算输出层误差：$delta = o(1-o)(t-o)$
//  2. 反向传播到隐藏层：$delta_j = o_j(1-o_j) sum w_(k j) delta_k$
//  3. 更新权重：$Delta w = eta delta x$
//]
//
//#note[
//  *考试技巧*：
//  - 计算题要写清楚每一步的公式和代入值
//  - 比较类题目要说明比较的维度
//  - 算法题要说明输入输出和关键步骤
//  - 证明题从定义出发，逻辑清晰
//]
//
//#pagebreak()
// = 附录：重要公式汇总
//
//== 信息论
//
//$ "Entropy"(S) = -sum_(i=1)^c p_i log_2 p_i $
//
//$ "Gain"(S, A) = "Entropy"(S) - sum_(v in "Values"(A)) |S_v|/|S| "Entropy"(S_v) $
//
//== 概率
//
//$ P(h|D) = (P(D|h) P(h)) / P(D) $
//
//$ h_"MAP" = arg max_(h in H) P(D|h) P(h) $
//
//$ h_"ML" = arg max_(h in H) P(D|h) $
//
//== 神经网络
//
//$ sigma(x) = 1 / (1 + e^(-x)) $
//
//$ dif sigma(x)/dif x = sigma(x)(1 - sigma(x)) $
//
//$ Delta w_(j i) = eta delta_j x_(j i) $
//
//== 回归
//
//$ J = 1/(2m) sum_(i=1)^m (y^((i)) - hat(y)^((i)))^2 $
//
//$ J_"L2" = J + lambda/(2m) sum theta_j^2 $
//
//$ J_"L1" = J + lambda/m sum |theta_j| $
//
//== 聚类
//
//$ J = sum_(j=1)^k sum_(x in C_j) ||x - mu_j||^2 $
//
//#pagebreak()
= 深度学习

#introduction[深度学习概述][特征学习][梯度消失][预训练与微调][深度vs传统机器学习]

== 深度学习概述

#definition[什么是深度学习][
  深度学习是机器学习的分支，以*多层神经网络*为架构，从数据中*自动学习特征表示*，并进行预测或决策。

  深度学习的"深度"指的是神经网络的层数较多，能够学习到数据的*多层次抽象表示*。
]

=== 生物学启示

#property[人脑视觉机理][
  人脑视觉皮层是*分层*的，从低级到高级逐层抽象：

  1. *视网膜(Retina)*：获取原始图像像素
  2. *V1区*：提取边缘特征
  3. *V2区*：获取基本形状或目标的局部
  4. *V4区*：得到整个目标（如判定为一张人脸）
  5. *PFC（前额叶皮层）*：进行分类判断

  神经-中枢-大脑的工作过程是一个不断*迭代、抽象*的过程，从原始信号做低级抽象，逐渐向高级抽象迭代。
]


=== 深度学习基本思想

#definition[特征学习][
  传统机器学习：
  - 良好的*特征表达*对算法准确性起关键作用
  - 特征工程通常由*人工*完成，耗时耗力

  深度学习：
  - *"深度模型"是手段，"特征学习"是目的*
  - 通过*逐层特征变换*，将样本在原空间的特征表示变换到新特征空间
  - 使分类或预测更加容易
]

#property[多层次特征获取][
  假设有一堆输入 $I$（如图像或文本），设计一个系统 $S$（有 $n$ 层）：
  - 调整系统参数，使得输出仍然是输入 $I$
  - 这样就能自动获取输入 $I$ 的一系列层次特征 $S_1, ..., S_n$

  *核心思想*：
  - *堆叠多个层*，这一层的输出作为下一层的输入
  - 实现对输入信息的*分级表达*
  - 高层可以综合应用低层信息
  - 低层关注"局部"，高层关注"全局"、更具有语义化
]

=== 传统神经网络的问题

#property[深度神经网络的训练困难][
  1. *需要带标签训练数据*
     - 实际中几乎所有数据是无标签的
     - 人脑可以从无标签数据中学习

  2. *BP算法的梯度消失/爆炸问题*
     - 随着网络层数增加，反向传播过程中梯度可能变得*非常小*（梯度消失）
     - 或变得*非常大*（梯度爆炸）
     - 使得深层网络难以训练
]

#definition[梯度消失与梯度爆炸][
  *梯度消失*：
  - 反向传播过程中，损失函数相对于权重的梯度变得非常小
  - 后面的层难以学习有意义的模式
  - 权重的更新可以忽略

  *梯度爆炸*：
  - 反向传播过程中梯度变得非常大
  - 权重更新量过大，导致训练不稳定
  - 优化过程难以控制

  *简单理解*：随着迭代次数增加，越来越多的神经元进入*饱和区*（Sigmoid等激活函数的导数接近0），阻止了梯度的传播。
]

=== 训练深度神经网络的方法

#definition[预训练 + 微调策略][
  为解决深层网络的训练问题，Hinton提出*逐层预训练*策略：

  *Step 1: 预训练（Pre-training）*
  - 使用*贪婪的、逐层训练*方法
  - 使用*无监督学习*，每次训练一层
  - 固定先前隐藏层的参数，再训练下一层
  - 先前的层可以被视为*特征提取器*
  - 学习 $p("input")$，而不是 $p("label" | "input")$

  *Step 2: 微调（Fine-tuning）*
  - 添加输出层
  - 使用*监督学习*训练整个网络
  - 前向传播、反向传播和参数更新
  - 所有参数针对目标任务进行"调整"
  - 学习到更具辨别力的特征表示
]

#note[
  通过"*逐层初始化*"（layer-wise pre-training）有效克服梯度消失或膨胀问题：
  - 自下向上：非监督的贪婪逐层训练
  - 自顶向下：监督学习微调整个网络
]

=== 传统机器学习 vs 深度学习

#figure(
  caption: [传统机器学习与深度学习对比],
  align(center)[
    #table(
      columns: (auto, auto, auto),
      inset: 8pt, align: (left, left, left),
      table.header([特征], [机器学习], [深度学习]),
      [数据要求], [适用于较小的结构化数据], [需要大量非结构化数据],
      [特征工程], [手动完成], [由模型自动完成],
      [计算能力], [要求较低], [需要高性能计算（GPU）],
      [训练时间], [相对较短], [更长],
      [可解释性], [相对较好], [通常被称为"黑匣子"],
      [适合的问题], [简单或中等复杂任务], [图像、音频、NLP等高度复杂任务],
    )
  ]
)

#property[关键区别][
  - *特征工程*：机器学习需要人工设计和提取特征；深度学习自动学习特征
  - *数据需求*：深度学习需要大量数据才能发挥优势
  - *计算需求*：深度学习需要GPU等高性能计算设备
  - *网络深度*：传统神经网络通常2-3层；深度神经网络5层以上，甚至上百层
]


== 自编码器（AutoEncoder）

#definition[自编码器概述][
  自编码器（AutoEncoder, AE）是*多层神经网络*的一种*非监督式学习*算法，其架构可解析为两个部分：
  
  1. *Encoder（编码器）*：做*压缩*动作，将高维输入映射到低维表示
  2. *Decoder（解码器）*：做*解压缩*动作，将低维表示还原为输出
  
  目标：让输出值与输入值相同，通过重建输入来学习数据的特征表示。

  通常AE的隐藏层节点数*少于*输入层节点数，编码器会建立隐藏层对输入信息的*低维表示*（code）。
]

#figure(
  caption: [自编码器结构示意图],
  cetz.canvas({
    import cetz.draw: *
    
    // 输入层
    for i in (0.5, 1.5, 2.5, 3.5) {
      circle((-2, i), radius: 0.25, fill: rgb("#e3f2fd"), stroke: 1pt)
    }
    content((-2, 4.2), [输入层\n$x$])
    
    // 编码器隐藏层
    for i in (1, 2, 3) {
      circle((0, i), radius: 0.25, fill: rgb("#fff3e0"), stroke: 1pt)
    }
    content((0, 4.2), [编码器\nEncoder])
    
    // Code层（瓶颈层）
    circle((2, 2), radius: 0.25, fill: rgb("#f3e5f5"), stroke: 1pt)
    content((2, 3.2), [Code\n瓶颈层])
    
    // 解码器隐藏层
    for i in (1, 2, 3) {
      circle((4, i), radius: 0.25, fill: rgb("#fff3e0"), stroke: 1pt)
    }
    content((4, 4.2), [解码器\nDecoder])
    
    // 输出层
    for i in (0.5, 1.5, 2.5, 3.5) {
      circle((6, i), radius: 0.25, fill: rgb("#e8f5e9"), stroke: 1pt)
    }
    content((6, 4.2), [输出层\n$hat(x)$])
    
    // 连接线
    for i in (0.5, 1.5, 2.5, 3.5) {
      for j in (1, 2, 3) {
        line((-1.75, i), (-0.25, j), stroke: 0.5pt + rgb("#9e9e9e"))
      }
    }
    for i in (1, 2, 3) {
      line((0.25, i), (1.75, 2), stroke: 0.5pt + rgb("#9e9e9e"))
    }
    for i in (1, 2, 3) {
      line((2.25, 2), (3.75, i), stroke: 0.5pt + rgb("#9e9e9e"))
    }
    for i in (1, 2, 3) {
      for j in (0.5, 1.5, 2.5, 3.5) {
        line((4.25, i), (5.75, j), stroke: 0.5pt + rgb("#9e9e9e"))
      }
    }
    
    // 重建误差标注
    content((2, -0.5), [目标：$"minimize" ||x - hat(x)||^2$])
  })
)

=== 栈式自编码器（Stacked AutoEncoder）

#definition[栈式自编码器][
  栈式自编码器（Stacked AE, SAE）是*最基本的一种深度学习方法*：
  - 利用多层神经网络学习不同层次的抽象特征
  - 给定一个神经网络，令其*输出与输入相同*
  - 训练调整其参数，得到每一层的权重
  - 每一层的输出就代表一种*特征表示*
]

#property[栈式自编码器的特点][
  - 自动编码器是一种*尽可能复现输入信号*的神经网络
  - 为了实现这种复现，必须捕捉可以代表输入数据的*最重要因素*
  - 采用*无监督逐层学习*，能学习到不同层次的特征
]

=== 栈式自编码器的学习过程

#property[无监督学习阶段][
  由于只有无标签数据，误差就是*重构后的输出数据与原输入数据的差值*。

  通过调整 encoder 和 decoder 的参数，使得*重构误差最小*，这样就得到输入信号的一个特征表示（code）。
]

#definition[逐层训练（Layer-wise Training）][
  自编码器"栈化"——通过编码器产生特征，*依次训练下一层*：

  1. *第一层训练*：
     - 用原始输入 $x$ 训练第一个自编码器
     - 最小化重构误差，得到第一层参数
     - 第一层的 code 是原输入信号的*一阶特征表示*

  2. *第二层训练*：
     - 将第一层输出的 code 作为第二层的输入
     - 同样最小化重构误差，得到第二层参数
     - 第二层的 code 是原输入信息的*二阶特征表示*

  3. *重复*：其他层以同样的方法进行

  关键点：
  - 每一层都相信前一层的 code 是原信号的良好表达
  - 高层学习更抽象、更复杂的特征组合
]

=== 监督微调（Fine-tuning）

#definition[监督学习阶段][
  为了实现特定任务（如分类），需要在预训练后进行监督微调：

  *Step 1: 添加分类器*
  - 在 AutoEncoder 的最后编码层添加一个分类器（如 Softmax 回归）
  - 最后一层的 code 输入到分类器中

  *Step 2: 训练分类器*
  - 基于有标签样本，通过监督学习训练分类器
  - 可以*只调整分类器*参数（数据较少时）

  *Step 3: 整体微调*（Fine-tuning）
  - 如果有足够多的数据，*微调整个系统*
  - 通过反向传播算法（BP）同时调整所有层的参数
  - 改善整个网络的学习结果
]



=== 其他形式的自编码器

#definition[变分自编码器（VAE, Variational AutoEncoder）][
  - *用途*：用于图像生成
  - *原理*：编码器学习到输入图像数据的*概率分布*（正态分布的均值和方差）
  - *生成过程*：从该分布进行采样，经解码器生成富有变化的图像
  - *特点*：可以生成与训练数据相似但全新的样本
]

#definition[降噪自编码器（Denoising AE）][
  - *用途*：去掉输入数据的噪声，恢复其原始表示
  - *实现*：在输入中加入随机噪声，然后输出原始无噪声的数据
  - *效果*：使模型学会去噪的能力，学习更鲁棒的特征表示
]

#definition[稀疏自编码器（Sparse AE）][
  - *原理*：在 AutoEncoder 的基础上加上*L1正则化*
  - *效果*：编码器将每个输入表示为*少量节点的组合*，只有一部分节点非零值（活动节点）
  - *优点*：特征稀疏化可以*过滤掉无用的信息*，给出比原始数据更好的特征描述
]

=== 应考要点

#property[自编码器考点][
  1. *自编码器结构*：Encoder（编码器）+ Decoder（解码器），输出≈输入
  2. *学习目标*：最小化重构误差，学习数据的低维特征表示
  3. *栈式自编码器*：多层AE堆叠，最基本的一种深度学习方法
  4. *训练流程*：无监督逐层预训练 → 添加分类器 → 监督整体微调
  5. *MNIST示例*：4步流程（一阶特征→二阶特征→Softmax分类→整体微调）
  6. *层次化特征*：边→轮廓/角→复杂特征（图像数据）
  7. *变分自编码器VAE*：用于图像生成，学习概率分布
  8. *降噪自编码器*：输入加噪声，学习去噪
  9. *稀疏自编码器*：L1正则化，学习稀疏表示
]

== 卷积神经网络（CNN）

#definition[CNN概述][
  卷积神经网络（Convolutional Neural Network, CNN）是一种特殊的深层神经网络结构，主要用于处理具有*局部空间模式*的数据（如图像）。

  CNN 的核心特点：
  - *局部连接*：神经元只与输入的局部区域连接
  - *权值共享*：同一层中某些神经元共享相同的权重
  - *降维采样*：通过池化层减少特征图尺寸
]

=== 生物学动机

#property[Hubel和Wiesel的研究（1960s）][
  20世纪60年代，Hubel和Wiesel研究猫脑皮层，发现：

  1. *感受野*：猫的初级视觉皮层中单个神经元具有感受野，且感受野很小
  2. *特征选择性*：初级视觉皮层神经元对刺激特征有选择性，如方向、空间频率
  3. *Hubel-Wiesel结构*：
     - *简单细胞*：只对特定的空间位置和方向具有强烈反应
     - *复杂细胞*：具有更大的接受域，对特征位置的微小偏移具有*不变性*

  *启示*：基于大脑的分层视觉处理机制，构建了CNN的特殊结构。
]

=== 全连接网络的问题

#property[全连接神经网络的局限][
  1. *复杂度高*：参数数量巨大
  2. *忽略空间信息*：
     - 所有输入像素都是平等关系
     - 相邻像素与不相邻像素同等对待
     - 无法使用图像的空间信息（像素之间的空间联系）
  3. *排列不变性*：不同的像素排列顺序代表不同的图像，但全连接网络对此不敏感
]

=== 卷积的作用

#property[图像的空间局部性][
  图像的空间联系具有*局部性*：
  - 局部的像素联系较为紧密
  - 距离较远的像素相关性较弱

  *卷积可用于*：
  - 图像增强
  - 特征提取（边缘、纹理等）

  #align(center)[
    #table(
      columns: (auto, auto, auto),
      inset: 6pt, align: center,
      table.header([卷积核], [效果], [用途]),
      [$mat(1/9, 1/9, 1/9; 1/9, 1/9, 1/9; 1/9, 1/9, 1/9)$], [模糊], [去噪],
      [$mat(0, -1, 0; -1, 5, -1; 0, -1, 0)$], [锐化], [增强边缘],
      [$mat(-1, -1, -1; -1, 8, -1; -1, -1, -1)$], [边缘检测], [提取轮廓],
    )
  ]
]

=== 局部连接与参数共享

#definition[局部感知野][
  *局部连接*：
  - 每个神经元只与输入的一个*局部区域*连接
  - 便于更好学习图像的局部特征
  - 减少了需要训练的权值数目（网络连接由稠密连接变为稀疏连接）
]

#definition[参数共享][
  *权值共享*：
  - 不同神经元*共享权值*
  - 共享权值的神经元功能相同，可以抽取相同的局部特征
  - 增加神经元数目，使其覆盖全部输入，可在输入的不同位置检测同一种特征
  - CNN具有*平移不变性*（translation invariance）
]

=== 卷积操作详解

#definition[卷积核（Filter/Kernel）][
  卷积操作使用一个小的权重矩阵（卷积核）在输入数据上滑动，进行局部加权求和。

  *一维卷积*：输入一维，卷积核一维
  
  *二维卷积*：输入二维（如图像），卷积核二维
  $ "Feature Map"[i, j] = sum_(m,n) "Input"[i+m, j+n] times "Filter"[m, n] $
]

#property[Padding（填充）][
  问题：卷积后特征图尺寸会减小
  
  解决：在输入向量的开头和结尾添加零
  
  *Valid卷积*：不填充，输出尺寸减小
  
  *Same卷积*：填充使得输出尺寸与输入相同
  
  填充原则：*左奇右偶*（左侧填充数 = 核大小//2，右侧 = 核大小 - 左侧 - 1）
]

#definition[输出尺寸计算][
  输入尺寸：$n$，卷积核大小：$f$，Padding：$p$，步长：$s$
  
  输出尺寸：$ o = floor((n + 2p - f) / s) + 1 $
]

#example[卷积计算示例][
  输入图像：$7 times 7$，卷积核：$3 times 3$，Padding：$p=0$，步长：$s=2$
  
  输出尺寸：$floor((7 + 0 - 3) / 2) + 1 = floor(4/2) + 1 = 3$
  
  输出特征图大小：$3 times 3$
]

#figure(
  caption: [二维卷积操作示意图],
  cetz.canvas({
    import cetz.draw: *
    
    // 输入特征图 (5x5)
    content((-2, 3), [输入特征图])
    for i in range(5) {
      for j in range(5) {
        rect((i*0.5-1.25, j*0.5), (i*0.5-0.75, j*0.5+0.5), fill: rgb("#e3f2fd"), stroke: 0.5pt)
      }
    }
    // 高亮卷积核位置
    rect((-0.25, 1), (1.25, 2.5), fill: rgb("#fff59d"), stroke: 1.5pt + rgb("#f44336"))
    
    // 卷积核 (3x3)
    content((4, 3), [卷积核])
    for i in range(3) {
      for j in range(3) {
        rect((i*0.5+3, j*0.5+1), (i*0.5+3.5, j*0.5+1.5), fill: rgb("#ffcc80"), stroke: 0.5pt)
      }
    }
    // 卷积核数值示例
    content((3.25, 2.25), [-1])
    content((3.75, 2.25), [0])
    content((4.25, 2.25), [1])
    content((3.25, 1.75), [-1])
    content((3.75, 1.75), [0])
    content((4.25, 1.75), [1])
    content((3.25, 1.25), [-1])
    content((3.75, 1.25), [0])
    content((4.25, 1.25), [1])
    
    // 箭头
    line((2, 1.75), (2.8, 1.75), stroke: 1.5pt, mark: (end: ">"))
    
    // 输出特征图 (3x3)
    content((7, 3), [输出特征图])
    for i in range(3) {
      for j in range(3) {
        rect((i*0.5+6, j*0.5+1), (i*0.5+6.5, j*0.5+1.5), fill: rgb("#e8f5e9"), stroke: 0.5pt)
      }
    }
    // 高亮当前计算的输出位置
    rect((6, 1), (6.5, 1.5), fill: rgb("#a5d6a7"), stroke: 1.5pt + rgb("#4caf50"))
    content((6.25, 1.25), [8])
    
    // 说明文字
    content((3.5, -0.5), [卷积核在输入上滑动，逐元素相乘后求和])
  })
)

=== 多卷积核与多通道

#definition[多卷积核][
  如果需要抽取图像的多种特征，可使用*多个卷积核*：
  - 每个卷积核生成一幅特征图
  - 多幅特征图可看作是图像的不同特征表示
  - 每个特征图可看作为一个*通道（channel）*
]

#definition[多通道卷积][
  输入有多个通道时（如RGB图像有3个通道）：
  - 卷积核也有对应的通道数
  - 所有通道的卷积结果相加，得到一个输出通道
  
  例：3个输入通道，卷积得到2个输出通道
]

#property[卷积层神经元][
  - 卷积核的每个数值对应卷积层神经元的一个输入链接的*权重*
  - 一个卷积计算的结果作为卷积层一个神经元的净输入
  - 卷积层神经元通常使用 *ReLU* 函数作为激活函数
  - 同一个卷积核对应的神经元有相同的*bias*（每个卷积核有一个bias）
  - 卷积层要学习的参数为：卷积核权重 + bias
]

=== 池化层（Pooling）

#definition[池化操作][
  池化层对卷积层输出的 Activation Map 进行*降维*操作：
  - 设置池化核的维度及步长
  - 对 Activation Map 不同位置的特征数据进行*聚合统计*
  - 池化层*无学习参数*
  - 输出为 Pooled Feature Map
]

#property[池化运算类型][
  1. *Max Pooling（最大池化）*：取池化核区域内的最大值
  2. *Average Pooling（平均池化）*：取池化核区域内的平均值
]

#definition[池化后的尺寸][
  输入：$n_H times n_W times n_c$（高×宽×通道数）
  
  池化核：$f$，步长：$s$
  
  输出：$ floor((n_H - f) / s) + 1 times floor((n_W - f) / s) + 1 times n_c $
]

#property[池化的作用][
  1. *降维*：减少特征图的空间大小，减少参数和计算量
  2. *平移不变性*：对输入图像中的微小平移或扭曲保持不变
  3. *防止过拟合*：降低模型复杂性
  4. *特征层次*：构建特征的层次表示（低层细节→高层抽象）
]

#figure(
  caption: [最大池化(Max Pooling)操作示意图],
  cetz.canvas({
    import cetz.draw: *
    
    
    // 用颜色标注池化区域
    rect((-1.2, 2.3), (0, 3.5), fill: rgb("#fff59d"), stroke: 1pt + rgb("#f57f17"))
    rect((0, 2.3), (1.2, 3.5), fill: rgb("#c8e6c9"), stroke: 1pt + rgb("#388e3c"))
    rect((-1.2, 1.1), (0, 2.3), fill: rgb("#ffccbc"), stroke: 1pt + rgb("#d84315"))
    rect((0, 1.1), (1.2, 2.3), fill: rgb("#d1c4e9"), stroke: 1pt + rgb("#512da8"))
      content((0, 4), [输入特征图 ($4 times 4$)])
    let input = ((1, 3, 2, 1), (4, 2, 1, 5), (2, 6, 3, 2), (3, 1, 4, 2))
    for row in range(4) {
      for col in range(4) {
        let val = input.at(row).at(col)
        let x_min = col * 0.6 - 1.2
        let x_max = x_min + 0.6
        let y_max = 3.5 - row * 0.6
        let y_min = y_max - 0.6
        rect((x_min, y_min), (x_max, y_max), fill: none, stroke: 0.5pt)
        content((x_min + 0.3, y_min + 0.3), [#val])
      }
    }  
    // 箭头
    line((1.5, 2), (3, 2), stroke: 1.5pt, mark: (end: ">"))
    content((2.25, 2.3), [MaxPool\n$2 times 2$])
    
    // 输出特征图 (2x2)
    content((5, 3), [输出特征图 ($2 times 2$)])
    let output = ((4, 5), (6, 4))
    let colors = (rgb("#fff59d"), rgb("#c8e6c9"), rgb("#ffccbc"), rgb("#d1c4e9"))
    for i in range(2) {
      for j in range(2) {
        let val = output.at(j).at(i)
        rect((i*0.8+4, j*0.8+1), (i*0.8+4.8, j*0.8+1.8), fill: colors.at(i+j*2), stroke: 1pt)
        content((i*0.8+4.4, j*0.8+1.4), [#val])
      }
    }
    
    // 说明
    content((2, -0.3), [每个 $2 times 2$ 区域取最大值，输出尺寸减半])
  })
)

=== CNN基本结构

#definition[CNN的典型层次结构][
  卷积神经网络是一个多层的神经网络，通常包含：

  1. *卷积层（Convolutional Layer）*：提取局部特征
  2. *激活层（Activation Layer）*：通常使用ReLU
  3. *池化层（Pooling Layer）*：降维、增加平移不变性
  4. *全连接层（Fully Connected Layer）*：进行分类

  结构示例：
  ```
  输入 → [卷积 → ReLU → 池化] × N → 全连接 → Softmax → 输出
  ```
]

#figure(
  caption: [CNN特征提取层次示意图],
  cetz.canvas({
    import cetz.draw: *
    
    // 第一层：原始图像
  
    rect((-4.5, -1), (-3.5, 0.5), fill: rgb("#e3f2fd"), stroke: 1pt)
    content((-4, 0), [原始图像])
    content((-4, -2), [像素级])
    
    // 箭头
    line((-3.3, -0.25), (-2.2, -0.25), stroke: 1pt, mark: (end: ">"))
    
    // 第二层：边缘特征
    content((-1, 0.5), [边缘特征])
    for i in range(3) {
      line((-1.5+i*0.5, 0), (-1.5+i*0.5, -0.8), stroke: 1.5pt + rgb("#333"))
    }
    content((-1, -2), [边缘、纹理])
    
    // 箭头
    line((0, -0.25), (1, -0.25), stroke: 1pt, mark: (end: ">"))
    
    // 第三层：局部形状
    content((2.5, 0.5), [局部形状])
    circle((2.5, -0.3), radius: 0.4, fill: rgb("#fff3e0"), stroke: 1pt)
    content((2.5, -2), [轮廓、角点])
    
    // 箭头
    line((3.5, -0.25), (4.5, -0.25), stroke: 1pt, mark: (end: ">"))
    
    // 第四层：高级特征
    content((6, 0.5), [高级特征])
    rect((5.5, -0.8), (6.5, 0.2), fill: rgb("#e8f5e9"), stroke: 1pt)
    circle((6, -0.3), radius: 0.35, fill: rgb("#c8e6c9"), stroke: 1pt)
    content((6, -2), [眼睛、鼻子])
    
    // 箭头
    line((7, -0.25), (8, -0.25), stroke: 1pt, mark: (end: ">"))
    
    // 第五层：分类
    content((9.5, -2), [人脸])
    rect((9, -1), (10, 0.5), fill: rgb("#f3e5f5"), stroke: 1pt)
    content((9.5, 0), [分类结果])
    
    // 层次标注
    content((-4, 1.5), [低层])
    content((2.5, 1.5), [中层])
    content((9.5, 1.5), [高层])
    line((-4, 1.2), (9.5, 1.2), stroke: 0.5pt + rgb("#9e9e9e"))
  })
)

=== 经典CNN架构

#definition[LeNet-5（1998）][
  - Yann LeCun 提出
  - 当年美国大多数银行用它识别支票上的手写数字
  - 结构：卷积层 + 池化层 + 全连接层
  - 开创性地将卷积神经网络应用于实际问题
]

#definition[AlexNet（2012）][
  - ImageNet 2012 冠军，首次大幅提升分类准确率
  - 结构：5个卷积层 + 3个全连接层
  - 创新点：
    1. 使用 *ReLU* 代替 Tanh/Sigmoid
    2. 使用 *Dropout* 减少过拟合
    3. 使用两块 NVIDIA GTX 580 GPU 训练
]


#definition[VGG16（2014）][
  - ImageNet 2014 冠军，准确率92.7%
  - 创新：将 AlexNet 的大卷积核（11×11, 5×5）替换为*多个 3×3 卷积核*
  - 优势：在相同感受野下，多个小卷积核能学习更复杂的特征，且参数量更少
  - 配置：卷积核 3×3，步长1，池化核 2×2，步长2
]

#definition[ResNet（残差网络，2015）][
  - 何凯明等人提出，ImageNet 2015 冠军，Top-5 错误率仅 3.57%
  - 核心创新：*跳跃连接（Skip Connection）*
  - 残差块：$ bold(y) = F(bold(x)) + bold(x) $

  *解决的问题*：
  - 深层网络的*退化问题*：随着深度增加，训练误差饱和甚至上升
  - 梯度消失/爆炸：跳跃连接使梯度更容易流动
]

#property[为什么残差结构有效][
  - 如果深层模型在浅层模型基础上加入的层都是*恒等映射*，则深层模型误差不会比浅层大
  - 残差结构拟合恒等映射更简单：只需让 $F(x) = 0$
  - 跳跃连接使信息可以直接从一个层跳到另一个层，不经过所有非线性层
]

#figure(
  caption: [ResNet 残差块结构简化示意图],
  cetz.canvas({
    import cetz.draw: *

    // 样式参数
    let h = 0.8
    let w = 1.2
    let gap = 0.6
    
    // 绘制方块的函数
    let block(pos, text, fill-color) = {
      rect((pos.at(0) - w/2, pos.at(1) - h/2), (pos.at(0) + w/2, pos.at(1) + h/2), fill: fill-color, stroke: 1pt)
      content(pos, text)
    }

    // 1. 放置节点 (位置从左到右)
    let p1 = (0, 0)
    let p2 = (w + gap, 0)
    let p3 = (2*w + 2*gap, 0) // Conv + 加法器节点
    let p4 = (3*w + 3*gap, 0) // 最后的 ReLU

    // 绘制流程
    block(p1, [Conv], rgb("#e3f2fd"))
    block(p2, [ReLU], rgb("#fff3e0"))
    block(p3, [], rgb("#e3f2fd")) // 第三块：Conv层底色
    block(p4, [ReLU], rgb("#fff3e0"))

    // 在第三块中放置加法器
    circle(p3, radius: 0.3, fill: rgb("#fff59d"), stroke: 1pt)
    content(p3, [$+$])

    // 2. 连接线 (主路径)
    line((-1.5, 0), (p1.at(0) - w/2, 0), mark: (end: ">"))
    content((-1.8, 0), [$x$])
    
    line((p1.at(0) + w/2, 0), (p2.at(0) - w/2, 0), mark: (end: ">"))
    line((p2.at(0) + w/2, 0), (p3.at(0) - 0.3, 0), mark: (end: ">"))
    line((p3.at(0) + 0.3, 0), (p4.at(0) - w/2, 0), mark: (end: ">"))
    line((p4.at(0) + w/2, 0), (p4.at(0) + w/2 + 0.8, 0), mark: (end: ">"))
    content((p4.at(0) + w/2 + 1.8, 0), [$y = f(x) + x$])

    // 3. 跳跃连接 (红色)
    let start-x = -1.2
    line((start-x, 0), (start-x, -1.2), stroke: 2pt + rgb("#f44336"))
    line((start-x, -1.2), (p3.at(0), -1.2), stroke: 2pt + rgb("#f44336"))
    line((p3.at(0), -1.2), (p3.at(0), -0.3), stroke: 2pt + rgb("#f44336"), mark: (end: ">"))
    
    // 标注
    content((p3.at(0), 1.2), [权重层 $F(x)$])
    content((p3.at(0)/2 - 0.5, -1.5), [Skip Connection (Identity)], fill: white)
  })
)

=== CNN训练与适用

#property[CNN的训练过程][
  1. *前向传播*：从样本集取一个样本 $(X, Y_p)$，将 $X$ 输入网络，计算实际输出 $O_p$
  2. *反向传播*：计算实际输出与理想输出的差，按极小化误差方法反向调整权矩阵（BP算法）
]

#property[CNN的适用范围][
  *适用*：
  - 一维、二维及多维数据
  - 距离较近的数据比距离较远的数据关联性更强（局部空间模式）

  *不适用*：
  - 数据不能转换成类似图像的结构
  - 数据在交换任何列之后仍然同样有用（如客户表格数据）
]

=== 应考要点

#property[CNN考点][
  1. *CNN核心特点*：局部连接、权值共享、降维采样
  2. *生物学动机*：Hubel-Wiesel的简单细胞/复杂细胞
  3. *全连接网络问题*：忽略空间信息、参数量大
  4. *卷积核*：权重矩阵，用于特征提取
  5. *Padding*：Valid（不填充）vs Same（填充保持尺寸）
  6. *输出尺寸计算*：$o = floor((n + 2p - f) / s) + 1$
  7. *多通道*：输入通道、输出通道、卷积核通道数
  8. *池化*：Max Pooling vs Average Pooling，作用（降维、平移不变性、防过拟合）
  9. *经典网络*：LeNet-5、AlexNet（ReLU+Dropout）、VGG16（3×3小卷积核）、ResNet（跳跃连接）
  10. *ResNet解决的问题*：深层网络退化问题、梯度消失
]

== 循环神经网络（RNN）

#definition[RNN概述][
  循环神经网络（Recurrent Neural Network, RNN）是*专门设计用于处理序列数据*的神经网络。

  核心特点：
  - 通过*内部隐状态*保存先前输入的记忆
  - 该记忆保留了历史每一步的信息，并用它来影响未来的预测结果
  - 在*不同时间步骤之间共享参数*，比传统前馈网络更有效率
  - 利用*时间反向传播（BPTT）*进行训练
]

=== 序列数据建模

#property[序列数据的特点][
  1. *顺序敏感性*：改变序列的顺序会改变其含义
     - 例："猫捉老鼠" vs "老鼠捉猫" 含义完全不同

  2. *元素依赖性*：序列中的元素与之前（有时是之后）出现的元素相关
     - *短程依赖*：当前单词强烈依赖于紧邻的单词
     - *长程依赖*：所需信息可能早在很多步骤之前就出现了

  3. *可变长度*：序列通常具有可变的长度
]

#property[传统全连接网络的问题][
  - *忽略序列信息*：序列信息丢失，对数据元素的顺序不敏感
  - *依赖关系混乱*：无法建立当前信息与历史信息的依赖
  - *输入长度固定*：序列数据长度可变，若设计为最长序列长度，输入维度会非常高
  
  例：句子极性分类
  - "他做事，事倍功半。" vs "他做事，事半功倍。"
  - 全连接网络会输出同样结果（无法区分顺序）
]

=== RNN的结构

#definition[RNN的基本结构][
  RNN通过*隐藏层反馈*实现历史记忆：
  
  *权重矩阵*：
  - $U$：输入层到隐藏层的权重矩阵
  - $V$：隐藏层到输出层的权重矩阵  
  - $W$：隐藏层反馈权重矩阵（各时间步共享）

  *状态向量*：
  - $s_t$：$t$时刻隐藏层的状态向量（包含全部隐藏层节点的状态）
  - $s_t$ 取决于当前输入 $x_t$ 和上一时刻状态 $s_(t-1)$
]

#figure(
  caption: [RNN按时序展开结构],
  cetz.canvas({
    import cetz.draw: *
    
    // 时间节点
    for (i, label) in ((0, $t-1$), (2, $t$), (4, $t+1$)) {
      // 输入x
      circle((i, 0), radius: 0.25, fill: rgb("#e3f2fd"), stroke: 1pt)
      content((i, -0.6), [$x_#label$])
      
      // 隐藏层s
      circle((i, 2), radius: 0.3, fill: rgb("#fff3e0"), stroke: 1pt)
      content((i, 2), [$s$])
      content((i, 1.3), [$s_#label$])
      
      // 输出o
      circle((i, 4), radius: 0.25, fill: rgb("#e8f5e9"), stroke: 1pt)
      content((i, 4.6), [$o_#label$])
      
      // 垂直连接
      line((i, 0.25), (i, 1.7), stroke: 1pt, mark: (end: ">"))
      line((i, 2.3), (i, 3.75), stroke: 1pt, mark: (end: ">"))
    }
    
    // 水平连接（隐藏层之间的反馈）
    line((0.3, 2), (1.7, 2), stroke: 2pt + rgb("#f44336"), mark: (end: ">"))
    line((2.3, 2), (3.7, 2), stroke: 2pt + rgb("#f44336"), mark: (end: ">"))
    
    // 标注W
    content((1, 2.5), [$W$])
    content((3, 2.5), [$W$])
    content((0, 3), [$V$])
    content((2, 3), [$V$])
    content((4, 3), [$V$])
    content((0, 1), [$U$])
    content((2, 1), [$U$])
    content((4, 1), [$U$])
    
    // 说明
    content((2, -1.2), [权重矩阵 $W$ 各时间步共享])
  })
)

#property[RNN的计算过程][
  隐藏状态更新：
  $ s_t = f(U x_t + W s_(t-1) + b) $
  
  输出计算：
  $ o_t = g(V s_t + c) $
  
  其中 $f$ 通常是 tanh 或 ReLU，$g$ 根据任务选择（如 Softmax）。
]

=== RNN的训练与问题

#definition[BPTT（时间反向传播）][
  Back Propagation Through Time：
  - 考虑每个时间步的误差进行权重学习
  - 确保过去和当前状态都有助于输出正确结果
  - 本质是将RNN按时间展开成深层网络，然后应用标准BP算法
]

#property[RNN的梯度问题][
  训练长序列（如100个时间步）RNN时，梯度很容易*膨胀或消散*：
  
  *梯度消失原因*：
  - $tanh'$ 在 $(0,1)$ 之间
  - 如果 $W_s$ 也在 $(0,1)$ 之间，多次相乘后梯度趋近于0
  
  *后果*：
  - RNN很难记住*长距离依赖关系*（长期记忆）
  - 后面的时间步无法受到前面远距离信息的影响
  
  *解决办法*：Long Short Term Memory（LSTM）
]

=== 长短期记忆网络（LSTM）

#definition[LSTM概述][
  LSTM（Long Short Term Memory）由 Hochreiter & Schmidhuber（1997）提出。

  *核心思想*：
  - 原始RNN的隐藏层只有一个状态 $h$，对短期输入敏感，很难记忆长期依赖
  - 增加一个状态 $c$（单元状态，cell state）来保存*长期记忆*
  - $h$ 保存短期依赖，$c$ 保存长期依赖
]

#figure(
  caption: [LSTM单元结构示意],
  cetz.canvas({
    import cetz.draw: *
    
    // 主细胞
    rect((-1, -1), (1, 1), fill: rgb("#fff3e0"), stroke: 1.5pt)
    content((0, 0), [LSTM\n单元])
    
    // 输入
    line((-2, -0.5), (-1, -0.5), stroke: 1pt, mark: (end: ">"))
    content((-2.3, -0.5), [$x_t$])
    
    // 上一时刻输出
    line((-2, 0.5), (-1, 0.5), stroke: 1pt, mark: (end: ">"))
    content((-2.3, 0.5), [$h_(t-1)$])
    
    // 上一时刻细胞状态
    line((-2, 0), (-1, 0), stroke: 2pt + rgb("#f44336"), mark: (end: ">"))
    content((-2.5, 0), [$c_(t-1)$])
    
    // 输出
    line((1, 0.5), (2, 0.5), stroke: 1pt, mark: (end: ">"))
    content((2.3, 0.5), [$h_t$])
    
    // 细胞状态输出
    line((1, 0), (2, 0), stroke: 2pt + rgb("#f44336"), mark: (end: ">"))
    content((2.5, 0), [$c_t$])
    
    // 标注
    content((0, -1.5), [三个门：遗忘门、输入门、输出门])
  })
)

#figure(
  caption: [LSTM单元内部结构详图],
  cetz.canvas({
    import cetz.draw: *
    
    // 输入
    content((-4, -2), [$x_t$])
    line((-3.5, -2), (-2.5, -2), stroke: 1pt, mark: (end: ">"))
    
    // 上一时刻输出
    content((-4, 2), [$h_(t-1)$])
    line((-3.5, 2), (-2.5, 2), stroke: 1pt, mark: (end: ">"))
    
    // 遗忘门
    rect((-2, 1), (-1, 2), fill: rgb("#ffcdd2"), stroke: 1pt)
    content((-1.5, 1.5), [遗忘门])
    content((-1.5, 0.7), [$f_t$])
    line((-2.5, 2), (-2, 1.8), stroke: 0.5pt)
    line((-2.5, -2), (-2, 1.2), stroke: 0.5pt)
    
    // 输入门
    rect((-2, -1), (-1, 0), fill: rgb("#c8e6c9"), stroke: 1pt)
    content((-1.5, -0.5), [输入门])
    content((-1.5, -1.3), [$i_t$])
    line((-2.5, 2), (-2, -0.2), stroke: 0.5pt)
    line((-2.5, -2), (-2, -0.8), stroke: 0.5pt)
    
    // 候选状态
    rect((-0.5, -1), (0.5, 0), fill: rgb("#bbdefb"), stroke: 1pt)
    content((0, -0.5), [候选])
    content((0, -1.3), [$tilde(c)_t$])
    line((-2.5, 2), (-0.5, -0.2), stroke: 0.5pt)
    line((-2.5, -2), (-0.5, -0.8), stroke: 0.5pt)
    
    // 上一时刻细胞状态
    content((-4, 0), [$c_(t-1)$])
    line((-3.5, 0), (2, 0), stroke: 2pt + rgb("#f44336"), mark: (end: ">"))
    
    // 遗忘门乘法
    circle((-0.5, 1.5), radius: 0.25, fill: rgb("#ffcdd2"), stroke: 1pt)
    content((-0.5, 1.5), [×])
    line((-1, 1.5), (-0.75, 1.5), stroke: 0.5pt)
    line((-0.5, 1), (-0.5, 1.25), stroke: 0.5pt)
    
    // 输入门乘法
    circle((1.5, -0.5), radius: 0.25, fill: rgb("#c8e6c9"), stroke: 1pt)
    content((1.5, -0.5), [×])
    line((0.5, -0.5), (1.25, -0.5), stroke: 0.5pt)
    line((-1, -0.5), (1.25, -0.5), stroke: 0.5pt)
    
    // 加法
    circle((1.5, 0), radius: 0.25, fill: rgb("#fff9c4"), stroke: 1pt)
    content((1.5, 0), [+])
    line((-0.25, 1.5), (1.5, 0.25), stroke: 0.5pt)
    line((1.5, -0.25), (1.5, 0), stroke: 0.5pt)
    
    // 当前细胞状态
    content((3, 0), [$c_t$])
    line((1.75, 0), (2.5, 0), stroke: 2pt + rgb("#f44336"), mark: (end: ">"))
    
    // tanh
    rect((2.5, -0.5), (3.5, 0.5), fill: rgb("#d1c4e9"), stroke: 1pt)
    content((3, 0), [tanh])
    line((3, 0), (3, 0.8), stroke: 0.5pt)
    
    // 输出门
    rect((-2, -3), (-1, -2), fill: rgb("#fff9c4"), stroke: 1pt)
    content((-1.5, -2.5), [输出门])
    content((-1.5, -3.3), [$o_t$])
    line((-2.5, 2), (-2, -2.2), stroke: 0.5pt)
    line((-2.5, -2), (-2, -2.8), stroke: 0.5pt)
    
    // 输出门乘法
    circle((3, 1.3), radius: 0.25, fill: rgb("#fff9c4"), stroke: 1pt)
    content((3, 1.3), [×])
    line((-1, -2.5), (3, 1.05), stroke: 0.5pt)
    line((3, 0.8), (3, 1.05), stroke: 0.5pt)
    
    // 最终输出
    content((5, 1.3), [$h_t$])
    line((3.25, 1.3), (4.5, 1.3), stroke: 1pt, mark: (end: ">"))
    
    // 图例
    content((-1.5, -4.5), [遗忘门:])
    rect((-1, -4.8), (-0.5, -4.2), fill: rgb("#ffcdd2"), stroke: 0.5pt)
    content((0.5, -4.5), [输入门:])
    rect((1, -4.8), (1.5, -4.2), fill: rgb("#c8e6c9"), stroke: 0.5pt)
    content((2.5, -4.5), [输出门:])
    rect((3, -4.8), (3.5, -4.2), fill: rgb("#fff9c4"), stroke: 0.5pt)
  })
)

=== LSTM的三门结构

#definition[门（Gate）的概念][
  门实际上就是一层*全连接层*：
  - 输入是一个向量
  - 输出是一个0到1之间的实数向量（使用Sigmoid）
  - 用门的输出向量按元素乘以需要控制的那个向量，实现门控制
]

#property[LSTM的三个门][
  LSTM用*三个门*来控制信息的流动：

  1. *遗忘门（Forget Gate）*：
      决定上一时刻的单元状态 $c_(t-1)$ 有多少保留到当前时刻
      $ f_t = sigma(W_f dot [h_(t-1), x_t] + b_f) $

  2. *输入门（Input Gate）*：
      决定当前时刻的输入 $x_t$ 有多少保存到单元状态
      $ i_t = sigma(W_i dot [h_(t-1), x_t] + b_i) $
      $ tilde(c)_t = tanh(W_c dot [h_(t-1), x_t] + b_c) $

  3. *输出门（Output Gate）*：
     -控制单元状态 $c_t$ 有多少输出到当前时刻的隐藏状态 $h_t$
      $ o_t = sigma(W_o dot [h_(t-1), x_t] + b_o) $
]

=== LSTM的计算过程

#definition[单元状态更新][
  当前时刻的单元状态（长期记忆）：
  $ c_t = f_t dot c_(t-1) + i_t dot tilde(c)_t $

  含义：
  - $f_t dot c_(t-1)$：遗忘门控制保留多少历史信息
  - $i_t dot tilde(c)_t$：输入门控制加入多少新信息
]

#definition[隐藏状态输出][
  当前时刻的隐藏状态（短期记忆）：
  $ h_t = o_t dot tanh(c_t) $

  含义：
  - 输出门控制长期记忆 $c_t$ 有多少作为当前输出
  - 通过 $tanh$ 将 $c_t$ 映射到 $(-1, 1)$ 区间
]

#property[LSTM长短时记忆的形成][
  *控制长期状态 $c$*：
  - 遗忘门：控制继续保存长期状态
  - 输入门：控制把即时状态输入到长期状态

  *控制短期状态 $h$*：
  - 输出门：控制是否把长期状态的一部分作为当前时刻的短期记忆

  *由于遗忘门的控制*：
  - $c$ 可以保存很久很久之前的信息
  - 由于输入门的控制，又可以避免当前无关紧要的内容进入记忆
]

#property[LSTM如何避免梯度消失][
  长期记忆 $c$ 的迭代计算过程能保存更长的依赖信息。

  $c$ 与残差网络中的*跳跃链接*有类似功能：
  - 使得信息可以直接从一个层跳到另一个层
  - 不需要通过所有的非线性层
  - 这种设计允许梯度在网络中更容易地流动
  - 从而避免了梯度消失和爆炸的问题
]

#figure(
  caption: [RNN的不同应用类型],
  cetz.canvas({
    import cetz.draw: *
    
    // One-to-One (标准神经网络)
    content((-4, 5), [One-to-One])
    circle((-4.5, 4), radius: 0.3, fill: rgb("#e3f2fd"), stroke: 1pt)
    line((-4.5, 3.7), (-4.5, 3), stroke: 1pt, mark: (end: ">"))
    circle((-4.5, 2.7), radius: 0.3, fill: rgb("#e8f5e9"), stroke: 1pt)
    content((-3.7, 3.3), [标准NN])
    
    // One-to-Many (图像描述)
    content((0, 5), [One-to-Many])
    circle((-0.5, 4), radius: 0.3, fill: rgb("#e3f2fd"), stroke: 1pt)
    line((-0.5, 3.7), (-0.5, 3.3), stroke: 1pt, mark: (end: ">"))
    line((-0.5, 3.3), (-1, 2.8), stroke: 1pt, mark: (end: ">"))
    line((-0.5, 3.3), (0, 2.8), stroke: 1pt, mark: (end: ">"))
    line((-0.5, 3.3), (-0.5, 2.8), stroke: 1pt, mark: (end: ">"))
    for i in (-1, -0.5, 0) {
      circle((i, 2.5), radius: 0.2, fill: rgb("#e8f5e9"), stroke: 1pt)
    }
    content((1, 3.3), [图像描述])
    
    // Many-to-One (情感分类)
    content((4, 5), [Many-to-One])
    for i in (3.5, 4, 4.5) {
      circle((i, 4), radius: 0.2, fill: rgb("#e3f2fd"), stroke: 1pt)
      line((i, 3.8), (4, 3.3), stroke: 0.5pt)
    }
    line((4, 3.3), (4, 2.7), stroke: 1pt, mark: (end: ">"))
    circle((4, 2.5), radius: 0.3, fill: rgb("#e8f5e9"), stroke: 1pt)
    content((5, 3.3), [情感分类])
    
    // Many-to-Many 同步 (命名实体识别)
    content((-4, 1), [Many-to-Many])
    content((-4, 0.5), [(同步)])
    for i in (-4.5, -4, -3.5) {
      circle((i, 0), radius: 0.2, fill: rgb("#e3f2fd"), stroke: 1pt)
      line((i, -0.2), (i, -0.7), stroke: 0.5pt, mark: (end: ">"))
      circle((i, -0.9), radius: 0.2, fill: rgb("#e8f5e9"), stroke: 1pt)
    }
    content((-3, -0.5), [NER])
    
    // Many-to-Many 异步 (机器翻译)
    content((1, 1), [Many-to-Many])
    content((1, 0.5), [(异步)])
    for i in (0.5, 1, 1.5) {
      circle((i, 0), radius: 0.2, fill: rgb("#e3f2fd"), stroke: 1pt)
    }
    line((1, -0.2), (1, -0.6), stroke: 0.5pt)
    for i in (0.5, 1, 1.5, 2) {
      line((1, -0.6), (i, -0.9), stroke: 0.5pt, mark: (end: ">"))
      circle((i, -1.1), radius: 0.2, fill: rgb("#e8f5e9"), stroke: 1pt)
    }
    content((2.5, -0.5), [机器翻译])
    
    // 图例
    content((-5, -2), [图例：])
    circle((-4.2, -2), radius: 0.2, fill: rgb("#e3f2fd"), stroke: 1pt)
    content((-3.5, -2), [输入])
    circle((-2.5, -2), radius: 0.2, fill: rgb("#e8f5e9"), stroke: 1pt)
    content((-1.8, -2), [输出])
  })
)

#property[RNN与LSTM考点][
  1. *序列数据特点*：顺序敏感、元素依赖（短程/长程）、可变长度
  2. *RNN核心思想*：隐藏层反馈，保存历史记忆，参数共享
  3. *RNN结构*：权重矩阵U/V/W，状态向量$s_t$取决于$x_t$和$s_{t-1}$
  4. *BPTT*：时间反向传播，考虑每个时间步的误差
  5. *RNN梯度问题*：梯度消失/爆炸，难以记忆长距离依赖
  6. *LSTM核心*：增加单元状态$c$保存长期记忆，$h$保存短期依赖
  7. *三个门*：遗忘门（保留历史）、输入门（加入新信息）、输出门（输出控制）
  8. *LSTM计算*：$c_t = f_t dot c_{t-1} + i_t dot tilde(c)_t$，$h_t = o_t dot tanh(c_t)$
  9. *LSTM优势*：遗忘门可保存长期信息，输入门过滤无关内容，类似残差网络的跳跃连接
  10. *应用类型*：Many-to-One（分类）、Many-to-Many（翻译/预测）
]

#problemset[
#example[2024期末考题 - 自编码器原理与用途][
  自编码器将输入向量 $x$ 转换为中间向量 $z$，再将中间向量 $z$ 转换为向量 $x'$。请回答：
  
  (1) $x'$ 的长度与向量 $x$ 的长度有什么关系（大于、小于还是等于）？为什么？
  
  (2) 基于图像重构这一例子，说明自编码器的基本原理和用途。
]

#solution[
  *(1) $x'$ 与 $x$ 的长度关系*
  
  $x'$ 的长度 *等于* $x$ 的长度。
  
  *原因*：
  - 自编码器的目标是重建输入，即让输出 $x'$ 尽可能接近原始输入 $x$
  - 因此输出层和输入层的维度必须相同
  - 中间向量 $z$（code/瓶颈层）的维度通常 *小于* 输入维度，实现降维和特征压缩
  
  结构示意：输入 $x$（高维）→ 编码器 → 瓶颈层 $z$（低维）→ 解码器 → 输出 $x'$（与 $x$ 同维）
  
  *(2) 自编码器的基本原理和用途（以图像重构为例）*
  
  *基本原理*：
  
  自编码器由编码器（Encoder）和解码器（Decoder）两部分组成：
  
  - *编码器*：将高维输入（如图像像素）压缩为低维表示（latent code）
    $ z = f(x) $
  
  - *解码器*：从低维表示重建原始输入
    $ x' = g(z) $
  
  - *训练目标*：最小化重建误差 $||x - x'||^2$，迫使网络学习数据的有效压缩表示
  
  *主要用途*：
  
  1. *数据降维*：瓶颈层 $z$ 是输入的低维表示，可用于可视化和后续处理
  
  2. *特征学习*：编码器学到的特征可用于下游任务（分类、聚类等）
  
  3. *数据去噪*：训练时加入噪声，网络学习去除噪声恢复原始数据（降噪自编码器）
  
  4. *异常检测*：异常样本的重建误差较大，可用于检测异常
  
  5. *图像生成*：变分自编码器（VAE）可从潜在空间采样生成新图像
]

#example[2024期末考题 - RNN计算公式][
  根据下方循环神经网络示意图，写出输出层节点 $o_t$ 的计算公式（信息传递方向为从右向左）。其他参数符号自行定义。
  
  #figure(
    caption: [循环神经网络结构示意图],
    image("../assets/machinelearning/exam_rnn.png", width: 60%)
  )
]

#solution[
  *RNN结构分析*
  
  图中显示的是一个循环神经网络，信息从右向左传递（注意：题目强调方向）。
  
  网络组件：
  - $x_t$：当前时刻输入
  - $h_t$（或 $s_t$）：当前时刻隐藏状态
  - $o_t$：当前时刻输出
  - $W, U, V$：权重矩阵
  
  *计算公式推导*
  
  由于信息传递方向为从右向左，即：
  - 右侧输入 $x_t$ 和上一时刻隐藏状态 $h_{t-1}$（来自右侧）
  - 计算当前隐藏状态 $h_t$
  - 输出 $o_t$
  
  *隐藏状态计算*：
  $ h_t = tanh(U x_t + W h_{t-1} + b_h) $
  
  其中：
  - $U$：输入到隐藏层的权重矩阵
  - $W$：隐藏层到隐藏层（循环连接）的权重矩阵
  - $b_h$：隐藏层偏置
  - $tanh$：激活函数（常用tanh或ReLU）
  
  *输出层计算*：
  $ o_t = sigma(V h_t + b_o) $
  
  其中：
  - $V$：隐藏层到输出层的权重矩阵
  - $b_o$：输出层偏置
  - $sigma$：激活函数（分类任务常用softmax，回归可用线性激活）
  
  *注意*：若题目要求更简洁形式，可写为：
  $ o_t = g(V dot f(U x_t + W h_{t-1} + b_h) + b_o) $
  
  其中 $f$ 和 $g$ 分别为隐藏层和输出层的激活函数。
]
]


#example[第四次作业][设计卷积神经网络（输入 64×64 图像 → 输出：四元数 + 平移）\
*要点*：每层写出核大小、输出 feature map 大小、操作（padding/stride/pooling/激活/BatchNorm）以及最终全连接结构。
]
#solution[

#figure(
  caption: [卷积神经网络结构（示意）],
  {
    set text(size: 8pt)

    fig_9()
  }
)
]
#example[课程作业][
给定 8 个点的聚类题

点集：
- $A_1 (2,10)$, $A_2 (2,5)$, $A_3 (8,4)$, $B_1 (5,8)$, $B_2 (7,5)$, $B_3 (6,4)$, $C_1 (1,2)$, $C_2 (4,9)$

根据 K-means（k=3），初始中心为 $A_1$、$B_1$、$C_1$

1）求第一轮执行后的三个簇中心。
2）求最终三个簇（迭代直到收敛）及对应中心。
3）采用欧氏距离，单连接（single-link）法（每步合并最近的两簇），直到得到两个簇，给出合并步骤与树状图。
]

#solution[
1）第一轮执行后的三个簇中心

设初始中心为：$m_1 = A_1 (2,10)$，$m_2 = B_1 (5,8)$，$m_3 = C_1 (1,2)$。

根据欧氏距离最近原则分配样本点：
- *Cluster 1*: ${A_1}$
- *Cluster 2*: ${A_3, B_1, B_2, B_3, C_2}$
- *Cluster 3*: ${A_2, C_1}$

重新计算均值得到第一轮迭代后的簇中心：
- $m_1' = (2, 10)$
- $m_2' = ((8+5+7+6+4)/5, (4+8+5+4+9)/5) = (30/5, 30/5) = (6, 6)$
- $m_3' = ((2+1)/2, (5+2)/2) = (1.5, 3.5)$

第一轮后的三个簇中心为：$(2, 10)$，$(6, 6)$，$(1.5, 3.5)$。

2）最终收敛结果

经过 3 轮迭代后，样本点分配不再发生变化，算法收敛。最终的三个簇及中心为：
- *簇 1*: ${A_1, C_2, B_1}$，中心约为 $(3.67, 9.0)$
- *簇 2*: ${A_3, B_2, B_3}$，中心约为 $(7.0, 4.33)$
- *簇 3*: ${A_2, C_1}$，中心为 $(1.5, 3.5)$

#figure(
  caption: [K-means 最终聚类结果示意],
  {
    set text(size: 8pt)
    fig_10()
  }
)

2.2 层次聚类（单连接法）

单连接法采用两个簇中最近样本点之间的距离作为簇间距离：
$ D(C_i, C_j) = min_(x in C_i, y in C_j) d(x, y) $

详细合并步骤如下：

1. 合并最近的样本点 $A_3$ 与 $B_2$（距离 $d = sqrt(2) approx 1.41$），得到新簇 ${A_3, B_2}$；
2. 合并 $B_3$ 到上述簇（$d(B_3, B_2) = sqrt(2)$），得到新簇 ${A_3, B_2, B_3}$；
3. 合并 $B_1$ 与 $C_2$（距离 $d = sqrt(2) approx 1.41$），得到新簇 ${B_1, C_2}$；
4. 合并 $A_1$ 与 ${B_1, C_2}$（最近距离 $d(A_1, C_2) = sqrt(5) approx 2.24$），得到新簇 ${A_1, B_1, C_2}$；
5. 合并 $A_2$ 与 $C_1$（距离 $d = sqrt(10) approx 3.16$），得到新簇 ${A_2, C_1}$；
6. 合并 ${A_1, B_1, C_2}$ 与 ${A_3, B_2, B_3}$（最近距离 $d(B_1, B_2) = sqrt(13) approx 3.61$）。

此时活跃簇数量为 2，合并终止。

*最终得到的两个簇为：*
- *簇 1*: ${A_1, B_1, C_2, A_3, B_2, B_3}$
- *簇 2*: ${A_2, C_1}$

#figure(
  caption: [层次聚类树状图],
  {
    set text(size: 8pt)
    fig_11()
  }
)
]
#example[第四次作业][
  已知某地365天的气温信息，尝试构造LSTM 时间序列预测，用过去 7 天预测第 8 天的天气信息
]

#solution[
*实现思路*：

*数据预处理*
- 原始数据：365 天日平均气温（标量序列）。，缺失值处理：插值或前向填充。
- 归一化/标准化：例如用训练集均值和标准差做 z-score 或 MinMax 到 [0,1]。
- 构建样本：采用滑动窗口，窗口大小 T=7。每个样本 $x = [t_(i-6), ..., t_i]$= -> 目标 $y = t_(i+1)$。可得到 365-7 = 358 个样本。
- 训练/验证/测试（例如 70% / 15% / 15%）按时间顺序划分（防止信息泄露）。

*模型结构*
- 输入：形状 (T=7, feature=1)
- LSTM 层：LSTM(units=64, return_sequences=false)
- 可选 Dropout(0.2) 或 RecurrentDropout
- 全连接层：Dense(32, activation=ReLU)
- 输出层：Dense(1, activation=linear)

*损失与训练*
- 损失函数：均方误差（MSE）或平均绝对误差（MAE）。
- 优化器：Adam（lr=1e-3 起），带早停（early stopping）和 learning-rate decay。
- 批量大小：32 或 64；训练轮次：几十轮，依据验证集早停。

*后处理与评估*
- 将预测结果反归一化回真实温度尺度。
- 评估指标：MAE、RMSE、MAPE（视需求）。
#figure(
  caption: [LSTM 门控与数据流示意],
  {
    set text(size: 8pt)
    cetz.canvas({
      import cetz.draw: *

      // 左侧输入
      rect((-6.6, 0.7), (-5.2, 1.3), fill: rgb("#e3f2fd"), stroke: 0.8pt)
      content((-5.9, 1.0), [$x_t$])
      rect((-6.6, -0.1), (-5.2, 0.5), fill: rgb("#e3f2fd"), stroke: 0.8pt)
      content((-5.9, 0.2), [$h_(t-1)$])
      rect((-6.6, -0.9), (-5.2, -0.3), fill: rgb("#ffcdd2"), stroke: 0.8pt)
      content((-5.9, -0.6), [$c_(t-1)$])

      // 共享输入
      rect((-4.6, 0.55), (-3.0, 1.45), fill: rgb("#f5f5f5"), stroke: 0.8pt)
      content((-3.8, 1.0), [共享输入\n$[h_(t-1), x_t]$])
      line((-5.2, 1.0), (-4.6, 1.0), stroke: 0.9pt, mark: (end: ">"))
      line((-5.2, 0.2), (-4.6, 0.95), stroke: 0.9pt, mark: (end: ">"))

      // 四个门
      rect((-2.2, 1.15), (-0.8, 1.65), fill: rgb("#ffcdd2"), stroke: 0.8pt)
      content((-1.5, 1.4), [遗忘门\n$f_t$])
      rect((-2.2, 0.25), (-0.8, 0.75), fill: rgb("#c8e6c9"), stroke: 0.8pt)
      content((-1.5, 0.5), [输入门\n$i_t$])
      rect((-2.2, -0.65), (-0.8, -0.15), fill: rgb("#bbdefb"), stroke: 0.8pt)
      content((-1.5, -0.4), [候选记忆\n$tilde(c)_t$])
      rect((-2.2, -1.55), (-0.8, -1.05), fill: rgb("#fff9c4"), stroke: 0.8pt)
      content((-1.5, -1.3), [输出门\n$o_t$])

      line((-3.0, 1.0), (-2.2, 1.4), stroke: 0.8pt, mark: (end: ">"))
      line((-3.0, 1.0), (-2.2, 0.5), stroke: 0.8pt, mark: (end: ">"))
      line((-3.0, 1.0), (-2.2, -0.4), stroke: 0.8pt, mark: (end: ">"))
      line((-3.0, 1.0), (-2.2, -1.3), stroke: 0.8pt, mark: (end: ">"))

      // 记忆更新：c_t = f_t ⊙ c_{t-1} + i_t ⊙ c~_t
      line((-5.2, -0.6), (-4.0, -0.6), stroke: 2pt + rgb("#ef5350"), mark: (end: ">"))
      line((-0.8, 1.4), (0.4, 1.4), stroke: 0.9pt, mark: (end: ">"))
      rect((0.4, 1.1), (1.0, 1.7), fill: rgb("#ffffff"), stroke: 0.8pt)
      content((0.7, 1.4), [$dot$])
      content((0.7, 1.75), [保留])
      rect((1.4, 1.1), (2.2, 1.7), fill: rgb("#ffffff"), stroke: 0.8pt)
      content((1.8, 1.4), [$c_(t-1)$])
      line((1.0, 1.4), (1.4, 1.4), stroke: 0.9pt, mark: (end: ">"))

      line((-0.8, 0.5), (0.4, 0.5), stroke: 0.9pt, mark: (end: ">"))
      rect((0.4, 0.2), (1.0, 0.8), fill: rgb("#ffffff"), stroke: 0.8pt)
      content((0.7, 0.5), [$dot$])
      content((0.7, 0.9), [写入])
      rect((1.4, 0.2), (2.2, 0.8), fill: rgb("#ffffff"), stroke: 0.8pt)
      content((1.8, 0.5), [$tilde(c)_t$])
      line((1.0, 0.5), (1.4, 0.5), stroke: 0.9pt, mark: (end: ">"))

      rect((2.8, 0.45), (3.5, 1.05), fill: rgb("#fff3e0"), stroke: 0.9pt)
      content((3.15, 0.75), [$+$])
      line((2.2, 1.4), (2.8, 0.8), stroke: 0.9pt, mark: (end: ">"))
      line((2.2, 0.5), (2.8, 0.65), stroke: 0.9pt, mark: (end: ">"))
      rect((3.9, 0.45), (4.9, 1.05), fill: rgb("#fff3e0"), stroke: 0.9pt)
      content((4.4, 0.75), [$c_t$])
      line((3.5, 0.75), (3.9, 0.75), stroke: 0.9pt, mark: (end: ">"))

      // 输出：h_t = o_t ⊙ tanh(c_t)
      line((-0.8, -1.3), (3.9, -1.3), stroke: 0.9pt, mark: (end: ">"))
      rect((3.9, -1.6), (4.6, -1.0), fill: rgb("#fff9c4"), stroke: 0.9pt)
      content((4.25, -1.3), [$o_t$])
      rect((5.2, -1.6), (6.0, -1.0), fill: rgb("#e8f5e9"), stroke: 0.9pt)
      content((5.6, -1.3), [tanh])
      line((4.9, 0.75), (5.2, -1.0), stroke: 0.9pt, mark: (end: ">"))
      rect((6.6, -1.6), (7.2, -1.0), fill: rgb("#ffffff"), stroke: 0.9pt)
      content((6.9, -1.3), [$dot$])
      line((6.0, -1.3), (6.6, -1.3), stroke: 0.9pt, mark: (end: ">"))
      line((4.6, -1.3), (6.6, -1.3), stroke: 0.9pt)
      rect((7.6, -1.6), (8.6, -1.0), fill: rgb("#e8f5e9"), stroke: 0.9pt)
      content((8.1, -1.3), [$h_t$])
      line((7.2, -1.3), (7.6, -1.3), stroke: 0.9pt, mark: (end: ">"))

      // 后续预测头
      rect((9.2, -1.6), (10.5, -1.0), fill: rgb("#e3f2fd"), stroke: 0.9pt)
      content((9.85, -1.3), [Dense(32) -> 输出])
      line((8.6, -1.3), (9.2, -1.3), stroke: 0.9pt, mark: (end: ">"))
    })
  }
)
]
