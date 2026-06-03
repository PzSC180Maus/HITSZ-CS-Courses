// automachine - fletcher diagram functions

#import "@preview/fletcher:0.5.5" as fletcher: diagram, node, edge
#import "@preview/cetz:0.3.4"
#import fletcher.shapes: diamond

// Diagram 1
#let fig_1() = {
  diagram(
      node-stroke: 1pt,
      spacing: 3em,
      node((0,0), $q_0$, name: <q0>),
      node((1,0), $q_1$, name: <q1>),
      node((2,0), $q_2$, name: <q2>, extrude: (0, 2pt)),
      
      edge(<q0>, <q0>, $0, 1$, "->", bend: 130deg),
      edge(<q0>, <q1>, $0$, "->"),
      edge(<q1>, <q2>, $1$, "->"),
      edge((-0.6,0), <q0>, "->"),
    )
}

// Diagram 2
#let fig_2() = {
  diagram(
      node-stroke: 1pt,
      spacing: 3em,
      node((0,0), $q_0$, name: <q0>),
      node((1,0), $q_1$, name: <q1>),
      node((2,0), $q_2$, name: <q2>, extrude: (0, 2pt)),
      
      edge(<q0>, <q0>, $1$, "->", bend: 130deg),
      edge(<q0>, <q1>, $0$, "->"),
      edge(<q1>, <q1>, $0$, "->", bend: -130deg),
      edge(<q1>, <q2>, $1$, "->"),
      edge(<q2>, <q1>, $0$, "->", bend: 40deg),
      edge(<q2>, <q0>, $1$, "->", bend: -40deg),
      edge((-0.6,0), <q0>, "->"),
    )
}

// Diagram 3
#let fig_3() = {
  diagram(
      node-stroke: 1pt,
      spacing: 2em,
      node((0,1.5), $q_0$, name: <q0>),
      node((1,0.5), $q_a$, name: <qa>),
      node((1,2.5), $q_b$, name: <qb>),
      node((2,0), $q_(a a)$, name: <qaa>),
      node((2,1), $q_(a b)$, name: <qab>),
      node((2,2), $q_(b a)$, name: <qba>),
      node((2,3), $q_(b b)$, name: <qbb>),
      node((3,1.5), $q_F$, name: <qf>, extrude: (0, 2pt)),
      
      edge(<q0>, <q0>, $a, b$, "->", bend: 130deg),
      edge(<q0>, <qa>, $a$, "->"),
      edge(<q0>, <qb>, $b$, "->"),
      
      edge(<qa>, <qaa>, $a$, "->"),
      edge(<qa>, <qab>, $b$, "->"),
      edge(<qb>, <qba>, $a$, "->"),
      edge(<qb>, <qbb>, $b$, "->"),
      
      edge(<qaa>, <qf>, $a$, "->"),
      edge(<qab>, <qf>, $b$, "->"),
      edge(<qba>, <qf>, $b$, "->"),
      edge(<qbb>, <qf>, $a$, "->"),
      
      edge((-0.6,1.5), <q0>, "->"),
    )
}

// Diagram 4
#let fig_4() = {
  diagram(
      node-stroke: 1pt,
      spacing: 3em,
      node((0,0), $q_0$, name: <q0>),
      node((1,0), $q_1$, name: <q1>),
      node((2,0), $q_2$, name: <q2>),
      node((3,0), $q_3$, name: <q3>, extrude: (0, 2pt)),
      
      edge(<q0>, <q0>, $0, 1$, "->", bend: 120deg),
      edge(<q0>, <q1>, $1$, "->"),
      edge(<q1>, <q2>, $0, 1, epsilon$, "->"),
      edge(<q2>, <q3>, $0, 1, epsilon$, "->"),
      edge((-0.8,0), <q0>, "->"),
    )
}

// Diagram 5
#let fig_5() = {
  diagram(
      node-stroke: 1pt,
      spacing: 4em,
      node((0,0), $A$, name: <a>),
      node((1,0), $B$, name: <b>, extrude: (0, 2pt)),
      node((2,0), $C$, name: <c>, extrude: (0, 2pt)),
      node((1,1), $D$, name: <d>, extrude: (0, 2pt)),
      
      edge((-0.6,0), <a>, "->"),
      edge(<a>, <a>, $0$, "->", bend: 130deg),
      edge(<a>, <b>, $1$, "->"),
      edge(<b>, <b>, $1$, "->", bend: 130deg),
      edge(<b>, <c>, $0$, "->"),
      edge(<c>, <b>, $1$, "->", bend: -40deg),
      edge(<c>, <d>, $0$, "->"),
      edge(<d>, <a>, $0$, "->", bend: 40deg),
      edge(<d>, <b>, $1$, "->", bend: 20deg),
    )
}

