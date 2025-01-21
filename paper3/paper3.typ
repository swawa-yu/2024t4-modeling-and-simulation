#import "./template.typ": *
#import "@preview/cetz:0.3.1"

#show: paper.with(
  paper-num: "3",
  title: "行列およびベクトルの積について",
  date-due: "2025年1月8日",
)

#let tp = $⊤$
// #let tp(matrix) = $matrix^⊤$
#let inner(v1, v2) = $angle.l v1, v2 angle.r$
#let xx = $vb(x)$
#let yy = $vb(y)$
#let zz = $vb(z)$
#let ee = $vb(e)$
#let ttheta = $vb(theta)$
#let θθ = $vb(theta)$
#let xxn = $mat(x_1; dots.v; x_n)$
#let yyn = $mat(y_1; dots.v; y_n)$
#let matA = $mat(a, b; c, d)$
#let matB = $mat(e, f; g, h)$
$
  x + y = e
  2x + 6y = f
$

= はじめに
$x=201, y=71$ として計算すると $e = 273, f=828$ である。$e,f$ を相手に教えた。

= 最小二乗法
システムに対して $x$ を与えると $y$ という値が得られるとする。$n$ 個のデータ、すなわち $x_1, dots, x_n$ とそれに対応する $y_1, dots, y_n$ があるとき、これらを材料にシステムの挙動を予測したい。システムを近似するモデルとして、2つの定数 $a,b$ で表される1次関数 $hat(y)=a x+b$ を考えてみる。いま、$a,b$ は自由に決めることができるが近似の良さはその取り方次第である。

モデルが良いモデルであるとは、もしくは、モデルがシステムを良く近似するとは、より具体的に言い換えるとどういうことだろうか。誤差という言葉を使えば、ざっくり「モデルとシステムの誤差が小さい」と言ってよいだろう。つまり、誤差を小さくするような $a, b$ を求めることが目標となる。データは複数あるので全体を加味して誤差を評価するのが妥当だろう。

誤差が正規分布に従う場合、「誤差がどれだけ小さいか」の評価には、誤差 $e=hat(y)-y$ の2乗和を指標にし、その最小化を目指すと良いことが知られている #footnote[詳しくは〜〜〜〜]。一般に、何かを最適化するとき、指標となるような関数を評価関数と呼び、judgeの頭文字を取ってよく $J$ で表す。今は $a,b$ に対する誤差の二乗和を指標とするので、評価関数 $J$ は次のようになる。
$
  J(a, b) := sum_(k=1)^n e_k^2 = sum_(k=1)^n (hat(y) - y_k)^2 = sum_(k=1)^n (a x_k + b - y_k)^2
$

さて、議論を簡単にするために行列を使った書き方に直しておこう。まず $n$ 個のデータ $x_1, ..., x_n$ をまとめて
$
  xx=mat(x_1; dots.v; x_n)
$
のように書く。また、$xx$ の成分をシステム、モデルに与えて得られるものについてもそれぞれ同様に、
$
  yy=mat(y_1; dots.v; y_n), hat(yy)=mat(a x_1+b; dots.v; a x_n+b)
$
とおく。さらに、
$
  ttheta=mat(a; b), X=mat(x_1, 1; dots.v, dots.v; x_n, 1)
$
とおくと $n$ 個の関係式 $y_k = a x_k +b #h(1em) (k=1,...,n)$ を 
$
  hat(yy)=X ttheta
$
と表すことができる。誤差についても同様に $ee=hat(yy)-yy$ と直す。すると上の式はこの $ee$ を用いて次のように表せる。
$
  ee = X ttheta - yy
$

したがって、最小二乗評価関数も次のように書き換えることができる。
$
  J(ttheta)=sum_(k=1)^n e_k^2 = ee^⊤ ee = (X ttheta - yy)^⊤ (X ttheta - yy)
$
「目標」も行列のことばで書き直せば「$J(ttheta)$ が最小となる $ttheta$ を求めること」になる。

== 仮に誤差がなければ
$yy = X ttheta$ が成り立っているということである。
$
  yy &= X\
  X^⊤ yy &= X^⊤ X ttheta\
  (X^⊤ X)^(-1) X^⊤ yy &= (X^⊤ X)^(-1)X^⊤ X ttheta\
  (X^⊤ X)^(-1) X^⊤ yy &= ttheta
