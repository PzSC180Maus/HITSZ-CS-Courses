// datastructure 所有 fletcher 图表
// 从 datastructure.typ 中提取

#import "@preview/fletcher:0.5.5" as fletcher: diagram, node, edge
#import fletcher.shapes: diamond, circle

// 满二叉树示例
#let full-binary-tree() = diagram(
    node-stroke: 1pt,
    spacing: 2em,
    node((0,0), [A], name: <a>),
    node((-1,1), [B], name: <b>),
    node((1,1), [C], name: <c>),
    node((-1.5,2), [D], name: <d>),
    node((-0.5,2), [E], name: <e>),
    node((0.5,2), [F], name: <f>),
    node((1.5,2), [G], name: <g>),

    edge(<a>, <b>),
    edge(<a>, <c>),
    edge(<b>, <d>),
    edge(<b>, <e>),
    edge(<c>, <f>),
    edge(<c>, <g>),
  )

// 完全二叉树的层序编号
#let complete-binary-tree() = diagram(
    node-stroke: 1pt,
    spacing: 2em,
    node((0,0), [1（A）], name: <a>),
    node((-1,1), [2（B）], name: <b>),
    node((1,1), [3（C）], name: <c>),
    node((-1.5,2), [4（D）], name: <d>),
    node((-0.5,2), [5（E）], name: <e>),
    node((0.5,2), [6（F）], name: <f>),
    node((1.5,2), [7（G）], name: <g>),

    edge(<a>, <b>),
    edge(<a>, <c>),
    edge(<b>, <d>),
    edge(<b>, <e>),
    edge(<c>, <f>),
    edge(<c>, <g>),
  )

// Huffman树示例（权值：A:8, B:3, C:1, D:2）
#let huffman-tree() = diagram(
    node-stroke: 1pt,
    spacing: 2em,
    node((0,0), [14], name: <root>),
    node((-1,1), [6], name: <n6>),
    node((1,1), [8\ A], name: <a>, extrude: (0, 2pt)),
    node((-1.5,2), [3], name: <n3>),
    node((-0.5,2), [3\ B], name: <b>, extrude: (0, 2pt)),
    node((-2,3), [1\ C], name: <c>, extrude: (0, 2pt)),
    node((-1,3), [2\ D], name: <d>, extrude: (0, 2pt)),

    edge(<root>, <n6>),
    edge(<root>, <a>),
    edge(<n6>, <n3>),
    edge(<n6>, <b>),
    edge(<n3>, <c>),
    edge(<n3>, <d>),
  )

// 无向图示例
#let undirected-graph-example() = diagram(
    node-stroke: 1pt,
    spacing: 2em,
    node((0,0), [1], name: <v1>),
    node((2,0), [2], name: <v2>),
    node((4,0), [3], name: <v3>),
    node((1,1.5), [4], name: <v4>),
    node((3,1.5), [5], name: <v5>),

    edge(<v1>, <v2>),
    edge(<v2>, <v3>),
    edge(<v1>, <v4>),
    edge(<v2>, <v4>),
    edge(<v2>, <v5>),
    edge(<v3>, <v5>),
    edge(<v4>, <v5>),
  )

// 带权无向图示例
#let weighted-graph-example() = diagram(
    node-stroke: 1pt,
    spacing: 2em,
    node((0,0), [A], name: <a>),
    node((2,0), [B], name: <b>),
    node((4,0), [C], name: <c>),
    node((1,1.5), [D], name: <d>),
    node((3,1.5), [E], name: <e>),

    edge(<a>, <b>, [4]),
    edge(<b>, <c>, [2]),
    edge(<a>, <d>, [1]),
    edge(<b>, <d>, [3]),
    edge(<b>, <e>, [5]),
    edge(<c>, <e>, [6]),
    edge(<d>, <e>, [2]),
  )

// BST示例
#let bst-example() = diagram(
    node-stroke: 1pt,
    spacing: 2em,
    node((0,0), [50], name: <root>),
    node((-1,1), [30], name: <l1>),
    node((1,1), [70], name: <r1>),
    node((-1.5,2), [20], name: <l2>),
    node((-0.5,2), [40], name: <l3>),
    node((0.5,2), [60], name: <r2>),
    node((1.5,2), [80], name: <r3>),

    edge(<root>, <l1>),
    edge(<root>, <r1>),
    edge(<l1>, <l2>),
    edge(<l1>, <l3>),
    edge(<r1>, <r2>),
    edge(<r1>, <r3>),
  )