// Diagram 6
#let fig_6() = {
  diagram(
      node-stroke: 1pt,
      spacing: 3em,
      node((0,0), $q_0$, name: <q0>),
      node((1,0), $q_1$, name: <q1>),
      node((2,1), $q_2$, name: <q2>),
      node((3,0), $q_3$, name: <q3>),
      node((4,0), $q_4$, name: <q4>, extrude: (0, 2pt)),
      
      edge((-0.9,0), <q0>, "->",[start]),
      edge(<q0>, <q1>, $a,b,epsilon$, "->"),
      edge(<q1>, <q2>, $a$, "->", bend: -20deg),
      edge(<q1>, <q3>, $a$, "->"),
      edge(<q2>, <q2>, $a,b$, "->", bend: -130deg),
      edge(<q2>, <q3>, $a$, "->", bend: -20deg),
      edge(<q3>, <q4>, $a,b,epsilon$, "->"),
    )
}

// Diagram 7
#let fig_7() = {
  diagram(
      node-stroke: 1pt,
      spacing: 3em,
      node((0,0), $D_0$, name: <q0d>),
      node((0,1), $D_B$, name: <qbd>),
      node((1,1.5), $"Dead"$, name: <dead>),
      node((1,0), $D_A$, name: <dad>, extrude: (0, 2pt)),
      node((2,0.5), $D_C$, name: <dcd>, extrude: (0, 2pt)),
      node((2,-0.5), $D_D$, name: <ddd>),
      
      edge((-0.6,0), <q0d>, "->"),
      edge(<q0d>, <dad>, $a$, "->"),
      edge(<q0d>, <qbd>, $b$, "->", bend: -15deg),
      
      edge(<qbd>, <dad>, $a$, "->", bend: 15deg),
      edge(<qbd>, <dead>, $b$, "->"),
      edge(<dead>, <dead>, $a,b$, "->", bend: 130deg),
      
      edge(<dad>, <dad>, $a$, "->", bend: 130deg),
      edge(<dad>, <dcd>, $b$, "->", bend: 15deg),
      
      edge(<dcd>, <dad>, $a$, "->", bend: 15deg),
      edge(<dcd>, <ddd>, $b$, "->"),
      
      edge(<ddd>, <dad>, $a$, "->"),
      edge(<ddd>, <ddd>, $b$, "->", bend: 130deg),
    )
}

// Diagram 8
#let fig_8() = {
  diagram(
      node-stroke: 1pt,
      spacing: 4em,
      node((0,0), $q_0$, name: <q0>),
      node((1,0), $q_1$, name: <q1>),
      node((2,0), $q_2$, name: <q2>, extrude: (0, 2pt)),
      
      edge((-0.6,0), <q0>, "->"),
      edge(<q0>, <q0>, $0, Z_0 \/ 0 Z_0 \ 0, 0 \/ 0 0$, "->", bend: 130deg),
      edge(<q0>, <q1>, $1, 0 \/ epsilon$, "->"),
      edge(<q1>, <q1>, $1, 0 \/ epsilon$, "->", bend: -130deg),
      edge(<q1>, <q2>, $epsilon, Z_0 \/ Z_0$, "->"),
    )
}

// Diagram 9
#let fig_9() = {
  diagram(
      node-stroke: 1pt,
      spacing: 4em,
      node((0,0), $q_0$, name: <q0>),
      node((1,0), $q_1$, name: <q1>),
      node((2,0), $q_2$, name: <q2>),
      node((3,0), $q_3$, name: <q3>),
      node((4,0), $q_f$, name: <qf>, extrude: (0, 2pt)),
      
      edge((-0.6,0), <q0>, "->"),
      edge(<q0>, <q1>, $0, Z_0 \/ X Z_0$, "->"),
      edge(<q1>, <q2>, $0, X \/ X X$, "->"),
      edge(<q2>, <q2>, $0, X \/ X X$, "->", bend: 130deg),
      edge(<q2>, <q3>, $1, X \/ epsilon$, "->"),
      edge(<q3>, <q3>, $1, X \/ epsilon$, "->", bend: 130deg),
      edge(<q3>, <qf>, $epsilon, Z_0 \/ Z_0$, "->"),
    )
}

