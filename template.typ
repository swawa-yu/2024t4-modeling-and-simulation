
#import "@preview/physica:0.9.4": *
#import "@preview/ctheorems:1.1.3": *

#let paper(
  body,
  paper-num: 2,
  title: "{タイトル}",
  cource: "モデリングとシミュレーション",
  term: "2024年度4ターム",
  date-due: "{提出期限}",
  date-submit: (datetime.today().year(), datetime.today().month(), datetime.today().day()),
  author-name: "長田 麗生",
  author-id: "B220052",
  author-department: "教育学部 第二類 技術・情報系コース 3年",
  teacher: "田中秀幸",

  date: (datetime.today().year(), datetime.today().month(), datetime.today().day()),
) = {
  import "@preview/physica:0.9.4": *
  import "@preview/ctheorems:1.1.3": *

  set page(paper: "a4", margin: 12%)
  set par(leading: 0.55em, first-line-indent: 0em, justify: true)
  set text(
    font:(
      // "Times New Roman",
      "Hiragino Mincho ProN"
    ),
    size:12pt
  )
  set heading(numbering: "1.")
  show heading: set block(above: 1.8em, below: 1em)
  set page(numbering: "1 / 1")

  show link: underline
  show link: set text(fill: rgb("#125ee0"))

  show: thmrules.with()

  align(center,[
    #text(size: 16pt)[
      #term「#cource」\
    ]

    #text(size: 16pt)[
      レポートその#paper-num
    ]

    #text(size: 20pt)[
      #title
    ]

    #author-department\
    #author-id #author-name

    提出期限：#date-due\
    提出日：#date-submit.at(0)年#date-submit.at(1)月#date-submit.at(2)日

    担当教員：#teacher 先生
  ])
  body
}

#let definition = thmbox(
  "definition",
  "定義",
  stroke: rgb("#000000") + 1pt
)

#let problem = thmbox(
  "problem",
  "問題",
  stroke: rgb("#000000") + 1pt,
)

#let theorem = thmbox(
  "theorem",
  "定理",
  fill: rgb("#eeeeee")
)

#let proof = thmproof("proof", "証明")