$
$X^⊤ X$ が正則である($X^⊤ X$ に逆行列が存在する)ならば、
$
  ttheta = (X^⊤ X)^(-1) X^⊤ yy
$
と $ttheta$ を計算することができる。誤差が一切ない状況を考えているので $J(ttheta)=0$ である。

== 誤差がある場合
実は誤差がある場合も $θθ = (X^⊤ X)^(-1) X^⊤ yy$ のときに $J(θθ)$ は最小となる。この
$
  θθ_* = (X^⊤ X)^(-1) X^⊤ yy
$その理由は続く問題で説明する。
#problem()[
  任意の $ttheta$ について、以下を示せ。
  $
    (ttheta - ttheta_*)^⊤ X^⊤ X (ttheta - ttheta_*) >= 0
  $
]
#proof[
  $
     & (ttheta - ttheta_*)^⊤ X^⊤ X (ttheta - ttheta_*)\
    =& ((ttheta - ttheta_*)^⊤ X^⊤)(X (ttheta - ttheta_*))\
    =& (X(ttheta - ttheta_*))^⊤ (X (ttheta - ttheta_*)) >= 0\
  $
  ちなみに $ttheta=ttheta_*$ のとき、等号が成り立つことがわかる。
  
]

$ttheta_* = (X^⊤ X)^(-1) X^⊤ yy$ をもう少しだけ見やすくすると
$
  \
  X^⊤ X ttheta_* &= X^⊤ yy\
$
と書ける。(ほんとか？)


