#let book-color = (
  blue: (
    structure: rgb(60, 113, 183),
    main: rgb(0, 150, 136),      // 定义 (Teal)
    second: rgb(198, 40, 40),    // 定理 (Red)
    third: rgb(0, 174, 247),     // 性质 (Sky Blue)
    fourth: rgb(67, 160, 71),    // 例题 (Green)
    fifth: rgb(103, 58, 183),    // 笔记 (Purple)
    sixth: rgb(141, 110, 99),    // 解答 (Brown)
  ),
  green: (
    structure: rgb(0, 120, 2),
    main: rgb(0, 120, 2),
    second: rgb(230, 90, 7),
    third: rgb(0, 160, 152),
    fourth: rgb(128, 128, 0),
    fifth: rgb(160, 82, 45),
    sixth: rgb(158, 158, 158),
  ),
  cyan: (
    structure: rgb(31, 186, 190),
    main: rgb(59, 180, 5),
    second: rgb(175, 153, 8),
    third: rgb(244, 105, 102),
    fourth: rgb(0, 139, 139),
    fifth: rgb(218, 112, 214),
    sixth: rgb(158, 158, 158),
  ),
  gray: (
    structure: rgb(150, 150, 150),
    main: rgb(150, 150, 150),
    second: rgb(150, 150, 150),
    third: rgb(150, 150, 150),
    fourth: rgb(150, 150, 150),
    fifth: rgb(150, 150, 150),
    sixth: rgb(150, 150, 150),
  ),
  black: (
    structure: rgb(0, 0, 0),
    main: rgb(0, 0, 0),
    second: rgb(0, 0, 0),
    third: rgb(0, 0, 0),
    fourth: rgb(0, 0, 0),
    fifth: rgb(0, 0, 0),
    sixth: rgb(0, 0, 0),
  ),
)

#let color-select(color-theme) = {
  if type(color-theme) == str {
    assert(
      book-color.keys().any(it => it == color-theme),
      message: "请输入 \"blue\", \"green\", \"cyan\", \"gray\",\"black\", 其中一个颜色主题. "
        + "\""
        + color-theme
        + "\""
        + "不是其中之一.",
    )
    return book-color.at(color-theme)
  } else if type(color-theme) == dictionary {
    assert(
      color-theme.keys() == book-color.blue.keys(),
      message: "自定义颜色主题失败. 字典的 keys 必须分别为 structure, main, second, third",
    )
    assert(
      color-theme.values().all(it => type(it) == color),
      message: "自定义颜色主题失败. 字典的 value 类型必须为 color",
    )
    color-theme.keys()
  } else {
    assert(false, message: "请输入颜色主题名称,或自定义颜色主题")
  }
}
