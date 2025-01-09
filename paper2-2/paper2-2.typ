#import "./template.typ": *
#import "@preview/cetz:0.3.1"

#show: paper.with(
  paper-num: "2-2",
  title: "行列およびベクトルの積について",
  date-due: "2025年1月8日",
)

#let tr(matrix) = $matrix^⊤$
#let inner(v1, v2) = $angle.l v1, v2 angle.r$
#let xx = $vb(x)$
#let yy = $vb(y)$
#let zz = $vb(z)$
#let xxn = $mat(x_1; dots.v; x_n)$
#let yyn = $mat(y_1; dots.v; y_n)$
#let matA = $mat(a, b; c, d)$
#let matB = $mat(e, f; g, h)$

= はじめに
筆者はこのレポートを自らの学習状況を示すことを目的として書く。定義、証明、定式化、等の厳密さについては、本講義で求められていると筆者が考える水準に照らして、問題ないと考える範囲において放棄する。また線型代数はごく一般的な分野であるため、広く知られているであろうことについては参考文献を記載しない。

= 行列に関する諸定義および定理
問題の解答にあたって必要に応じて参照できるように、定義や定理、式と説明を記載しておく。


== 行列の定義
ベクトルが一方向に実数を並べたものであったのに対して、行列は実数を行と列に並べたものである。例えば次は2行2列の行列である。
$
  A = matA
$

本レポートでは、2次元の場合について議論する。

#definition("行列の基本演算")[
  $A=matA, B=matB$ のとき、
  $
    A+B = mat(a+e, b+f; c+g, d+h) #h(5em) &"(行列の和)"\
    k A = A k = mat(k a, k b; k c, k d) #h(5em) &"(行列とスカラーの積)"
  $
]

#definition("行列の成分")[
  $
    A = mat(a, b; c, d)
  $

  とすると、
  $
    A_(1 1) = a, A_(1 2) = b, A_(2 1) = c, A_(2 2) = d
  $

  である。
]

== 行列とベクトルの積
#definition("行列とベクトルの積")[
  $A=matA, x=xx$ のとき、それらの積は次のように計算される。
  $
    A xx = matA mat(x_1; x_2) := mat(a x_1 + b x_2; c x_1 + d x_2)
  $
]

== 連立方程式の例
#problem([連立方程式の例])[
鶏と豚が全部で10匹います。全部の足を合計すると28本です。鶏と豚はそれぞれ何匹？]
この問題は次の連立方程式で表現できる。
$
  x + y = 10\
  2x + 4y = 28
$

この連立方程式は行列とベクトルを用いて次のように表現できる。
$
  mat(1, 1; 2, 4) mat(x; y) = mat(10; 28)
$

行列で定義される基本的な演算を用いて、この連立方程式を解くことができる。手順通りに計算できて表現も単純であるため、行列で表現することは計算機に解かせる上で都合が良い。解き方の具体的な内容については今後の講義で学習する。

== 行列積
#definition("行列積")[
  2行2列の行列の積は次のように計算される。
  $
    matA matB := mat(a e + b g, a f + b h; c e + d g, c f + d h)
  $
]

和の場合と異なり、積は単に対応する成分を掛け合わせるだけではない。少し複雑な計算だがこの計算が基本的なものとして定義されることによって、線型代数はその表現力を高めることができ、様々な分野に応用されている。

積の各成分に注目すると、それぞれベクトルの内積の形になっていることがわかる。すなわち、次のようにベクトルの内積で表現することができる。

$
  matA matB = mat(mat(a, b) mat(e; g), mat(a, b) mat(f; h); mat(c, d) mat(e; g), mat(c, d) mat(f; h))
$

行列積は非可換である。すなわち、$A B = B A$  が成り立つとは限らない。例えば次の例を計算してみよう。
#problem([行列積の例])[
  $A = mat(1, 2; 3, 4), B = mat(1, 10; 10, 1)$ とする。$A B$ と $B A$ を計算し、値が異なることを確認せよ。
]<hikakan>
#proof[
  $
    A B &= mat(1, 2; 3, 4) mat(1, 10; 10, 1)\
        &= mat(1 dot 1 + 2 dot 10, 1 dot 10 + 2 dot 1; 3 dot 1 + 4 dot 10, 3 dot 10 + 4 dot 1)\
        &= mat(21, 12; 43, 31)\

    B A &= mat(1, 10; 10, 1) mat(1, 2; 3, 4)\
        &= mat(1 dot 1 + 10 dot 3, 1 dot 2 + 10 dot 4; 10 dot 1 + 1 dot 3, 10 dot 2 + 1 dot 4)\
        &= mat(31, 42; 13, 24)
  $
  よって、$A B = mat(21, 12; 43, 31)$ であり、$B A = mat(31, 42; 13, 24)$ である。これらは異なるため、行列積は非可換である。
]

この例はScilabによる計算も行っており、詳しくは @chapter:jisshu1 で述べている。

= 実習の記録
== 実習(1) Scilabにおける行列積の計算<chapter:jisshu1>
Scilabによる行列の積の計算の練習として @hikakan をScilabで計算した。Scilabでは行列の積は `*` で表現する。また、行列の和は `+` で表現する。これはベクトルの回で学んだ演算と同じである。（なぜならば、行ベクトルや列ベクトルは単に行列とみなされているからである。）

実行したコードを @lst:1 に、その実行結果を @lst:2 に示す。

