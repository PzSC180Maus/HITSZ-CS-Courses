#import "math.typ": math-fun-note, math-fun-note-frame, color-themes

// 提示类环境
#let note(..args) = {
  let pos = args.pos()
  let (title, body) = if pos.len() == 1 {
    ("笔记", pos.at(0))
  } else if pos.len() >= 2 {
    ("笔记 " + pos.at(0), pos.at(1))
  } else {
    ("笔记", none)
  }
  math-fun-note(main-color: color-themes.fifth, title, font: ("Times New Roman", "Kaiti SC"), body)
}

// 结论类环境
#let conclusion(..args) = {
  let pos = args.pos()
  let (title, body) = if pos.len() == 1 {
    ("结论", pos.at(0))
  } else if pos.len() >= 2 {
    ("结论 " + pos.at(0), pos.at(1))
  } else {
    ("结论", none)
  }
  math-fun-note(
    main-color: color-themes.third,
    font: ("Times New Roman", "Kaiti SC"),
    title,
    body,
  )
}

#let assumption(..args) = {
  let pos = args.pos()
  let (title, body) = if pos.len() == 1 {
    ("假设", pos.at(0))
  } else if pos.len() >= 2 {
    ("假设 " + pos.at(0), pos.at(1))
  } else {
    ("假设", none)
  }
  math-fun-note(
    main-color: color-themes.third,
    font: ("Times New Roman", "Kaiti SC"),
    title,
    body,
  )
}
#let property(..args) = {
  let pos = args.pos()
  let title = none
  let body = none
  if pos.len() >= 2 {
    title = pos.at(0)
    body = pos.at(1)
  } else if pos.len() == 1 {
    body = pos.at(0)
  }
  
  let label = if title != none {
    "性质 (" + title + ")"
  } else {
    "性质"
  }
  
  math-fun-note-frame(
    color-themes.third, // 蓝色调 (在 blue 主题中 third 是天蓝色)
    label,
    body,
  )
}
#let remark(body) = math-fun-note(main-color: color-themes.fifth, font: ("Times New Roman", "Kaiti SC"), "注", body)
#let solution(body) = math-fun-note(main-color: color-themes.sixth, font: ("Times New Roman", "Kaiti SC"), "解", body)

//
#let proof(body) = math-fun-note(
  main-color: color-themes.sixth,
  font: ("Times New Roman", "STFangsong"),
  "证明",
  body,
)
