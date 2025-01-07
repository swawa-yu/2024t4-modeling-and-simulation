#import "../template.typ": *
#import "@preview/cetz:0.3.1"

#show: paper.with(
  cource: "モデリングとシミュレーション",
  title: "レポート2 「ベクトルについて」",
  date-due: "2025年1月8日",
  term: "2024年度4ターム"
)

#let tr(matrix) = $matrix^⊤$
#let inner(v1, v2) = $angle.l v1, v2 angle.r$
#let xx = $vb(x)$
#let yy = $vb(y)$
#let zz = $vb(z)$
#let xxn = $mat(x_1; dots.v; x_n)$
#let yyn = $mat(y_1; dots.v; y_n)$

= はじめに
筆者はこのレポートを自らの学習状況を示すことを目的として書く。定義、証明、定式化、等の厳密さについては、本講義で求められていると筆者が考える水準に照らして、問題ないと考える範囲において放棄する。また線型代数はごく一般的な分野であるため、広く知られているであろうことについては参考文献を記載しない。

= ベクトルに関する諸定義および定理
問題の解答にあたって必要に応じて参照できるように、定義や定理、式と説明を記載しておく。


== ベクトルの定義
ベクトルとはいくつかの実数の組である。組をなす実数の数を次元と呼び、各実数のことを成分と呼ぶ。$x_1, x_2$ を成分に持つ2次元ベクトル $xx$ は次のように書き表す。

$
  xx = mat(x_1; x_2)
$

$n$ 次元ベクトル全体の集合のことを $RR^n$ と表す。

※以後この章の中では、ことわりがなければ $xx, yy in RR^2, a in RR$ とする。

(2次元)ベクトルは次の性質を満たす。

#definition("ベクトルの基本演算")[

  $
    xx + yy = mat(x_1+y_1; x_2+y_2) #h(5em) &"(ベクトルの和)"\
    a xx = xx a = mat(a x_1; a x_2) #h(5em) &"(ベクトルとスカラーの積)"
  $
]

※特に $-1 xx $ のことを $-xx$ と書き、$xx + (-yy)$ を $xx-yy$ と表記する。

== 行ベクトルと列ベクトル、転置
ベクトルは行列の特殊な場合として見ることができる。逆に言えば、ベクトルを拡張することで行列となる。ベクトルを行列に自然に拡張するために、ベクトルには次の2種類があると考える。すなわち、成分を縦方向に書き並べる*列ベクトル*と横方向に書き並べる*行ベクトル*である。次の例では $xx_行$ は行ベクトル、$xx_列$ は列ベクトルである。

$
  xx_行 = mat(x_1, x_2)\
  xx_列 = mat(x_1; x_2)
$
行ベクトルと列ベクトルは明確に区別しないでも議論ができると判断される場合には、明示的に宣言されないことがある。本レポートでもその方針を取る。(書き並べる方向を気にしないようなベクトルのことを*数ベクトル*と呼ぶ。)

行ベクトルと列ベクトルを区別するとき、それらには*転置*という演算を考えることができる。転置によって、行ベクトルを列ベクトルに、列ベクトルを行ベクトルに変換することができる。具体的には次のように定義される。
#definition("ベクトルの転置")[
  行ベクトル、列ベクトルに対して転置を次のように定める。
  $
    tr(mat(x_1, dots.c, x_n)) &:= mat(x_1; dots.v; x_n)\
    tr(mat(x_1; dots.v; x_n)) &:= mat(x_1, dots.c, x_n)
  $
]

このように、転置は転置記号「⊤」ををベクトルの右上に表記することで表現されることが多い。

行ベクトルと列ベクトルを区別するとき、ベクトルの次元(成分の数)が等しくても、行ベクトルと列ベクトルの和は計算できないことに注意する必要がある。

転置に関するいくつかの性質を示しておく。

#theorem("転置の性質")[
  $xx, yy in RR^2, a in RR$ とする。このとき次が成り立つ。

  (1) $tr((tr(xx))) = xx$

  (2) $tr(xx+yy) = tr(xx) + tr(yy)$

  (3) $tr(a xx) = a tr(xx)$
]

