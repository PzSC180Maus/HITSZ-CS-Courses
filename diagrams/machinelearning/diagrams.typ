// machinelearning - fletcher diagram functions

#import "@preview/fletcher:0.5.5" as fletcher: diagram, node, edge, shapes
#import "@preview/cetz:0.3.4"

// Diagram 1
#let fig_1() = {
  fletcher.diagram(
      node-stroke: 0.7pt,
      node-fill: white,
      spacing: (1.0cm, 0.7cm),
      node((0, 0), [最一般假设\ $<?,?,?,?,?>$], shape: rect, fill: rgb("#e3f2fd")),
      node((-1.5, 1), [$"<Sunny,?,?,?,?>"$], shape: rect),
      node((0, 1), [$"<?,Warm,?,?,?>"$], shape: rect),
      node((1.5, 1), [$<?,?,?,?,?>$\ (其他)], shape: rect),
      node((0, 2), [中间层次\ 假设], shape: rect, fill: rgb("#fff3e0")),
      node((0, 3), [最特殊假设\ $<∅,∅,∅,∅,∅>$], shape: rect, fill: rgb("#ffebee")),
      edge((0, 0), (-1.5, 1), "->"),
      edge((0, 0), (0, 1), "->"),
      edge((0, 0), (1.5, 1), "->"),
      edge((-1.5, 1), (0, 2), "->"),
      edge((0, 1), (0, 2), "->"),
      edge((1.5, 1), (0, 2), "->"),
      edge((0, 2), (0, 3), "->"),
    )
}

// Diagram 2
#let fig_2() = {
  fletcher.diagram(
      node-stroke: 0.7pt,
      node-fill: white,
      spacing: (1.5cm, 0.8cm),
      node((0, 0), [初始化$h$为最特殊假设\ $h = <∅,∅,∅,∅,∅>$], shape: rect, fill: rgb("#e8f5e9")),
      node((0, 1), [对每个正例$x$], shape: rect, fill: rgb("#fff3e0")),
      node((0, 2), [对$h$中每个属性约束$a_i$], shape: rect, fill: rgb("#fff3e0")),
      node((0, 3), [如果$x$满足$a_i$], shape: shapes.diamond, fill: rgb("#e3f2fd")),
      node((-1.5, 4), [不做任何操作], shape: rect),
      node((1.5, 4), [将$a_i$替换为\ 满足$x$的更一般约束], shape: rect, fill: rgb("#ffebee")),
      node((0, 5), [输出假设$h$], shape: rect, fill: rgb("#e8f5e9")),
      edge((0, 0), (0, 1), "->"),
      edge((0, 1), (0, 2), "->"),
      edge((0, 2), (0, 3), "->"),
      edge((0, 3), (-1.5, 4), "->", label: [是]),
      edge((0, 3), (1.5, 4), "->", label: [否]),
      edge((-1.5, 4), (0, 5), "->"),
      edge((1.5, 4), (0, 5), "->"),
    )
}

// Diagram 3
#let fig_3() = {
  fletcher.diagram(
      node-stroke: 0.7pt,
      node-fill: white,
      spacing: (1.5cm, 0.7cm),
      node((0, 0), [最一般假设], shape: rect, fill: rgb("#e3f2fd")),
      node((0, 0.8), [$G$边界\ (一般边界)], shape: rect, fill: rgb("#bbdefb")),
      node((0, 2), [变型空间\ $"VS"_(H,D)$], shape: rect, fill: rgb("#fff3e0")),
      node((0, 3.2), [$S$边界\ (特殊边界)], shape: rect, fill: rgb("#ffcdd2")),
      node((0, 4), [最特殊假设], shape: rect, fill: rgb("#ffebee")),
      edge((0, 0), (0, 0.8), "--"),
      edge((0, 0.8), (0, 2), "->"),
      edge((0, 2), (0, 3.2), "->"),
      edge((0, 3.2), (0, 4), "--"),
    )
}

