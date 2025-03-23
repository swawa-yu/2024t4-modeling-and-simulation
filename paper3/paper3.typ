#import "./template.typ": *
#import "@preview/cetz:0.3.1"
#import cetz.draw: *

#show: paper.with(
  paper-num: "3",
  title: "最小二乗法、散布図・相関解析",
  date-due: "2025年1月29日",
)

#let tp = $⊤$
#let inner(v1, v2) = $angle.l v1, v2 angle.r$
#let xx = $vb(x)$
#let yy = $vb(y)$
#let zz = $vb(z)$
#let ee = $vb(e)$
#let oone = $vb(1)$
#let θθ = $vb(theta)$
#let xxn = $mat(x_1; dots.v; x_n)$
#let yyn = $mat(y_1; dots.v; y_n)$
#let matA = $mat(a, b; c, d)$
#let matB = $mat(e, f; g, h)$
#let Col = $"Col"$
#let ave(x) = $overline(x)$

= はじめに
筆者はこのレポートを自らの学習状況を示すことを目的として書く。定義、証明、定式化、等の厳密さについては、本講義で求められていると筆者が考える水準に照らして、問題ないと考える範囲において放棄する。また線型代数はごく一般的な分野であるため、広く知られているであろうことについては参考文献を記載しない。

このレポートを書くにあたって、授業を受けていない人が読んで学習できる程度に、流れよく書くことを心がけた。自らも線型代数や統計についての知識が浅いため、式の解釈など理解の補助にLLMを活用したこともここで述べておく。


= 一般の次元のベクトル・行列
(余裕がないので省略)
// $
//   x + y = e\
//   2x + 6y = f
// $
// $x=201, y=71$ として計算すると $e = 273, f=828$ である。$e,f$ を相手に教えた。

= 最小二乗法
== 導入
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
  yy=mat(y_1; dots.v; y_n), #h(1em) hat(yy)=mat(a x_1+b; dots.v; a x_n+b)
$
とおく。さらに、
$
  X=mat(x_1, 1; dots.v, dots.v; x_n, 1), #h(1em) θθ=mat(a; b)
$
とおくと $n$ 個の関係式 $y_k = a x_k +b #h(1em) (k=1,...,n)$ を 
$
  hat(yy) &= X θθ\
  mat(y_1; dots.v; y_n) &= mat(x_1, 1; dots.v, dots.v; x_n, 1) mat(a; b)
$
と表すことができる。誤差についても同様に $ee=hat(yy)-yy$ と直す。すると上の式はこの $ee$ を用いて次のように表せる。
$
  ee = X θθ - yy
$

したがって、最小二乗評価関数も次のように書き換えることができる。
$
  J(θθ)=sum_(k=1)^n e_k^2 = ee^⊤ ee = (X θθ - yy)^⊤ (X θθ - yy)
$
「目標」も行列のことばで書き直せば「$J(θθ)$ を最小化する $θθ$ を求めること」になる。そのような $θθ$ を $θθ_*$ と書くことにする。
#definition()[
  // $J(θθ)$ を最小化する $θθ$ を $θθ_*$ と書く。
  // もっと数学的な書き方をする
$θθ_* := arg min J(θθ)$

]

== 仮に誤差がなければ<noerror>
$yy = X θθ$ が成り立っているということである。この式を順に変形し $θθ$ を既知の値で表したい。
$
  yy &= X θθ\
  X^⊤ yy &= X^⊤ X θθ\
$
$X^⊤ X$ が正則である($X^⊤ X$ に逆行列が存在する)ならば、両辺に左から $(X^⊤ X)^(-1)$ をかけることで
$
  θθ &= (X^⊤ X)^(-1) X^⊤ yy
$
と $θθ$ を計算することができる。誤差が一切ない状況を考えているので $J(θθ)=0$ である。