#proof[
  概略のみ示す。ベクトルを成分表示すると、転置の定義およびベクトルの満たす性質から上記の性質を導くことができる。
]

== 内積
ベクトルに対して、内積と呼ばれる演算が次のように定義される。
$
  inner(xx, yy) := x_1 y_1 + x_2 y_2
$
上の式は2次元の場合について述べたものだが、一般に、$n$ 次元の場合は次のようになる。
#definition([ベクトルの内積])[
  $n$ 次元ベクトル$xx=xxn, yy=yyn$に対して、内積と呼ばれる演算が次のように定義される。
  $
    inner(xx, yy) := sum_(i=1)^n x_i y_i
  $
]

行ベクトルと列ベクトルを区別する場合、内積を(まだ説明していないものではあるが)行列積の表現と同様に、次のように文字を並べて表現することもできる。

#definition([ベクトルの内積の別の表現：行ベクトルと列ベクトルの積])[
  行ベクトルと列ベクトルの積を次のように定義する。すなわち、列ベクトル $xx, yy$ に対して
  $
    tr(xx)yy := inner(xx, yy) = sum_(i=1)^n x_i y_i
  $
  $tr(xx)$ が行ベクトル、$yy$ が列ベクトルであること、そして行ベクトルが左側、列ベクトルが右側にあることに注意。
]

ただし、左側が行ベクトル、右側が列ベクトルとなっている必要がある。そのため、列ベクトル $xx, yy$ の内積は $tr(xx)yy$ のように書くことになる。

#theorem([内積の性質])[
  ベクトルの内積に関して、次が成り立つ。

  (1) $tr(xx)yy = tr(yy)xx$                 #h(1fr) (交換法則)

  (2) $tr(xx)xx=0 <=> xx = vb(0)$

  (3) $tr(xx)xx >= 0$

  (4) $tr((xx+yy))zz = tr(xx)zz + tr(yy)zz$ #h(1fr) (分配法則)

  (5) $tr((a xx))zz = a(tr(xx)zz)$          #h(1fr) (結合法則)
]<naiseki>
#proof[

  (1) 定義より明らか。

  (3) 内積の定義より、
  $
    tr(xx)xx = sum_(i=1)^n x_i^2
  $
  全ての成分 $x_i$ について $x_i^2 >= 0$ であるから
  $
    tr(xx)xx = sum_(i=1)^n x_i^2 >= 0
  $

  (2) (3)において成分のうち一つでも0でないものがあれば総和は0より大きくなることから導かれる。

  (4) 諸定義から具体的に計算すればよい。
  
  (5) 諸定義から具体的に計算すればよい。
]


== 距離、大きさ
ベクトルに対してその*大きさ*、すなわちベクトルを矢印として見たときの始点から終点までの*距離*を考えることができる。図形的に解釈すると具体的に計算ができ、三平方の定理より次のように定義するのが良いことになる。

#definition[
  ベクトル $xx = mat(x_1; dots.v; x_n)$ の*大きさ*(*ユークリッドノルム*)を次のように定義する。
  $
    ||xx|| := sqrt(sum_(i=1)^n x_i^2)
  $
]
これは単にベクトルの始点と終点の距離を表すものだと考えて良い。上のような式で定義される距離を*ユークリッド距離*という。*距離*とはそれが満たすべき性質を満たすもののことであり、ユークリッド距離の他にいくつかの距離の定義が考えられる。つまりユークリッド距離は広い意味での距離のうちの一つである。そして、ユークリッド距離は日常生活における距離を表しており、最も直感的で馴染み深いものである。

内積の定義を思い出せば、ベクトルの大きさは内積の表現を用いて表せることがわかる。
$
  ||xx|| = inner(xx, xx) = tr(xx)xx
$


