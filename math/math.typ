#import "../util/color.typ": color-select
#import "../util/util.typ": dic-he-ma, dic-he-ma-update, f-numbering

// 颜色主题
#let color-themes = color-select("blue")

// 定理类环境-框架
#let math-fun-def-frame(main-color, title, content) = {
  v(1.2em)
  block(
    width: 100%,
    radius: 3pt,
    stroke: main-color,
    fill: main-color.lighten(95%),
    breakable: true,
    {
      place(
        top + left,
        dx: 2em,
        dy: -0.8em,
        block(
          stroke: none,
          fill: main-color,
          inset: 0.3em,
          outset: (x: 0.8em),
          text(fill: white, weight: "bold", bottom-edge: "descender")[#title],
        ),
      )
      pad(
        top: 1.5em,
        left: 1.2em,
        right: 1.2em,
        bottom: 1.2em,
        {
          set text(font: ("Times New Roman", "Kaiti SC"))
          content
        }
      )
    }
  )
}

// 提示类环境-框架 (比定理类更紧凑)
#let math-fun-note-frame(main-color, title, content) = {
  v(1em)
  block(
    width: 100%,
    radius: 2pt,
    stroke: main-color,
    fill: main-color.lighten(95%),
    breakable: true,
    {
      place(
        top + left,
        dx: 1.5em,
        dy: -0.65em,
        block(
          stroke: none,
          fill: main-color,
          inset: 0.25em,
          outset: (x: 0.6em),
          text(fill: white, weight: "bold", size: 0.9em, bottom-edge: "descender")[#title],
        ),
      )
      pad(
        top: 1.2em,
        left: 0.8em,
        right: 0.8em,
        bottom: 0.8em,
        {
          set text(font: ("Times New Roman", "Kaiti SC"))
          content
        }
      )
    }
  )
}

// 定理类环境
#let math-fun-def(main-color: rgb(0, 0, 0), kind: "", number: true, name, content) = {
  if number { dic-he-ma-update(kind) }
  let title = kind + if number { f-numbering(kind) } + name
  math-fun-def-frame(main-color, title, content)
}

// 示例类环境
#let math-fun-exam-box(
  main-color: rgb(0, 0, 0),
  number: true,
  kind: "",
  custom-title: "",
  body,
) = {
  if number { dic-he-ma-update(kind) }
  let title = kind + if number { " " + f-numbering(kind) } else { "" }
  let display-title = if custom-title != "" { title + " " + custom-title } else { title }

  math-fun-note-frame(
    main-color,
    display-title,
    pad(left: 1em)[
      #set text(font: ("Times New Roman", "Kaiti SC"))
      #body
    ],
  )
}

#let math-fun-exam(main-color: rgb(0, 0, 0), number: true, kind: "") = {
  if number { dic-he-ma-update(kind) }
  let title = kind + " " + if number { f-numbering(kind) }
  text(fill: main-color, weight: "bold", font: ("Times New Roman", "PingFang SC"))[#title] + " "
}

// 提示类环境 (方框模式)
#let math-fun-note(
  main-color: rgb(0, 0, 0),
  font: ("Times New Roman", "Songti SC"),
  kind,
  body,
) = {
  math-fun-note-frame(
    main-color,
    kind,
    pad(left: 1em)[
      #set text(font: font)
      #body
    ],
  )
}