== 誤差がある場合
実は誤差がある場合も $θθ = (X^⊤ X)^(-1) X^⊤ yy$ のときに $J(θθ)$ は最小となる。。つまり、
$
  θθ_* = (X^⊤ X)^(-1) X^⊤ yy
$
である。誤差があっても $θθ=θθ_*$ のときに $J(θ)$ が最小となることを、続く問題と解答で説明する。

問題の前に、今一度記号を整理しておく。

- $yy$ の上に「$hat$」が付いていればそれはモデルから得られる値を、付いていなければそれはシステムから得られる値を表す。
- 「$*$」が右下に付く記号は、最適なときの値を表す。
- $θθ$ はモデルのパラメータを表し、最適なモデルのパラメータ $θθ_*$ を求めることが目標である。
- $ee$ は誤差を表し、$ee := yy-hat(yy)$ で定義される

#problem()[
  任意の $θθ$ について、以下が成り立つことを示せ。
  $
    (θθ - θθ_*)^⊤ (X^⊤ X) (θθ - θθ_*) >= 0
  $
]
#proof[
  $X(θθ-θθ_*)$ がベクトルであることに注意すると、単に $X(θθ-θθ_*)$ のノルムの2乗を表す式であるとわかる。
  $
     & (θθ - θθ_*)^⊤ (X^⊤ X) (θθ - θθ_*)\
    =& ((θθ - θθ_*)^⊤ X^⊤)(X (θθ - θθ_*))\
    =& (X(θθ - θθ_*))^⊤ (X (θθ - θθ_*))\
    =& ||X (θθ - θθ_*)||^2 >= 0
  $
  ちなみに $θθ=θθ_*$ のとき、$X(θθ-θθ_*)=mat(0;dots.v;0)$ であるから等号が成り立つ。
]


#problem()[
  次の等式を示せ。
  $
    J(θθ) = (θθ - θθ_*)^⊤ X^⊤ X (θθ - θθ_*) + yy^⊤ yy - yy^⊤ X (X^⊤ X)^(-1) X^⊤ yy
  $
]
#proof[
  まず $θθ_*$ に関する式を整理しておく。$ θθ_* = (X^⊤ X)^(-1) X^⊤ yy$ の両辺に左側から $X^⊤ X$ をかけて次の式を得る。
  $
    X^⊤X θθ_* = X^⊤ yy
  $
  また $θθ_*$ の転置について、$(X^⊤ X)^(-1)$ が対称行列であることに注意すると
  $
    θθ_*^⊤ &= ((X^⊤ X)^(-1) X^⊤ yy)^⊤\
           &= yy^⊤ X ((X^⊤ X)^(-1))^⊤\
           &= yy^⊤ X (X^⊤ X)^(-1)
  $
  となる。これらを使って $J(θθ) = ee^⊤ ee = (X θθ - yy)^⊤ (X θθ - yy)$ を展開した式を整理する。

  $
    J(θθ) &= (X θθ - yy)^⊤ (X θθ - yy)\
          &= (X θθ)^⊤(X θθ) - (X θθ)^⊤ yy - yy^⊤(X θθ) + yy^⊤ yy\
          &= (X θθ)^⊤(X θθ) - 2(X θθ)^⊤ yy + yy^⊤ yy #h(3em) ("∵ベクトルの内積の交換法則")\
          &= (X θθ)^⊤(X θθ) - 2θθ^⊤ X^⊤ yy + yy^⊤ yy\
          &= (X θθ)^⊤(X θθ) - 2θθ^⊤ X^⊤ X θθ_* + yy^⊤ yy #h(4em) (∵X^⊤X θθ_* = X^⊤ yy)\
          &= (X θθ)^⊤(X θθ) - 2(X θθ)^⊤ (X θθ_*) + yy^⊤ yy\
          &= {(X θθ)^⊤(X θθ) - 2(X θθ)^⊤ (X θθ_*) + (X θθ_*)^⊤(X θθ_*)} + yy^⊤ yy - (X θθ_*)^⊤(X θθ_*)\
          &= (X θθ- X θθ_*)^⊤ (X θθ- X θθ_*) + yy^⊤ yy - (X θθ_*)^⊤(X θθ_*)\
          &= (X (θθ-θθ_*))^⊤ (X (θθ-θθ_*)) + yy^⊤ yy - (X θθ_*)^⊤(X θθ_*)\
          &= (θθ-θθ_*)^⊤ X^⊤ X (θθ-θθ_*) + yy^⊤ yy - θθ_*^⊤ X^⊤ X θθ_*\
          &= (θθ-θθ_*)^⊤ X^⊤ X (θθ-θθ_*) + yy^⊤ yy - (θθ_*^⊤)(X^⊤ X θθ_*)\
          &= (θθ-θθ_*)^⊤ X^⊤ X (θθ-θθ_*) + yy^⊤ yy - (yy^⊤ X (X^⊤ X)^(-1))(X^⊤ yy)\
          &= (θθ-θθ_*)^⊤ X^⊤ X (θθ-θθ_*) + yy^⊤ yy - yy^⊤ X (X^⊤ X)^(-1)X^⊤ yy
  $
]
この等式を自分の思うきれいな形で書くと次のような感じだろうか。
$
  J(θθ) &= ||X (θθ-θθ_*)||^2 + ||yy||^2 - ||X θθ_*||^2\
        &= ||hat(yy) - hat(yy)_*||^2 + ||yy||^2 - ||hat(yy)_*||^2