#theorem("ユークリッド距離の性質")[
  上のように定義したベクトルの大きさに関して次の性質が成り立つ。$xx, yy in RR^n, a in RR$ とするとき、

  (1) $||xx||=0 <=> xx=vb(0)$

  (2) $||a xx|| = abs(a)||xx||$

  (3) $||xx+yy|| <= ||xx||+||yy||$ #h(1fr) (三角不等式)
]
#proof[

  (1) @naiseki (2) と $tr(xx)xx = ||xx||^2$ から導ける。

  (2) 定義通りに計算すればよい。

  (3) 後の @mondai-sankaku の解答として示す。
]


== コーシー・シュワルツの不等式
#theorem("コーシー・シュワルツの不等式")[
  ベクトル$xx, yy$に対して次の関係が成り立つ。
  $
    ||vb(x)||||vb(y)|| >= |inner(vb(x), vb(y))|
  $
]<cauthy>

#proof[
$
  ||xx-yy||^2 &= ||xx||^2 + ||yy||^2 - 2inner(xx,yy) && "(距離の定義、内積の定義より)"\
  ||vb(x)-vb(y)||^2 &= ||vb(x)||^2 + ||vb(y)||^2 - 2||vb(x)||||vb(y)||cos θ && "(余弦定理)"
$

上の式から下の式を辺々引くと、以下の式が成立する。
$
  ||xx||||yy|| cos theta = inner(vb(x),vb(y))
$

$|cos θ| <= 1$ より次が成立。
$
  ||xx||||yy|| >= |inner(vb(x),vb(y))|
$
]

== 余弦定理
#theorem("余弦定理")[
  2つのベクトル $xx, yy$ とそれらのなす角 $theta$ の間には次の関係が成り立つ。
  $
    ||xx-yy||^2 = ||xx||^2 + ||yy||^2 - 2||xx||||yy|| cos theta
  $
]
#proof[
  (線型代数の本題から遠いため省略。幾何的に証明できる。)
]

上の式はベクトルを用いて表現されているが、すべてその大きさとしてしか登場していないため、$||xx||, ||yy||, ||xx-yy||$ をそれぞれ三角形の3辺の長さ $a, b, c$ と見ればベクトル特有の演算は含まれなくなる。そのため余弦定理は初等幾何的に証明できる。本レポートが線型代数を扱うという理由のもと、ここであえてベクトルを用いた表現をしているに過ぎない。

= 問題と解答
本レポートで解答すべき問題は、第5回資料中の問題(1), (2)である。講義資料の問題を次のように改めて整理しておく。

#problem[
  $xx, yy, zz in RR^2, a in RR$ とする。次の(1)〜(5)を証明せよ。
  
  (1) $tr((vb(x)+vb(y)))=tr(vb(x))+tr(vb(y))$

  (2) $tr((a vb(x)))vb(y) = a (tr(vb(x))vb(y))$

  (3) $tr((a xx + yy))zz = a (tr(xx) zz) + tr(yy) zz$

  (4) $tr(xx) (a yy + zz) = a (tr(xx) yy) + tr(xx) zz$

  (5) $||xx-yy||^2 = ||xx||^2+||yy||^2-2tr(xx)yy$
]
#proof[
  (1)〜(5)のどれも、ベクトルの基本的な性質に関するものである。ベクトルが満たすべき性質をもとに、成分を具体的に計算することで示すことができる。

  (1)
  $
    tr((xx+yy)) &= tr((mat(x_1;x_2)+mat(y_1;y_2)))\
                &= tr(mat(x_1+y_1;x_2+y_2))\
                &= mat(x_1+y_1, x_2+y_2)\
                &= tr(mat(x_1, x_2)) + tr(mat(y_1, y_2))\
                &= tr(xx) + tr(yy)
  $

  (2)
  $
    tr((a xx))yy &= tr(a mat(x_1; x_2))yy\
                &= tr(mat(x_1+y_1;x_2+y_2))\
                &= mat(x_1+y_1, x_2+y_2)\
                &= tr(mat(x_1, x_2)) + tr(mat(y_1, y_2))\
                &= tr(xx) + tr(yy)
  $

  (3) (上と同様に示せる)

  (4) (上と同様に示せる)

  (5) 
  $
    ||xx-yy||^2 &= tr((xx-yy))(xx-yy) &&"(距離の定義)"\
                &= tr((xx-yy))xx - tr((xx-yy))yy &&"(内積の分配法則)"\
                &= {tr(xx)xx - tr(yy)xx} - {tr(xx)yy - tr(yy)yy} &&"(内積の分配法則)"\
                &= {||xx||^2 - tr(xx)yy} - {tr(xx)yy - ||yy||^2} &&"(距離の定義, 内積の交換法則)"\
                &= ||xx||^2 + ||yy||^2 - 2 tr(xx)yy
  $
  
]


