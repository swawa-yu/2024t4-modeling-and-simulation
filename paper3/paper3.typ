#import "./template.typ": *
#import "@preview/cetz:0.3.1"
#import cetz.draw: *

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
#let oone = $vb(1)$
#let ttheta = $vb(theta)$
#let θθ = $vb(theta)$
#let xxn = $mat(x_1; dots.v; x_n)$
#let yyn = $mat(y_1; dots.v; y_n)$
#let matA = $mat(a, b; c, d)$
#let matB = $mat(e, f; g, h)$
$
  x + y = e\
  2x + 6y = f
$
#let Col = $"Col"$

= はじめに
$x=201, y=71$ として計算すると $e = 273, f=828$ である。$e,f$ を相手に教えた。

= 最小二乗法
システムに対して $x$ を与えると $y$ という値が得られるとする。$n$ 個のデータ、すなわち $x_1, dots, x_n$ とそれに対応する $y_1, dots, y_n$ があるとき、これらを材料にシステムの挙動を予測したい。システムを近似するモデルとして、2つの定数 $a,b$ で表される1次関数 $hat(y)=a x+b$ を考えてみる。いま、$a,b$ は自由に決めることができるが近似の良さはその取り方次第である。

モデルが良いモデルであるとは、もしくは、モデルがシステムを良く近似するとは、より具体的に言い換えるとどういうことだろうか。誤差という言葉を使えば、ざっくり「モデルとシステムの誤差が小さい」と言ってよいだろう。つまり、誤差を小さくするような $a, b$ を求めることが目標となる。データは複数あるので全体を加味して誤差を評価するのが妥当だろう。

誤差が正規分布に従う場合、「誤差がどれだけ小さいか」の評価には、誤差 $e=hat(y)-y$ の2乗和を指標にし、その最小化を目指すと良いことが知られている #footnote[参考：https://oroshi.me/2021/01/lsm]。一般に、何かを最適化するとき、指標となるような関数を評価関数と呼び、judgeの頭文字を取ってよく $J$ で表す。今は $a,b$ に対する誤差の二乗和を指標とするので、評価関数 $J$ は次のようになる。
$
  J(a, b) = sum_(k=1)^n e_k^2 = sum_(k=1)^n (hat(y) - y_k)^2 = sum_(k=1)^n (a x_k + b - y_k)^2
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

== 仮に誤差がなければ<noerror>
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
実は誤差がある場合も $θθ = (X^⊤ X)^(-1) X^⊤ yy$ のときに $J(θθ)$ は最小となる。このときの $θθ$ を特別に $θθ_*$ と書くことにする。つまり、
$
  θθ_* := (X^⊤ X)^(-1) X^⊤ yy
$

誤差があっても $θθ=θθ_*$ のときに $J(θ)$ が最小となることを、続く問題と解答で説明する。
#problem()[
  任意の $ttheta$ について、以下を示せ。
  $
    (ttheta - ttheta_*)^⊤ X^⊤ X (ttheta - ttheta_*) >= 0
  $
]
#proof[
  $X(θθ-θθ_*)$ がベクトルであるため、単に $X(θθ-θθ_*)$ のノルムを表す式である。
  $
     & (ttheta - ttheta_*)^⊤ X^⊤ X (ttheta - ttheta_*)\
    =& ((ttheta - ttheta_*)^⊤ X^⊤)(X (ttheta - ttheta_*))\
    =& (X(ttheta - ttheta_*))^⊤ (X (ttheta - ttheta_*))\
    =& ||X (ttheta - ttheta_*)||^2 >= 0
  $
  ちなみに $ttheta=ttheta_*$ のとき、$X(θθ-θθ_*)=mat(0;dots.v;0)$ であるから等号が成り立つ。
]