$
$J(θθ)$ は $θθ = θθ_*$ のとき最小となるが、このとき右辺の第1項が $0$ となるので改めて式を書くと
$
  J(θθ_*) = ||ee_*||^2 &= ||yy||^2 - ||X θθ_*||^2\
                     &= ||yy||^2 - ||hat(yy)_*||^2
$
のようになる。三平方の定理の逆から、$yy, hat(yy)_*, ee_*$ は直角三角形をなすと言える。
// $
//   J(θθ) = ||ee||^2 &= ||hat(yy) - yy||^2\
//                        &= ||hat(yy)||^2 + ||yy||^2 - 2hat(yy)^⊤ yy\
//   J(θθ) &= ||hat(yy) - hat(yy)_*||^2 + ||yy||^2 - ||hat(yy)_*||^2\
//             &= ||hat(yy)||^2 + ||hat(yy)_*||^2 - 2hat(yy)_*^⊤ hat(yy) + ||yy||^2 - ||hat(yy)_*||^2
// $

== 最小二乗法の幾何学的解釈
次の @fig:1 ように $n$ 次元空間の絵を書いてみる。3次元っぽい表現しかできないが、都合の良いことにこれで十分説明がつく。この絵は見やすさのために $xx, vb(1)$ がなす平面が「水平」になるように書いている。さて、ベクトル $xx, yy, vb(1), ee, hat(yy)$ の関係を見てみよう。

