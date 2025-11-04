#let jarticle(
  fontsize: 11pt,
  title: none,
  authors: (),
  abstract: [],
  date: none,
  doc,
) = {
  let roman = "Libertinus Serif"
  let mincho = "YuMincho"
  let kakugothic = "YuGothic"
  let math_font = "New Computer Modern Math"
  set text(lang:"ja", font: (roman,mincho), size: fontsize)
  // Use A4 paper
  set page(
    paper: "a4",
    margin: auto,
    numbering: "1",
    number-align: center,
  )
  set cite(style: "ieee")
  set par(justify: true)
  // 行間の調整
  set par(
    leading: 0.8em,
    justify: true,
    first-line-indent: 1.0em,
  )
  set par(spacing: 0.8em)
  show heading: set block(above: 1.6em, below: 0.6em)
  set heading(numbering: "1.1     ")
  // 様々な場所でのフォント
  show heading: set text(font: kakugothic)
  show strong: set text(font: kakugothic)
  show emph: set text(font: (roman, kakugothic))
  show math.equation: set text(font: (math_font,roman,mincho)) 
  // 見出しの下の段落を字下げするため
  show heading: it => {
    it
    par(text(size: 0pt, ""))
  }
  // 数式番号
  set math.equation(numbering: "(1)")
  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el != none and el.func() == eq {
      // Override equation references.
      link(
        el.label,
        numbering(
          el.numbering,
          ..counter(eq).at(el.location())
        )
      )
    } else {
      // Other references as usual.
      it
    }
  }
  // 目次
  show outline.entry.where(
    level: 1
  ): it => {
    v(1.2*fontsize, weak: true)
    it
  }
  set outline(indent: auto)
  
  // 図と表のキャプション設定（共通）
  show figure.where(kind:image): set figure(gap: 1.6em)
  show figure.where(kind:image): set block(above: 3em, below: 2em)
  show figure.where(kind:table): set figure(gap: 0em)
  show figure.where(kind:table): set block(above: 2em, below: 3em)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption: it => [
    #block(width: 90%, [#it])
    #v(1em)
  ]
  show figure.caption: set text(
    font: kakugothic, 
    size: 0.9 * fontsize
  )
  show figure.caption: set align(center)

  
  // タイトル
  {
    set align(center)
    text(1.5*fontsize, font: kakugothic, strong(title))
    par(for a in authors {a})
    par(date)
    if abstract != [] {
      block(width: 90%, text(0.9*fontsize, [
        *概要* \ 
        #align(left, abstract)
      ]))
    }
  }
  doc
}

// 図用の関数
#let fig(
  content,
  caption: none,
  label: none,
  placement: none
) = {
  figure(
    content,
    caption: caption,
    kind: image,
    supplement: [図],
    placement: placement
  )
  label
}

// 表用の関数
#let tbl(
  content,
  caption: none,
  label: none,
  placement: none,
) = {
  figure(
    content,
    caption: caption,
    kind: table,
    supplement: [表],
    placement: placement
  )
  label
}

#let appendix(app) = [
  #counter(heading).update(0)
  #set heading(numbering: "A.1     ")
  #app
]

#let 年月日 = "[year]年[month repr:numerical padding:none]月[day padding:none]日"
#let 年月 = "[year]年[month repr:numerical padding:none]月"