#problem()[
  次の等式を示せ。
  $
    J(ttheta) = (ttheta - ttheta_*)^⊤ X^⊤ X (ttheta - ttheta_*) + yy^⊤ yy - yy^⊤ X (X^⊤ X)^(-1) X^⊤ yy
  $
]
#proof[
  まず $ttheta_*$ に関する式を整理しておく。$ ttheta_* = (X^⊤ X)^(-1) X^⊤ yy$ の両辺に左側から $X^⊤ X$ をかけて
  $
    X^⊤X ttheta_* = X^⊤ yy
  $
  を得る。また $ttheta_*$ の転置について、$(X^⊤ X)^(-1)$ が対称行列であることに注意すると
  $
    θθ_*^⊤ &= ((X^⊤ X)^(-1) X^⊤ yy)^⊤\
           &= yy^⊤ X ((X^⊤ X)^(-1))^⊤\
           &= yy^⊤ X (X^⊤ X)^(-1)
  $
  となる。これらを使って $J(ttheta) = ee^⊤ ee = (X ttheta - yy)^⊤ (X ttheta - yy)$ を展開した式を整理する。

  $
    J(ttheta) &= (X ttheta - yy)^⊤ (X ttheta - yy)\
              &= (X θθ)^⊤(X θθ) - (X θθ)^⊤ yy - yy^⊤(X θθ) + yy^⊤ yy\
              &= (X θθ)^⊤(X θθ) - 2(X θθ)^⊤ yy + yy^⊤ yy #h(3em) ("∵ベクトルの内積の交換法則")\
              &= (X θθ)^⊤(X θθ) - 2θθ^⊤ X^⊤ yy + yy^⊤ yy\
              &= (X θθ)^⊤(X θθ) - 2θθ^⊤ X^⊤ X θθ_* + yy^⊤ yy #h(4em) (∵X^⊤X ttheta_* = X^⊤ yy)\
              &= (X θθ)^⊤(X θθ) - 2(X θθ)^⊤ (X θθ_*) + yy^⊤ yy\
              &= {(X θθ)^⊤(X θθ) - 2(X θθ)^⊤ (X θθ_*) + (X θθ_*)^⊤(X θθ_*)} + yy^⊤ yy - (X θθ_*)^⊤(X θθ_*)\
              &= (X (θθ-θθ_*))^⊤ (X (θθ-θθ_*)) + yy^⊤ yy - (X θθ_*)^⊤(X θθ_*)\
              &= (θθ-θθ_*)^⊤ X^⊤ X (θθ-θθ_*) + yy^⊤ yy - θθ_*^⊤ X^⊤ X θθ_*\
              &= (θθ-θθ_*)^⊤ X^⊤ X (θθ-θθ_*) + yy^⊤ yy - (θθ_*^⊤)(X^⊤ X θθ_*)\
              &= (θθ-θθ_*)^⊤ X^⊤ X (θθ-θθ_*) + yy^⊤ yy - (yy^⊤ X (X^⊤ X)^(-1))(X^⊤ yy)\
              &= (θθ-θθ_*)^⊤ X^⊤ X (θθ-θθ_*) + yy^⊤ yy - yy^⊤ X (X^⊤ X)^(-1)X^⊤ yy
  $
]
この等式を自分の思うきれいな形で書くと
$
  J(ttheta) &= ||X (θθ-θθ_*)||^2 + ||yy||^2 - ||X θθ_*||^2\
            &= ||hat(yy) - hat(yy)_*||^2 + ||yy||^2 - ||hat(yy)_*||^2
$
となる。$J(ttheta)$ は $ttheta = ttheta_*$ で最小になる。そのとき、はじめの項が消えるということなので
$
  J(ttheta_*) = ||ee||^2 &= ||yy||^2 - ||X θθ_*||^2\
                         &= ||yy||^2 - ||hat(yy)_*||^2
$三平方の定理の逆から、$yy, hat(yy)_*, ee$ は直角三角形をなすと言える。
// $
//   J(ttheta) = ||ee||^2 &= ||hat(yy) - yy||^2\
//                        &= ||hat(yy)||^2 + ||yy||^2 - 2hat(yy)^⊤ yy\
//   J(ttheta) &= ||hat(yy) - hat(yy)_*||^2 + ||yy||^2 - ||hat(yy)_*||^2\
//             &= ||hat(yy)||^2 + ||hat(yy)_*||^2 - 2hat(yy)_*^⊤ hat(yy) + ||yy||^2 - ||hat(yy)_*||^2
// $

