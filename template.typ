
#import "@preview/physica:0.9.4": *
#import "@preview/ctheorems:1.1.3": *

#let paper(body) = {
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

  show: thmrules.with()

  []
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