#import "math.typ": math-fun-exam, math-fun-exam-box, color-themes

// 示例类环境
#let example(number: true, ..args) = {
  let pos = args.pos()
  let (custom-title, body) = if pos.len() == 1 {
    ("", pos.at(0))
  } else if pos.len() >= 2 {
    (pos.at(0), pos.at(1))
  } else {
    ("", none)
  }

  math-fun-exam-box(
    main-color: color-themes.fourth,
    number: number,
    kind: "例",
    custom-title: custom-title,
    body,
  )
}

#let problem(number: true, ..args) = {
  let pos = args.pos()
  let (custom-title, body) = if pos.len() == 1 {
    ("", pos.at(0))
  } else if pos.len() >= 2 {
    (pos.at(0), pos.at(1))
  } else {
    ("", none)
  }

  math-fun-exam-box(
    main-color: color-themes.fourth,
    number: number,
    kind: "例题",
    custom-title: custom-title,
    body,
  )
}

#let exercise(number: true, ..args) = {
  let pos = args.pos()
  let (custom-title, body) = if pos.len() == 1 {
    ("", pos.at(0))
  } else if pos.len() >= 2 {
    (pos.at(0), pos.at(1))
  } else {
    ("", none)
  }

  math-fun-exam-box(
    main-color: color-themes.fourth,
    number: number,
    kind: "练习",
    custom-title: custom-title,
    body,
  )
}
  body
}

#let exam(number: false, ..args) = {
  let pos = args.pos()
  let (custom-title, body) = if pos.len() == 1 {
    ("", pos.at(0))
  } else if pos.len() >= 2 {
    (pos.at(0), pos.at(1))
  } else {
    ("", none)
  }

  math-fun-exam-box(
    main-color: color-themes.second,
    number: number,
    kind: "考题",
    custom-title: custom-title,
    body,
  )
}

#let choices(..args) = {
  let pos = args.pos()
  let letters = ("A", "B", "C", "D", "E", "F")
  v(0.2em)
  layout(size => {
    context {
      let items = pos.enumerate().map(((i, it)) => {
        let letter = letters.at(i, default: str(i))
        [*#letter.* #it]
      })
      let widths = items.map(it => measure(it).width)
      let max-w = if widths.len() > 0 {
        calc.max(..widths)
      } else {
        0pt
      }

      let n-cols = if items.len() >= 4 and max-w < size.width * 0.25 - 18pt {
        4
      } else if items.len() >= 2 and max-w < size.width * 0.5 - 18pt {
        2
      } else {
        1
      }
      grid(
        columns: (1fr,) * n-cols,
        row-gutter: 0.6em,
        ..items,
      )
    }
  })
}