== 最小二乗法の幾何学的解釈
次のように $n$ 次元空間の絵を書いてみる。3次元っぽい表現しかできないが、都合の良いことにこれで十分説明がつく。この絵は見やすさのために $xx, vb(1)$ がなす平面が「水平」になるように書いている。さて、ベクトル $xx, yy, vb(1), ee, hat(yy)$ の関係を見てみよう。

#let p_x = (x: -0.5, y: 0, z: 1)
#let p_1 = (x: 2, y: 0, z: 0)
#let p_0 = (x: 0, y: 0, z: 0)
#let p_y = (x: 0.6, y: 1.5, z: 0.5)
#let p_yh = (x: 1.7, y: 0, z: 0.7)
#let p_yhs = (x: 0.6, y: 0, z: 0.5)

#align(center,
  cetz.canvas(length: 3cm, {
    set-style(
      mark: (fill: black, scale: 1, end: "stealth"),
      stroke: (thickness: 0.4pt, cap: "round"),
      angle: (
        radius: 0.3,
        label-radius: .22,
        fill: green.lighten(80%),
        stroke: (paint: green.darken(50%))
      ),
      content: (padding: 5pt)
    )

    line(p_0, p_x, name: "x")
    line(p_0, p_y, name: "y",)
    line(p_0, p_1, name: "one")
    line(p_0, p_yh, name: "yhat")
    line(p_y, p_yh, name: "e")
    line(p_0, p_yhs, name: "yhatstar")
    line(p_y, p_yhs, name: "estar")

    content("x.end", $xx = mat(x_1; dots.v; x_n)$, anchor: "north-east")
    content("y.end", $yy$, anchor: "south")
    content("one.end", $mat(1; dots.v; 1)$, anchor: "west")
    content("e.mid", $ee$, anchor: "west")
    content("yhat.end", $hat(y) = X θθ$, anchor: "north")
    content("estar.mid", $ee_*$, anchor: "west")
    content("yhatstar.end", $hat(y)_* = X θθ_*$, anchor: "north")

  })
)

モデルから得られる $hat(yy)$ は $xx, vb(1)$ がなす平面上にある。$hat(yy) = a xx + b vb(1)$ と書けることから明らかである。$θθ = mat(a; b)$ が動けば、それに合わせて $hat(yy)$ はこの平面上を動く。

$J(θθ)$ を最小化するとは、$||ee||$ を最小化することに等しい。$yy$ が偶然 $xx, vb(1)$ がなす平面の上にあれば、$J(θθ)=0$ となるように $θθ$ を取ってこれる。これが @noerror の話である。一般の場合についても、この図を見れば $||ee||$ が最小になるのは $ee$ と $hat(yy)$ が直交するときだとわかる。

$J(θθ)$ を平方完成したときの $X(θθ-θθ_*)$ の部分も見て取れる。確かに、そこが離れている分だけ $ee$ は 最小値 $ee_*$ から三平方の定理的に大きくなる。

== 「$θθ_*$」 はどこから来たのか
はじめはある種、天下り的に $θθ_*$ が与えられたが、幾何学的に解釈すれば順当に求めることができる。

$ee$ は $yy$ の終点から出て $xx, oone$ がなす平面 $Col(X)$#footnote([$X$ の列空間 という。]) 上の $hat(yy)$ に落ちるベクトルである。$ee$ の大きさを最小化したければ、「$ee$ と平面 $Col(X)$ が直交する」ようにすればよい。この条件は「$ee$ が $xx, oone$ とそれぞれ直交する」、すなわち「$(xx^⊤ ee = 0) and (oone^⊤ ee = 0)$」と言い換えることができ、表現を変えれば「$X^⊤ ee = mat(0; 0)$」となる。$ee = X θθ -yy$ だったので結局のところ $X^⊤(X θθ-yy)=0$ となるような $θθ$ を求めていたのであり、それを $θθ_*$ としていたのだ。ここから式を変形することで $θθ_* = (X^⊤ X)^(-1) X^⊤ yy$ が得られる。


= まとめ

= 参考文献
+ https://oroshi.me/2021/01/lsm, 2025年1月21日閲覧