// Diagram 4
#let fig_4() = {
  fletcher.diagram(
      node-stroke: 0.7pt,
      node-fill: white,
      spacing: (1.2cm, 0.9cm),
      node((0, 0), [Outlook?], shape: shapes.circle, fill: rgb("#e3f2fd")),
      node((-2.5, 1.5), [Sunny], shape: rect, fill: rgb("#fff3e0")),
      node((0, 1.5), [Overcast], shape: rect, fill: rgb("#e8f5e9")),
      node((2.5, 1.5), [Rain], shape: rect, fill: rgb("#fff3e0")),
      node((-2.5, 2.5), [Humidity?], shape: shapes.circle, fill: rgb("#e3f2fd")),
      node((0, 2.5), [Play=Yes], shape: rect, fill: rgb("#c8e6c9")),
      node((2.5, 2.5), [Wind?], shape: shapes.circle, fill: rgb("#e3f2fd")),
      node((-3.5, 3.5), [High], shape: rect, fill: rgb("#ffebee")),
      node((-1.5, 3.5), [Normal], shape: rect, fill: rgb("#c8e6c9")),
      node((1.5, 3.5), [Strong], shape: rect, fill: rgb("#ffebee")),
      node((3.5, 3.5), [Weak], shape: rect, fill: rgb("#c8e6c9")),
      node((-3.5, 4.5), [Play=No], shape: rect, fill: rgb("#ffcdd2")),
      node((-1.5, 4.5), [Play=Yes], shape: rect, fill: rgb("#c8e6c9")),
      node((1.5, 4.5), [Play=No], shape: rect, fill: rgb("#ffcdd2")),
      node((3.5, 4.5), [Play=Yes], shape: rect, fill: rgb("#c8e6c9")),
      edge((0, 0), (-2.5, 1.5), "->", label: [Sunny]),
      edge((0, 0), (0, 1.5), "->", label: [Overcast]),
      edge((0, 0), (2.5, 1.5), "->", label: [Rain]),
      edge((-2.5, 1.5), (-2.5, 2.5), "->"),
      edge((2.5, 1.5), (2.5, 2.5), "->"),
      edge((-2.5, 2.5), (-3.5, 3.5), "->", label: [High]),
      edge((-2.5, 2.5), (-1.5, 3.5), "->", label: [Normal]),
      edge((2.5, 2.5), (1.5, 3.5), "->", label: [Strong]),
      edge((2.5, 2.5), (3.5, 3.5), "->", label: [Weak]),
      edge((-3.5, 3.5), (-3.5, 4.5), "->"),
      edge((-1.5, 3.5), (-1.5, 4.5), "->"),
      edge((1.5, 3.5), (1.5, 4.5), "->"),
      edge((3.5, 3.5), (3.5, 4.5), "->"),
    )
}

// Diagram 5
#let fig_5() = {
  fletcher.diagram(
      node-stroke: 0.7pt,
      node-fill: white,
      spacing: (0.2cm, 0.3cm),
      node((0, 0), [ID3(样例集$S$, 属性集$"Attributes"$)], shape: rect, fill: rgb("#e3f2fd")),
      node((0, 1), [$S$中所有样例\ 属于同一类别$C$?], shape: shapes.diamond, fill: rgb("#fff3e0")),
      node((-2, 2), [返回叶节点\ 标记为$C$], shape: rect, fill: rgb("#c8e6c9")),
      node((2, 2), [$"Attributes"$为空?], shape: shapes.diamond, fill: rgb("#fff3e0")),
      node((0, 3), [返回叶节点\ 标记为$S$中\ 多数类别], shape: rect, fill: rgb("#c8e6c9")),
      node((4, 3), [选择信息增益\ 最大的属性$A$], shape: rect, fill: rgb("#e3f2fd")),
      node((4, 4), [对$A$的每个可能值$v_i$], shape: rect, fill: rgb("#fff3e0")),
      node((4, 5), [令$S_i$为$A=v_i$的样例子集], shape: rect),
      node((4, 6), [$S_i$为空?], shape: shapes.diamond, fill: rgb("#fff3e0")),
      node((2, 7), [添加叶节点\ 标记为$S$多数类], shape: rect, fill: rgb("#c8e6c9")),
      node((6, 7), [添加子树\ ID3($S_i$, $"Attributes" \\ {A}$)], shape: rect, fill: rgb("#bbdefb")),
      edge((0, 0), (0, 1), "->"),
      edge((0, 1), (-2, 2), "->", label: [是]),
      edge((0, 1), (2, 2), "->", label: [否]),
      edge((2, 2), (0, 3), "->", label: [是]),
      edge((2, 2), (4, 3), "->", label: [否]),
      edge((4, 3), (4, 4), "->"),
      edge((4, 4), (4, 5), "->"),
      edge((4, 5), (4, 6), "->"),
      edge((4, 6), (2, 7), "->", label: [是]),
      edge((4, 6), (6, 7), "->", label: [否]),
    )
}