#problem[
  コーシー・シュワルツの不等式を用いて、以下の三角不等式を証明せよ。また、三角不等式について、三角形を書き図形的説明を与えよ。
  $
    ||xx+yy|| <= ||xx||+||yy||
  $
]<mondai-sankaku>
#proof[
  $
    ||xx+yy||^2 &= tr((xx+yy))(xx+yy)\
                &= ||xx||^2 + ||yy||^2 + 2tr(xx)yy\
  $
  ここで、コーシー・シュワルツの不等式 $||vb(x)||||vb(y)|| >= |tr(xx)yy|$ を用いて
  $
    ||xx+yy||^2 &<=||xx||^2 + ||yy||^2 + 2||xx||||yy||\
                &= (||xx||+||yy||)^2
  $
  よって $||xx+yy|| <= ||xx||+||yy||$

  図形的には次のように説明できる。下のように三角形を書くと、この不等式は「2辺の長さの和 $||x||+||y||$ は、残りの1辺の長さ $||xx+yy||$ より大きい」ことを意味していると言える。
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

        set-style(stroke: (thickness: 1.2pt))

        // circle((-1,0), radius: 0.1)
        // circle((0.5,1), radius: 0.1)
        // circle((2,0.5), radius: 0.1)

        line((-1, 0), (0.5, 1), name: "y", mark: (end: "stealth"))
        content("y.mid", $ yy $, anchor: "south")

        line((0.5, 1), (2, 0.5), name: "x", mark: (end: "stealth"))
        content("x.mid", $ xx $, anchor: "south")

        line((-1, 0), (2, 0.5), name: "z", mark: (end: "stealth"))
        content("z.mid", $ xx+yy $, anchor: "north")
      }
    )
  )
]

#problem[
  以下について示せ。
  $
    abs(||xx|| - ||yy||) <= ||xx+yy||
  $
]
#proof[
  与えられた不等式は次のように同値変形できる。
  $
        & abs(||xx|| - ||yy||) <= ||xx+yy||\
    <=> & ||xx|| - ||yy|| <= ||xx+yy|| #h(1em) and  #h(1em) ||yy|| - ||xx|| <= ||xx+yy||\
    <=> & ||xx|| <= ||xx+yy|| + ||yy|| #h(1em) and  #h(1em) ||yy|| <= ||xx+yy|| + ||xx|| 
  $
  最後の式のうち左側は「$xx$ の長さは、他の2辺 $yy, xx+yy$ の長さの和より小さい」ことを表している。このことに注目すると、三角不等式を次のように利用すればよいことがわかる。
  $
    ||xx|| &= ||(xx+yy) + (-yy)||\
           &<=||xx+yy|| + ||-yy|| #h(2em) "(三角不等式より)"\
           &= ||xx+yy|| + ||yy||\
  $
  これで最後の式のうち左側を示せた。右側についても同様に示せるので、与えられた不等式を証明できた。
]


= 実習の記録
== 実習(1), (2) Scilabでベクトルの表示

== 実習(3) Scilabでベクトルの内積を計算する

== 実習(4) 角度について

== 実習(5) 定理の確認
2次元の正規分布の乱数を使って、以下を確かめなさい。

(1) コーシー・シュワルツの不等式\
(2) 三角不等式



= 参考文献

+ 数学の景色『列ベクトルと行ベクトルの定義と違い』(2025-01-08 閲覧) https://mathlandscape.com/column-row-vector/

+ 数学の景色『数ベクトルの定義と数ベクトルにおけるノルム・内積』(2025-01-08 閲覧) https://mathlandscape.com/numerical-vector/ 