#figure(caption: [Scilabによる行列計算])[
  #sourcecode[```
    mode(0);

    A = [1, 2;
        3, 4]
    B = [1, 10;
        10, 1]

    // 行列の和
    A_B = A+B

    // 行列のスカラー倍
    A2 = A*2

    // 行列の積
    AB = A*B
    BA = B*A
```
]]<lst:1>
#figure(caption: [@lst:1 の実行結果])[
  #sourcecode[```
    A = [2x2 double]
      1.   2.
      3.   4.
    B = [2x2 double]
      1.    10.
      10.   1. 
    A_B = [2x2 double]
      2.    12.
      13.   5. 
    A2 = [2x2 double]
      2.   4.
      6.   8.
    AB = [2x2 double]
      21.   12.
      43.   34.
    BA = [2x2 double]
      31.   42.
      13.   24.
```
]]<lst:2>


== 実習(2) Scilabで行(／列)だけ得る方法
Scilabでは `A(1, 2)` とすれば行列 `A` の1行2列目の要素を取得できる。

カッコの中には実数だけでなくベクトルを指定することもできる。ベクトルを指定することで、複数の成分を取得することができる。例えば `A(1, 1:2)` とすれば行列 `A` の1行1列目から2列目までの要素からなる行列を取得できる。ここで `1:2`は`[1, 2]` の省略形である。

「$i$ 行から $j$ 行まで」のように具体的に範囲ではなく、全ての行を指定したいときには、`:` を使う。例えば `A(1, :)` とすれば行列 `A` の1行目の全ての要素からなる行列を取得できる。

実行したコードを @lst:3 に、その実行結果を @lst:4 に示す。

#figure(caption: [Scilabによる行列計算])[
  #sourcecode[```
    mode(0);

    X = rand(3,3,'normal')

    // 1 行目だけ
    X(1,:)

    // 2 行目だけ
    X(2,:)

    // 1行目と2行目
    X(1:2,:)

    // 再度表示
    X

    // 1 列目だけ
    X(:,1)

    // 2 列目だけ
    X(:,2)

    // 1列目と2列目
    X(:, 1:2)

    // 再度表示
    X

    // 1,2行と1,2列
    X(1:2, 1:2)
```
]]<lst:3>
#figure(caption: [@lst:3 の実行結果])[
  #sourcecode[```
    X = [3x3 double]
      -0.2551124  -0.1158131  -0.6888704
      -0.1468231  -0.6145392   1.0452423
      -0.3398349  -0.5835608  -0.3663346
    ans = [1x3 double]
      -0.2551124  -0.1158131  -0.6888704
    ans = [1x3 double]
      -0.1468231  -0.6145392   1.0452423
    ans = [2x3 double]
      -0.2551124  -0.1158131  -0.6888704
      -0.1468231  -0.6145392   1.0452423
    X = [3x3 double]
      -0.2551124  -0.1158131  -0.6888704
      -0.1468231  -0.6145392   1.0452423
      -0.3398349  -0.5835608  -0.3663346
    ans = [3x1 double]
      -0.2551124
      -0.1468231
      -0.3398349
    ans = [3x1 double]
      -0.1158131
      -0.6145392
      -0.5835608
    ans = [3x2 double]
      -0.2551124  -0.1158131
      -0.1468231  -0.6145392
      -0.3398349  -0.5835608
    X = [3x3 double]
      -0.2551124  -0.1158131  -0.6888704
      -0.1468231  -0.6145392   1.0452423
      -0.3398349  -0.5835608  -0.3663346
    ans = [2x2 double]
      -0.2551124  -0.1158131
      -0.1468231  -0.6145392
```
]]<lst:4>



== 実習(3) 3種類の方法で行列積を計算する
行列の積の計算方法について理解を深めるため、3種類の方法で行列積を計算する。1つ目はScilabの `*` を使用する方法、2つ目は各行、各列の内積(inner product)を計算する方法、3つ目はScilabの for で計算する方法である。実行したコードを @lst:5 に、その実行結果を @lst:6 に示す。

#figure(caption: [Scilabによる行列計算])[
  #sourcecode[```
    mode(0);

    n = 2;
    X = rand(n,n,'normal')
    Y = rand(n,n,'normal')

    // Scilab の "*" を使用
    Z = X*Y

    // Scilab の内積(inner product)を使用
    Zi = zeros(n,n); // 初期化
    for i = 1:n,
      for j = 1:n,
        Zi(i,j) = X(i,:)*Y(:,j);
      end
    end
    Zi

    // Scilab の for で計算
    Zf = zeros(n,n); // 初期化
    for i = 1:n,
      for j = 1:n,
        for k = 1:n,
          Zf(i,j) = Zf(i,j) + X(i,k)*Y(k,j);
        end
      end
    end
    Zf
```
]]<lst:5>
#figure(caption: [@lst:5 の実行結果])[
  #sourcecode[```
    X = [2x2 double]
      -1.8546736  -0.2316   
      1.1956471   0.3763408
    Y = [2x2 double]
      -0.4901191   0.0932712
      -1.01017    -1.1833318
    Z = [2x2 double]
      1.1429664   0.1010721
      -0.9661777  -0.3338166
    Zi = [2x2 double]
      1.1429664   0.1010721
      -0.9661777  -0.3338166
    Zf = [2x2 double]
      1.1429664   0.1010721
      -0.9661777  -0.3338166
```
]]<lst:6>



= まとめ
- 行列とその基本演算について学習した
- 行列で連立方程式を表現する方法を学んだ
- Scilabで行列積を計算する方法、行(／列)だけ得る方法を学んだ


= 参考文献