// Diagram 10
#let fig_10() = {
  diagram(
        node-stroke: 1pt,
        spacing: 4em,
        node((0,0), $q_0$, name: <q0>),
        node((3,0), $q$, name: <q>),
        node((6,0), $q_f$, name: <qf>, extrude: (0, 2pt)),
        
        edge((-0.8,0), <q0>, "->"),
        // 初始化：压入 S
        edge(<q0>, <q>, $epsilon, Z_0 \/ S Z_0$, "->"),
        
        // q 状态循环：展开推导
        edge(<q>, <q>, 
          $epsilon, S \/ a S a; epsilon, S \/ b S b; epsilon, S \/ a A b; epsilon, S \/ b A a \ 
           epsilon, A \/ a A; epsilon, A \/ b A; epsilon, A \/ epsilon \
           a, a \/ epsilon; b, b \/ epsilon$, "->", 
          bend: 130deg, label-pos: 0.5),

        // 结束：栈中仅回退到原始 Z_0
        edge(<q>, <qf>, $epsilon, Z_0 \/ Z_0$, "->"),
      )
}

// Diagram 11
#let fig_11() = {
  diagram(
      node-stroke: 1pt,
      spacing: 4em,
      node((0,0), $q$, name: <q>),
      node((2,0), $p$, name: <p>),
      
      edge((-0.6,0), <q>, "->"),
      
      // 压栈 a 转移
      edge(<q>, <q>, 
        $a, Z_0 \/ X Z_0, X X Z_0 \ a, X \/ X X, X X X$, 
        "->", bend: 130deg, label-pos: 0.5),
        
      // 弹栈 b (1:1) 及 清空
      edge(<q>, <q>, 
        $b, X \/ epsilon \ epsilon, Z_0 \/ epsilon$, 
        "->", bend: -130deg, label-pos: 0.5),

      // 弹栈 b (1:2) 辅助路径
      edge(<q>, <p>, $b, X \/ epsilon$, "->", bend: 25deg),
      edge(<p>, <q>, $epsilon, X \/ epsilon$, "->", bend: 25deg),
    )
}

// Diagram 12
#let fig_12() = {
  diagram(
      node-stroke: 1pt,
      spacing: 3em,
      node((0,0), $q_0$, name: <q0>),
      node((1,0), $q_1$, name: <q1>),
      node((3,0), $q_2$, name: <q2>),
      node((5,0), $q_f$, name: <qf>, extrude: (0, 2pt)),
      
      edge((-0.6,0), <q0>, "->"),
      edge(<q0>, <q1>, $a, Z_0 \/ Z_0; a, X \/ X$, "->", bend: 20deg),
      edge(<q1>, <q0>, $a, Z_0 \/ X Z_0; a, X \/ X X$, "->", bend: 20deg),
      edge(<q0>, <q2>, $b, X \/ epsilon$, "->",bend:-60deg),
      edge(<q2>, <q2>, $b, X \/ epsilon$, "->", bend: 130deg),
      edge(<q2>, <qf>, $epsilon, Z_0 \/ Z_0$, "->"),
    )
}

// Diagram 13
#let fig_13() = {
  diagram(
        node-stroke: 1pt,
        spacing: 6em,
        node((0,0), $q_0$, radius: 1.5em, name: <q0>),
        node((1,-1), $q_1$, radius: 1.5em, name: <q1>),
        node((2,0), $q_6$, radius: 1.5em, name: <q6>),
        node((2,-1), $q_2$, radius: 1.5em, name: <q2>),
        node((2,1), $q_3$, radius: 1.5em, name: <q3>),
        node((0,1), $q_4$, radius: 1.5em, name: <q4>),
        node((1,1), $q_5$, radius: 1.5em, name: <q5>, extrude: (0, 3pt)),

        // Start arrow
        edge((-0.8,0), <q0>, "->",[start]),

        // q0 -> q1
        edge(<q0>, <q1>, [$0 \/ X, R$], "->"),
        
        // q1 loop (skipping first 0s)
        edge(<q1>, <q1>, [$0 \/ 0, R$], "->", bend: 130deg),
        
        // q1 -> q2 (direct match 1 if no Y yet)
        edge(<q1>, <q2>, [$1 \/ Y, L$], "->"),

        // q1 -> q6 (hit Y block)
        edge(<q1>, <q6>, [$Y \/ Y, R$], "->"),
        
        // q6 loop (skipping Ys)
        edge(<q6>, <q6>, [$Y \/ Y, R$], "->", bend: -130deg, loop-angle: 180deg),

        // q6 -> q2 (found 1 in phase 1)
        edge(<q6>, <q2>, [$1 \/ Y, L$], "->"),

        // q6 -> q3 (no more 1s, found 0 in phase 2)
        edge(<q6>, <q3>, [$0 \/ Z, L$], "->"),
        
        // q2 loop (moving back to X)
        edge(<q2>, <q2>, [$0 \/ 0, L$, $1 \/ 1, L$, $Y \/ Y, L$], "->", bend: 130deg, loop-angle: 0deg),
        
        // q2 -> q0 (back to start)
        edge(<q2>, <q0>, [$X \/ X, R$], "->", bend: 10deg,label-pos:0.6),
        
        // q3 -> q3 (moving back)
        edge(<q3>, <q3>, [$Z \/ Z, L$, $Y \/ Y, L$], "->", bend: 130deg,loop-angle: 0deg),
        
        // q3 -> q0 (back to start)
        edge(<q3>, <q0>, [$X \/ X, R$], "->", bend: -10deg,label-pos: 0.7),
        
        // q0 -> q4 (checking end)
        edge(<q0>, <q4>, [$Y \/ Y, R$], "->"),
        
        // q4 loop (checking remaining)
        edge(<q4>, <q4>, [$Y \/ Y, R$, $Z \/ Z, R$], "->", bend: -130deg,loop-angle: 0deg,label-angle: 90deg),
        
        // q4 -> q5 (accept)
        edge(<q4>, <q5>, [$B \/ B, R$], "->"),
      )
}