// Diagram 6
#let fig_6() = {
  diagram(
      node-stroke: .5pt,
      node-fill: rgb("fafafa"),
      spacing: (15mm, 8mm),
      
      node((0,0), [初始化种群], corner-radius: 2pt),
      edge("-|>"),
      node((0,1), [计算路径长度 $L(X_i)$ \ 并转化为适应度 $f(X_i)$], corner-radius: 2pt),
      edge("-|>"),
      node((0,2), [执行轮盘赌选择 \ 筛选出优秀亲代个体], corner-radius: 2pt),
      edge("-|>"),
      node((0,3), [交叉与变异操作 \ (生成新一代种群)], corner-radius: 2pt),
      edge("-|>"),
      node((0,4), [是否满足终止条件? \ (如达到最大迭代次数)], corner-radius: 2pt),
      
      // 循环返回与结束
      edge((0,4), (0,1), "-|>", label: [ 否 ], bend: 50deg),
      edge((0,4), (0,5), "-|>"),
      node((0,5), [输出最优路径与距离], corner-radius: 2pt, fill: rgb("e2f0d9"))
    )
}

// Diagram 7
#let fig_7() = {
  fletcher.diagram(
      node-stroke: 0.7pt,
      node-fill: white,
      spacing: (1.0cm, 0.6cm),
      node((0, 0), [L2正则化], shape: rect, fill: rgb("#e3f2fd")),
      node((3, 0), [L1正则化], shape: rect, fill: rgb("#e8f5e9")),
      node((0, 1), [权重趋向小值\ 但不为零], shape: rect),
      node((3, 1), [产生稀疏解\ 部分权重为零], shape: rect),
      node((0, 2), [保留所有特征], shape: rect, fill: rgb("#fff3e0")),
      node((3, 2), [自动特征选择], shape: rect, fill: rgb("#c8e6c9")),
      edge((0, 0), (0, 1), "->"),
      edge((3, 0), (3, 1), "->"),
      edge((0, 1), (0, 2), "->"),
      edge((3, 1), (3, 2), "->"),
    )
}

// Diagram 8
#let fig_8() = {
  fletcher.diagram(
      node-stroke: 0.7pt,
      node-fill: white,
      spacing: (1.2cm, 0.7cm),
      node((0, 0), [随机选择$k$个样本\ 作为初始质心], shape: rect, fill: rgb("#e3f2fd")),
      node((0, 1), [对每个样本，\ 计算到各质心的距离], shape: rect, fill: rgb("#fff3e0")),
      node((0, 2), [将样本分配到\ 最近的质心所在簇], shape: rect, fill: rgb("#fff3e0")),
      node((0, 3), [重新计算\ 每个簇的质心], shape: rect, fill: rgb("#fff3e0")),
      node((0, 4), [质心是否变化?], shape: shapes.diamond, fill: rgb("#e8f5e9")),
      node((2.5, 4), [结束], shape: rect, fill: rgb("#c8e6c9")),
      node((0, 5), [返回步骤2], shape: rect, fill: rgb("#bbdefb")),
      edge((0, 0), (0, 1), "->"),
      edge((0, 1), (0, 2), "->"),
      edge((0, 2), (0, 3), "->"),
      edge((0, 3), (0, 4), "->"),
      edge((0, 4), (2.5, 4), "->", label: [否]),
      edge((0, 4), (0, 5), "->", label: [是]),
      edge((0, 5), (0, 1), "->"),
    )
}