#figure(caption: [$n$ 次元空間中の各ベクトル])[
  #align(center,
    cetz.canvas(length: 2.5cm, {
      set-style(
        mark: (fill: black, scale: 1, end: "stealth"),
        stroke: (thickness: 0.4pt, cap: "round"),
        content: (padding: 5pt)
      )

      let p_x = (x: -0.5, y: 0, z: 1)
      let p_1 = (x: 2, y: 0, z: 0)
      let p_0 = (x: 0, y: 0, z: 0)
      let p_y = (x: 0.6, y: 1.2, z: 0.5)
      let p_yh = (x: 1.7, y: 0, z: 0.7)
      let p_yhs = (x: 0.6, y: 0, z: 0.5)
      let resize(p, scale) = {
        let norm = calc.pow((p.x*p.x + p.y*p.y + p.z*p.z), 0.5)
        let a = scale / norm
        return (x: p.x * a, y: p.y * a, z: p.z * a)
      }
      let add(p1, p2) = (x: p1.x + p2.x, y: p1.y + p2.y, z: p1.z + p2.z)
      let sub(p1, p2) = (x: p1.x - p2.x, y: p1.y - p2.y, z: p1.z - p2.z)
      let mul(p, a) = (x: p.x * a, y: p.y * a, z: p.z * a)
      let vecline(p, v) = line(p, add(p, v))

      line(p_0, p_x, name: "x")
      line(p_0, p_y, name: "y")
      line(p_0, p_1, name: "one")
      line(p_0, p_yh, name: "yhat")
      line(p_0, p_yhs, name: "yhatstar")
      line(p_y, p_yh, name: "e")
      line(p_y, p_yhs, name: "estar")

      set-style(mark: (end: none))
      // 直角記号
      let rightangle(p1, p2, p3, size) = {
        let v21 = sub(p2, p1)
        let v23 = sub(p2, p3)
        let v21_ = resize(v21, size)
        let v23_ = resize(v23, size)
        let p1_21 = sub(p2, resize(v21, size))
        let p3_23 = sub(p2, resize(v23, size))
        line(p1_21, sub(p1_21, v23_))
        line(p3_23, sub(p3_23, v21_))
      }

      rightangle(p_0, p_yhs, p_y, 0.1)
      rightangle(add(p_yhs, p_1), p_yhs, p_y, 0.1)
      rightangle(add(p_yhs, p_x), p_yhs, p_y, 0.1)

        let p_x_ = mul((x: -p_x.x, y: -p_x.y, z: -p_x.z), 0.6)
        let p_1_ = mul((x: -p_1.x, y: -p_1.y, z: -p_1.z), 0.6)
      merge-path(fill: color.rgb("00000010"), stroke: none, {
        let p_x = mul(p_x, 1.4)
        let p_1 = mul(p_1, 1.4)
        line(add(p_x, p_1_), add(p_x, p_1))
        line(add(p_x, p_1), add(p_x_, p_1))
        line(add(p_x_, p_1), add(p_x_, p_1_))
        line(add(p_x_, p_1_), add(p_x, p_1_))
      })

      content("x.end", $xx = mat(x_1; dots.v; x_n)$, anchor: "east")
      content("y.end", $yy$, anchor: "south")
      content("one.end", $mat(1; dots.v; 1)$, anchor: "west")
      content("yhat.end", $hat(y) = X θθ$, anchor: "north")
      content("yhatstar.end", $hat(y)_* = X θθ_*$, anchor: "north")
      content("e.mid", $ee$, anchor: "west")
      content("estar.mid", $ee_*$, anchor: "west")
      content(add(p_x_, p_1_), text(fill: gray)[$xx, oone$ がなす平面 $Col(X)$], anchor: "south-east")
    })
)
]<fig:1>

モデルから得られる $hat(yy)$ は $xx, vb(1)$ がなす平面上にある。$hat(yy) = a xx + b vb(1)$ と書けることから明らかである。$θθ = mat(a; b)$ が動けば、それに合わせて $hat(yy)$ はこの平面上を動く。

$J(θθ)$ を最小化するとは、$||ee||$ を最小化することに等しい。$yy$ が偶然 $xx, vb(1)$ がなす平面の上にあれば、$J(θθ)=0$ となるように $θθ$ を取ってこれる。これが @noerror の話である。一般の場合についても、この図を見れば $||ee||$ が最小になるのは $ee$ と $hat(yy)$ が直交するときだとわかる。

$J(θθ)$ を平方完成したときの $X(θθ-θθ_*)$ の部分も見て取れる。確かに、そこが離れている分だけ $ee$ は 最小値 $ee_*$ から三平方の定理的に大きくなる。

== 「$θθ_*$」 はどこから来たのか
はじめはある種、天下り的に $θθ_*$ が与えられたが、構成的に求めることもできる。次のように、幾何学的な表現を使うとわかりやすく説明できるだろう。