// Diagram 14
#let fig_14() = {
  diagram(
        node-stroke: 1pt,
        spacing: 6em,
        node((0,0), $q_0$, radius: 1.5em, name: <q0>),
        node((1,-1), $q_1$, radius: 1.5em, name: <q1>),
        node((2,-1), $q_2$, radius: 1.5em, name: <q2>),
        node((0,1), $q_3$, radius: 1.5em, name: <q3>),
        node((1,1), $q_4$, radius: 1.5em, name: <q4>),
        node((2,1), $q_5$, radius: 1.5em, name: <q5>),
        node((-1, 0), $q_("acc")$, radius: 1.5em, name: <qacc>, extrude: (0, 3pt)),

        edge((-0.6,0), <q0>, "->",[start]),
        edge(<q0>, <q1>, [$1 \/ X, R$], "->"),
        edge(<q1>, <q1>, [$1 \/ 1, R$, $0 \/ 0, R$, $X \/ X, R$], "->", bend: 130deg),
        edge(<q1>, <q2>, [$1 \/ X, L$], "->"),
        edge(<q2>, <q2>, [$1 \/ 1, L$, $0 \/ 0, L$, $X \/ X, L$], "->", bend: 130deg, loop-angle: 0deg),
        edge(<q2>, <q0>, [$X \/ X, R$], "->", bend: 30deg),
        
        edge(<q0>, <q3>, [$0 \/ 0, R$, $X \/ X, R$], "->"),
        edge(<q3>, <q3>, [$Y \/ Y, R$], "->", bend: -130deg),
        edge(<q3>, <q4>, [$0 \/ Y, R$], "->"),
        edge(<q4>, <q4>, [$0 \/ 0, R$, $X \/ X, R$, $Y \/ Y, R$], "->", bend: 130deg),
        edge(<q4>, <q5>, [$0 \/ Y, L$], "->"),
        edge(<q5>, <q5>, [$0 \/ 0, L$, $X \/ X, L$, $Y \/ Y, L$], "->", bend: 130deg, loop-angle: 0deg),
        edge(<q5>, <q3>, [$Y \/ Y, R$], "->", bend: 40deg),
        
        edge(<q3>, <qacc>, [$B \/ B, R$], "->",label-pos: 0.1),
      )
}

// 图灵机状态转换图（识别 0^n 1^n）
#let fig_15() = diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      node((0,0), $q_0$, radius: 20pt, name: <q0>),
      node((3,0), $q_1$, radius: 20pt, name: <q1>),
      node((1.5,1.5), $q_2$, radius: 20pt, name: <q2>),
      node((0,1.5), $q_3$, radius: 20pt, name: <q3>),
      node((0,3), $q_4$, radius: 20pt, name: <q4>),
      node((0,3), "", radius: 17pt, name: <q4_inner>),

      node((-1.5, 0), "Start", stroke: none, name: <start>),
      edge(<start>, <q0>, "->"),

      edge(<q0>, <q1>, "->", label: [0 / X, R], bend: 15deg),
      edge(<q1>, <q1>, "->", label: [0 / 0, R \ Y / Y, R], bend: 130deg,loop-angle: 0deg),
      edge(<q1>, <q2>, "->", label: [1 / Y, L], bend: 15deg),
      edge(<q2>, <q2>, "->", label: [0 / 0, L \ Y / Y, L], bend: -130deg),
      edge(<q2>, <q0>, "->", label: [X / X, R], bend: 0deg),

      edge(<q0>, <q3>, "->", label: [Y / Y, R]),
      edge(<q3>, <q3>, "->", label: [Y / Y, R], bend: 130deg,loop-angle: 180deg),
      edge(<q3>, <q4>, "->", label: [B / B, R])
    )