// Diagram 9
#let fig_9() = {
  fletcher.diagram(
      spacing: (0.6cm, 0.2cm),
      node-stroke: 0.6pt,
      node-fill: white,

      // 网络结构
      node((0, 0), [
        Input(64×64×3)
      ], shape: rect, fill: rgb("#e3f2fd")),

      node((0, 1), [
        Conv1(3×3, pad=1, stride=1)
        #linebreak()
        out:64×64×32
        #linebreak()
        ReLU + BN
      ], shape: rect),

      node((0, 2), [
        MaxPool(2×2, stride=2)
        #linebreak()
        out:32×32×32
      ], shape: rect, fill: rgb("#fff3e0")),

      node((0, 3), [
        Conv2(3×3, pad=1, stride=1)
        #linebreak()
        out:32×32×64
        #linebreak()
        ReLU + BN
      ], shape: rect),

      node((0, 4), [
        MaxPool(2×2, stride=2)
        #linebreak()
        out:16×16×64
      ], shape: rect, fill: rgb("#fff3e0")),

      node((0, 5), [
        Conv3(3×3, pad=1, stride=1)
        #linebreak()
        out:16×16×128
        #linebreak()
        ReLU + BN
      ], shape: rect),

      node((0, 6), [
        MaxPool(2×2, stride=2)
        #linebreak()
        out:8×8×128
      ], shape: rect, fill: rgb("#fff3e0")),

      node((0, 7), [
        Conv4(3×3, pad=1, stride=1)
        #linebreak()
        out:8×8×256
        #linebreak()
        ReLU + BN
      ], shape: rect),

      node((0, 8), [
        MaxPool(2×2, stride=2)
        #linebreak()
        out:4×4×256
      ], shape: rect, fill: rgb("#fff3e0")),

      node((0, 9), [
        Flatten
        #linebreak()
        4×4×256 = 4096
      ], shape: rect),

      node((0, 10), [
        FC(4096 → 512)
        #linebreak()
        ReLU + Dropout(0.5)
      ], shape: rect, fill: rgb("#e8f5e9")),

      node((0, 11), [
        FC(512 → 128)
        #linebreak()
        ReLU
      ], shape: rect),

      node((0, 12), [
        Output Layer
        #linebreak()
        FC 128 → 7
        #linebreak()
        (四元数 4 + 平移 3)
      ], shape: rect, fill: rgb("#ffcdd2")),
      // 连线
      edge((0,0), (0,1), "->"),
      edge((0,1), (0,2), "->"),
      edge((0,2), (0,3), "->"),
      edge((0,3), (0,4), "->"),
      edge((0,4), (0,5), "->"),
      edge((0,5), (0,6), "->"),
      edge((0,6), (0,7), "->"),
      edge((0,7), (0,8), "->"),
      edge((0,8), (0,9), "->"),
      edge((0,9), (0,10), "->"),
      edge((0,10), (0,11), "->"),
      edge((0,11), (0,12), "->"),
    )
}

// Diagram 10
#let fig_10() = {
  fletcher.diagram(
      spacing: (0.4cm, 0.3cm),
      node-stroke: 0.6pt,
      node-fill: white,
      node((2, 10), [A1], shape: circle, fill: rgb("#2196f3")),
      node((2, 5), [A2], shape: circle, fill: rgb("#ffc107")),
      node((8, 4), [A3], shape: circle, fill: rgb("#f44336")),
      node((5, 8), [B1], shape: circle, fill: rgb("#2196f3")),
      node((7, 5), [B2], shape: circle, fill: rgb("#f44336")),
      node((6, 4), [B3], shape: circle, fill: rgb("#f44336")),
      node((1, 2), [C1], shape: circle, fill: rgb("#ffc107")),
      node((4, 9), [C2], shape: circle, fill: rgb("#2196f3")),
      node((3.67, 9.0), [#text(size:4pt)[Center1]], shape: rect, fill: rgb("#90caf9")),
      node((7.0, 4.33), [#text(size:4pt)[Center2]], shape: rect, fill: rgb("#ef9a9a")),
      node((1.5, 3.5), [#text(size:4pt)[Center3]], shape: rect, fill: rgb("#ffe082")),
    )
}

// Diagram 11
#let fig_11() = {
  fletcher.diagram(
      spacing: (0.3cm, 0.6cm),
      node-stroke: 0.6pt,
      node-fill: white,
      node((0, 0), [A1], shape: rect),
      node((1, 0), [C2], shape: rect),
      node((2, 0), [B1], shape: rect),
      node((3, 0), [B2], shape: rect),
      node((4, 0), [B3], shape: rect),
      node((5, 0), [A3], shape: rect),
      node((6, 0), [A2], shape: rect),
      node((7, 0), [C1], shape: rect),
      node((2, -1), [C2 (B1,C2,A1)], shape: rect, fill: rgb("#90caf9")),
      node((3.5, -1), [C1 (A3,B2,B3)], shape: rect, fill: rgb("#ef9a9a")),
      node((6.5, -1), [C3 (A2,C1)], shape: rect, fill: rgb("#ffe082")),
      node((3, -2.2), [Final Cluster 1\n{A3,B2,B3,B1,C2,A1}], shape: rect, fill: rgb("#b3e5fc")),
      node((6.5, -2.2), [Final Cluster 2\n{A2,C1}], shape: rect, fill: rgb("#fff9c4")),
      edge((2, 0), (2, -1), "->"),
      edge((1, 0), (2, -1), "->"),
      edge((0, 0), (2, -1), "->"),
      edge((5, 0), (3.5, -1), "->"),
      edge((4, 0), (3.5, -1), "->"),
      edge((3, 0), (3.5, -1), "->"),
      edge((6, 0), (6.5, -1), "->"),
      edge((7, 0), (6.5, -1), "->"),
      edge((2, -1), (3, -2.2), "->"),
      edge((3.5, -1), (3, -2.2), "->"),
      edge((6.5, -1), (6.5, -2.2), "->"),
    )
}