$ee$ は $yy$ の終点から出て $xx, oone$ がなす平面 $Col(X)$#footnote([$X$ の列空間 という。]) 上の $hat(yy)$ に落ちるベクトルである。$ee$ の大きさを最小化したければ、「$ee$ と平面 $Col(X)$ が直交する」ようにすればよい。この条件は「$ee$ が $xx, oone$ とそれぞれ直交する」、すなわち「$(xx^⊤ ee = 0) and (oone^⊤ ee = 0)$」と言い換えることができ、表現を変えれば「$X^⊤ ee = mat(0; 0)$」となる。$ee = X θθ -yy$ だったので結局のところ $X^⊤(X θθ-yy)=0$ となるような $θθ$ を求めればよく、それを $θθ_*$ としていたのだ。ここから式を変形することで $θθ_* = (X^⊤ X)^(-1) X^⊤ yy$ が得られる。

= 散布図・相関解析
2変数の関係を見たい場合、一方を横軸に、もう一方を縦軸に取ってデータをプロットする散布図を使用すると良い。
相関係数 $r$ は、2変数の関係性を表す指標である。

// = いろいろな統計量
// == 期待値
// 期待値とは、確率変数の実現値に確率の重みを付けた加重平均のことである。

// $
//   E{x} := integral p(x) x dif x
// $

// 種々の統計量は期待値の表現を借りることで簡潔に表現できる。

// == 平均
// $
//   overline(x) := 1/N sum_(i=1)^N x_i = 
// $

// == 分散
// 不偏標本分散 $V_(x x)$ は次のように定義される。
// $
//   V_(x x) = 1/(N-1) sum_(i=1)^N (x_i-ave(x))
// $

// == 相関係数
// 相関係数 $r$ は次のように定義される。
// $
//   r = Cov(x, y) / sqrt(V_(x x) V_(y y))
//   // r = sum_(i=1)^N (x_i-ave(x))(y_i-ave(y)) / (N-1) / sqrt(V_(x x) V_(y y))
// $

= 実習の記録
== 第9回 実習(1)–(3)
- 対角行列: `diag(a_1, a_2, ..., a_n)`
- 逆行列: `inv(A)`
- 行列の積: `A * B`
- 行列の転置: `A'`

ランダムに生成したデータに対して、最小二乗法を適用して近似曲線を求めるプログラムを作成した。プロットした結果を @fig:plot に示す。

#figure(image("./fig/plot.png", width:90%), caption:[散布図と近似曲線のプロット])<fig:plot>

#figure(caption: [実行したコード])[
  #sourcecode[```scilab
    //-----------------------------------------------------
    // 最小二乗法
    mode(0);

    N = 100;

    x = 2*rand(N, 1, 'normal') + 3;

    a = 1.5;
    b = 1;
    e = 0.5*rand(N, 1, 'normal'); // 雑音
    y = a*x + b + e;

    scf(1);
    plot(x, y, 'r.');

    // 最小二乗法により，解を求める．
    X = [x,ones(N,1)]; 
    theta = inv(X'*X) * X' * y;  // a, b を推定する．
    a_ = theta(1)
    b_ = theta(2)

    // 結果をプロット
    y_ = zeros(N,1);
    for k = 1:N,
        y_(k) = a_ * x(k) + b_;  //  y_ は推定値
    end
    plot(x,y_);
  ```
]]<lst:4>


== 第10回 実習(1)–(4)
Scilabには統計分析に便利な関数が用意されている。
- 散布図:  `plot(x, y)`
- 平均:  `mean(x)`
- 分散: `variance(x)`
- 共分散: `cov(x, y)`
- 標準偏差: `stdev(x)`
- 相関係数: `correl(x, y)`


= 参考文献
+ 「最小二乗法は誤差を正規分布と仮定した最尤推定である」, https://oroshi.me/2021/01/lsm, 2025年1月21日閲覧