#problem()[
  $ttheta_* = (X^⊤ X)^(-1) X^⊤ yy$ とするとき、次を示せ。
  $
    J(ttheta) &= (X ttheta - yy)^⊤ (X ttheta - yy)\
              &= (ttheta - ttheta_*)^⊤ X^⊤ X (ttheta - ttheta_*) + yy^⊤ yy - yy^⊤ X (X^⊤ X)^(-1) X^⊤ yy
  $
]
#proof[
  まず $ttheta_*$ に関する式を整理しておく。$ ttheta_* = (X^⊤ X)^(-1) X^⊤ yy$ の両辺に左側から $X^⊤ X$ をかけて
  $
    X^⊤X ttheta_* = X^⊤ yy
  $また $ttheta_*$ の転置について、$(X^⊤ X)^(-1)$ が対称行列であることに注意すると
  $
    θθ_*^⊤ &= ((X^⊤ X)^(-1) X^⊤ yy)^⊤\
           &= yy^⊤ X ((X^⊤ X)^(-1))^⊤\
           &= yy^⊤ X (X^⊤ X)^(-1)
  $

  方針：$ttheta_* = (X^⊤ X)^(-1) X^⊤ yy$ であるから、$X^⊤X ttheta_*$ と $X^⊤ yy$ は置き換えることができる。$X θθ$ がベクトルであることと、ベクトルの内積には交換法則が成り立つことに注意して変形する。
  $(ttheta - ttheta_*)^⊤ X^⊤ X (ttheta - ttheta_*) + yy^⊤ yy - yy^⊤ (X^⊤ X)^(-1) yy$ の一部分だけ計算する。

  $
    J(ttheta) &= (X ttheta - yy)^⊤ (X ttheta - yy)\
              &= (X θθ)^⊤(X θθ) - (X θθ)^⊤ yy - yy^⊤(X θθ) + yy^⊤ yy\
              &= (X θθ)^⊤(X θθ) - 2(X θθ)^⊤ yy + yy^⊤ yy #h(3em) ("∵ベクトルの内積の交換法則")\
              &= (X θθ)^⊤(X θθ) - 2θθ^⊤ X^⊤ yy + yy^⊤ yy\
              &= (X θθ)^⊤(X θθ) - 2θθ^⊤ X^⊤ X θθ_* + yy^⊤ yy #h(4em) (∵X^⊤X ttheta_* = X^⊤ yy)\
              &= (X θθ)^⊤(X θθ) - 2(X θθ)^⊤ (X θθ_*) + yy^⊤ yy\
              // &= (X θθ)^⊤(X θθ) - 2θθ^⊤ X^⊤ yy + yy^⊤ yy\
              // &= (X θθ)^⊤(X θθ) - 2θθ^⊤ X^⊤X ttheta_* + yy^⊤ yy\
              // &= (ttheta - ttheta_*)^⊤ X^⊤ X (ttheta - ttheta_*) + yy^⊤ yy - yy^⊤ (X^⊤ X)^(-1) yy
  // $
  // 平方完成する($ttheta-ttheta_*$ の2乗の形を作る)。$(X θθ_*)^⊤(X θθ_*)$ を無理やり登場させて、
  // $
              &= {(X θθ)^⊤(X θθ) - 2(X θθ)^⊤ (X θθ_*) + (X θθ_*)^⊤(X θθ_*)} + yy^⊤ yy - (X θθ_*)^⊤(X θθ_*)\
              &= (X (θθ-θθ_*))^⊤ (X (θθ-θθ_*)) + yy^⊤ yy - (X θθ_*)^⊤(X θθ_*)\
              &= (θθ-θθ_*)^⊤ X^⊤ X (θθ-θθ_*) + yy^⊤ yy - θθ_*^⊤ X^⊤ X θθ_*\
              &= (θθ-θθ_*)^⊤ X^⊤ X (θθ-θθ_*) + yy^⊤ yy - (θθ_*^⊤)(X^⊤ X θθ_*)\
              &= (θθ-θθ_*)^⊤ X^⊤ X (θθ-θθ_*) + yy^⊤ yy - (yy^⊤ X (X^⊤ X)^(-1))(X^⊤ yy)\
              &= (θθ-θθ_*)^⊤ X^⊤ X (θθ-θθ_*) + yy^⊤ yy - yy^⊤ X (X^⊤ X)^(-1)X^⊤ yy\
              // &= (X θθ)^⊤(X θθ) - 2θθ^⊤ X^⊤ yy + yy^⊤ yy\
              // &= (X θθ)^⊤(X θθ) - 2θθ^⊤ X^⊤X ttheta_* + yy^⊤ yy\
              // &= (ttheta - ttheta_*)^⊤ X^⊤ X (ttheta - ttheta_*) + yy^⊤ yy - yy^⊤ (X^⊤ X)^(-1) yy
  $
  自分的にきれいな形で書くとこうなる。$J(ttheta)$ を $ttheta$ について平方完成すると $(X^⊤ X)^(-1) X^⊤ yy$ が出てくるのでそれを $ttheta_*$ と書くことにすると、
  $
    J(ttheta) = ||X (θθ-θθ_*)||^2 + ||yy||^2 - ||X θθ_*||^2
  $
  となる。$J(ttheta)$ は $ttheta = ttheta_*$ で最小になる。最小のとき、はじめの項が消えるということなので
  $
    J(ttheta_*) = ||ee||^2 = ||yy||^2 - ||X θθ_*||^2 = ||yy||^2 - ||hat(yy)_*||^2
  $三平方の定理の逆から、$yy, hat(yy)_*, ee$ は直角三角形をなすと言える。

  $
    J(ttheta) = ||X θθ - X θθ_*||^2 + ||yy||^2 - ||X θθ_*||^2\
    J(ttheta) := ||ee||^2 = ||hat(yy) - yy||^2\
    J(ttheta) = ||hat(yy) - hat(yy)_*||^2 + ||yy||^2 - ||hat(yy)_*||^2
  $


  $ttheta_* = (X^⊤ X)^(-1) X^⊤ yy$ とおくと、$ttheta_*$ は $X^⊤X ttheta_* = X^⊤ yy$ を満たす。
  $hat(yy)_* = $ とおく。つまり、$hat(yy)_*$ を $X^⊤ hat(yy)_* = X^⊤ yy$ を満たすように取るということである。(要解釈)


  // 下を展開すると
  // $
  //    & (ttheta - ttheta_*)^⊤ X^⊤ X (ttheta - ttheta_*)\
  //   =& (X θθ)^⊤(X θθ) - (X θθ)^⊤(X θθ_*) - (X θθ_*)^⊤(X θθ) + (X θθ_*)^⊤(X θθ_*)\
  //   =& (X θθ)^⊤(X θθ) -2(X θθ)^⊤(X θθ_*) + (X θθ_*)^⊤(X θθ_*)\
  //   =& (X θθ)^⊤(X θθ) -2θθ^⊤ X^⊤ X ttheta_* + θθ_*^⊤ X^⊤ X θθ_*\
  //   =& (X θθ)^⊤(X θθ) -2θθ^⊤ X^⊤ yy + θθ_*^⊤ X^⊤ yy\
  //   =& (X θθ)^⊤(X θθ) -2(X θθ)^⊤ yy + yy^⊤ X (X^⊤ X)^(-1) X^⊤ yy\
  //   // =& (X θθ)^⊤(X θθ) - 2(X θθ)^⊤(X θθ_*) + (X θθ_*)^⊤(X θθ_*)\
  //   // =& (X θθ)^⊤(X θθ) - 2(X θθ)^⊤(X θθ_*) + (X θθ_*)^⊤(X θθ_*)\
  //   // =& (ttheta - ttheta_*)^⊤ X^⊤ X (ttheta - ttheta_*) + yy^⊤ yy - yy^⊤ (X^⊤ X)^(-1) yy\
  //   // =& (ttheta - (X^⊤ X)^(-1) X^⊤ yy)^⊤ X^⊤ X (ttheta - (X^⊤ X)^(-1) X^⊤ yy)\
  // $


  // よって、上から下を引くと
  // $
  //    & J(ttheta) - (ttheta - ttheta_*)^⊤ X^⊤ X (ttheta - ttheta_*)\
  //   =& 2
  // $

]
== 最小二乗法の幾何学的解釈
$n$ 次元空間において
// cetzのサンプル
#align(center,
  cetz.canvas(
    length: 3cm, {
      import cetz.draw: *
        set-style(
          mark: (fill: black, scale: 1),
          stroke: (thickness: 0.4pt, cap: "round"),
          angle: (
            radius: 0.3,
            label-radius: .22,
            fill: green.lighten(80%),
            stroke: (paint: green.darken(50%))
          ),
          content: (padding: 5pt)
        )

        let p_0 = (x: 0, y: 0, z: 0)
        let p_yh = (x: 0.5, y: 0, z: 0.6)
        let p_y = (x: 0.5, y: 1, z: 0.6)

        line(p_0, (x: 1, y: 0, z: 0), name: "one", mark: (end: "stealth"))
        line(p_0, (x: 0.5, y: 1, z: 0.6), name: "y", mark: (end: "stealth"))
        line(p_0, (x: 0.5, y: 0, z: 0.6), name: "yhatstar", mark: (end: "stealth"))
        // line((x: 0.5, y: 0, z: 0.6), (x: 0.5, y: 1, z: 0.6), name: "e", mark: (end: "stealth"))
        line(p_y, p_yh, name: "e", mark: (end: "stealth"))
        line((0,0), (x: -0.5, z: 1), name: "x", mark: (end: "stealth"))
        // line((0,0), (x: 1, y: 1, z: 1), name: "xyz")

        content("one.end", $mat(1; dots.v; 1)$, anchor: "west")
        content("y.end", $yy$, anchor: "north")
        content("e.mid", $ee$, anchor: "west")
        content("yhatstar.end", $hat(y)_* = X θθ_*$, anchor: "south")
        content("x.end", $xx = mat(x_1; dots.v; x_n)$, anchor: "north")


    }
  )
)



== sandbox
$e = hat(y) - y$

$ee = hat(yy) - yy$

$theta = mat(a; b)$

$Y = mat(y_1; dots.v; y_n)$

$X = mat(x_1, 1; dots.v; x_n, 1)$

$Y=X theta$

良いモデルを与える変数 $a, b$ の組を $a_*, b_*$ と書くことにする。

誤差は $e=hat(y)-y$ で定義される。誤差の2乗和を最小にする $theta_* = mat(a_*; b_*)$ を求めたい。

$xx = mat(x_1; dots.v; x_n)$ とする。$xx$ の各成分それぞれに対して、モデルを適用した $yy=mat(y_1; dots.v; y_n) = mat(a x_1 + b; dots.v; a x_n + b) = mat(x_1, 1; dots.v; x_N, 1)mat(a; b)$ を考える。直線 $y=a x + b$ 上の点