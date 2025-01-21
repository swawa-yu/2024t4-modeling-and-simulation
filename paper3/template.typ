
#import "@preview/physica:0.9.4": *
#import "@preview/ctheorems:1.1.3": *
#import "@preview/codelst:2.0.2": sourcecode

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
  set page(paper: "a4", margin: 12%)
  // set par(leading: 1em, first-line-indent: 0em, justify: true)
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

  //図のラベルを置き換える
  show figure.where(kind:image): set figure(supplement: "図")
  //表のラベルを置き換える
  show figure.where(kind:table): set figure(supplement: "表")
  //ソースコードのラベルを書き換える
  show figure.where(kind: raw): set figure(supplement: "コード")
  //その他の参照の設定
  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el != none and el.func() == eq {
      // 数式の参照を書き換える．
      link(el.location())[
        #set text(fill:text.fill)
        #numbering(
        el.numbering,
        ..counter(eq).at(el.location())
      )]
    }
    else if el != none and el.func() == footnote {
      link(el.location())[
        //footnoteの参照を書き換える
        #set text(fill:text.fill)
        脚注#numbering(el.numbering,..counter(footnote).at(el.location()))]
    } else if el != none and el.func() == heading{
      //headingの参照を書き換える.
      link(el.location())[
        #set text(fill:text.fill)
        第#numbering(el.numbering,..counter(heading).at(el.location()))節]
    } else {it}
  }

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