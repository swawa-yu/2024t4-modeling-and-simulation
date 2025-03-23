#import "./template.typ": *
#import "@preview/cetz:0.3.1"
#import cetz.draw: *

#show: paper.with(
  paper-num: "4",
  title: "最適化・分類、動的システム",
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

= はじめに
筆者はこのレポートを自らの学習状況を示すことを目的として書く。定義、証明、定式化、等の厳密さについては、本講義で求められていると筆者が考える水準に照らして、問題ないと考える範囲において放棄する。また線型代数はごく一般的な分野であるため、広く知られているであろうことについては参考文献を記載しない。

このレポートを書くにあたって、授業を受けていない人が読んで学習できる程度に、流れよく書くことを心がけた。自らも線型代数や統計についての知識が浅いため、式の解釈など理解の補助にLLMを活用したこともここで述べておく。

= 固有値分解

= 正定行列
対称行列 $P = P^tp in RR^(n times n)$ が任意の $xx in RR^n (x eq.not 0)$ に対して次を満たすとき、$P$ を正定行列とよび、$P > 0$ と書く。

$
  xx^tp P xx > 0
$

対称行列 $P$ について、以下は同値である。
- $P$ の固有値が全て正
- $P$ は正定行列


= 最適化問題
== りんごの例
$
  x>0 \
  y>0 \
  0.3x+0.6y<15 \
  240x+180y<7200 \
  min -(x+y)
$
4つの不等式の境界線の交点について調べれば良い（調べるとはすなわち、評価関数を計算し、最小値を取るようなものを選ぶという意味である）ことが知られており、この解法はシンプレックス法と呼ばれている。

== 線型行列不等式問題 (LMI)
線型行列不等式問題 (Linear Matrix Inequality, LMI) は、行列の不等式制約を持つ最適化問題である。LMIは、線形システムの安定性、制御システムの性能、信号処理、統計、機械学習、量子情報理論など、さまざまな分野で応用されている。

LMIは、次のような形式で表される。
$
  F(x) = F_0 + x_1 F_1 + dots.c + x_n F_n <= 0
$

Scilab には LMI Solver が実装されている。

== 点と直線の距離
点 $zz = mat(z_1, z_2)$ と 直線 $w_1 x_1 + w_2 x_2 + b = 0$ の距離 $d$ は次のように求められる。
$
  d &= (|w_1 z_1 + w_2 z_2 + b|) / sqrt(w_1^2 + w_2^2) \
    &= (|w^T z + b|) / (||w||)
$

正と負を区別するなら
$
  d &= (w^T z + b) / (||w||)
$

直線上の領域は $w^T z + b = 0$、直線より上の領域は $w^T z + b > 0$、直線より下の領域は $w^T z + b < 0$ である。(よく考えれば当然である。)

= 実習の記録
== 第11回 実習(1), (2) 固有値分解
`[U, L] = spec(A)` のように書くことで固有値分解を行うことができる。複素数が出てくることに注意する必要がある。

対称行列の固有値分解に対して、`A = U * L * inv(U)'` が成り立つことを確認した。対称行列はランダムに生成した `B = rand(N, N, 'normal)` を用いて `A = B * B'` として作成することができる。

== 第11回 実習(5) りんごの問題をLMIで解く
#figure(caption: [りんごの問題])[
  #sourcecode[```scilab
    mode(0);

    funcprot(0);
    function [LME,LMI,OBJ] = apple(xy); 
      x = xy(1);
      y = xy(2);

      LME = [];  // 等式制約なし．
      eps = 0;
      LMI = [x, 0, 0, 0;
            0, y, 0, 0;
            0, 0, 15-0.3*x-0.6*y, 0;
            0, 0, 0, 7200-240*x-180*y];
      LMI = LMI - eps*eye(4,4);
      OBJ = -(x+y);  // 評価関数
    endfunction

    x = 0;
    y = 0;
    xy = list(x,y);
    xy = lmisolver(xy,apple);
    x = xy(1)
    y = xy(2)
  ```
]]<lst:11-5>

#figure(caption: [実行結果])[
  #sourcecode[```scilab
    lmisolver: 正準表現の構築
    lufact: Warning: Matrix is singular.
    lmisolver: 実行可能解生成フェーズ.

        primal obj.  dual obj.  dual. gap 
        1.00e-05    -3.55e+01   3.55e+01
        -5.90e+00    -3.55e+01   2.96e+01
    lmisolver: 目標値に到達しました.
    lmisolver: 実行可能解が見つかりました.
    lmisolver: 最適化フェーズ.

        primal obj.  dual obj.  dual. gap 
        -2.04e+01    -1.40e+02   1.20e+02
        -3.35e+01    -4.05e+01   6.94e+00
        -3.35e+01    -3.43e+01   8.06e-01
        -3.40e+01    -3.41e+01   6.51e-02
        -3.40e+01    -3.40e+01   7.66e-03
        -3.40e+01    -3.40e+01   7.84e-04
        -3.40e+01    -3.40e+01   6.75e-05
        -3.40e+01    -3.40e+01   7.83e-06
        -3.40e+01    -3.40e+01   6.61e-07
        -3.40e+01    -3.40e+01   7.68e-08
        -3.40e+01    -3.40e+01   5.92e-09
    lmisolver: 最適解が見つかりました
    x = 
      18.000000
    y = 
      16.000000
  ```
]]<lst:11-5>


== 第12回 実習(1) Schur Complement
#figure(caption: [Schur Complementの確認])[
  #sourcecode[```
    mode(0);

    n = 2;
    for k = 1:100,
      w = rand(n,1,'normal');
      r = w'*w + 0.01;
      In = eye(n,n);

      X = [r, w';
          w, In];

      [U,S] = spec(X);
      minS = min( diag(S) )
    end
  ```
]]

次の通り、Schur Complement が正定値であることが確認された。
#figure(caption: [実行結果])[
  #sourcecode[```
    minS = 
      0.0099347
    minS = 
      0.0033420
    minS = 
      0.0075595
    minS = 
      0.0029835
    minS = 
      0.0033879
  ```
]]

== 第12回 実習(2), (3) 線型2値クラス分類
次のコードを実行した。
#figure(caption: [])[
  #sourcecode[```
    mode(0);

    exec("hardmargine_data.sce");

    //--------------------------------
    // plotting the data
    //--------------------------------
    t_ = tx(:,1);
    x_ = tx(:,2:3);
    N = size(t_,1);

    t = t_';
    x = x_';

    //-----------------------------------------
    // defining LME, LMI constraints
    // and cost function OBJ
    //-----------------------------------------
    funcprot(0);
    function [LME,LMI,OBJ] = evalf(rwb)
      [r,w,b] = rwb(:);
      LME = [];
      LMI = [r,w'
            w,eye(2,2)];
      LMI = list(LMI);
      for i = 1:N,
        LMIi = t(i)*(w'*x(:,i)+b)-1;

        LMIi = list(LMIi);
        LMI = lstcat(LMI,LMIi);
      end
      OBJ = r;
    endfunction

    //--------------------------------
    // initial value
    //--------------------------------
    r = 1;
    w = [1;1];
    b = 1;
    rwb = list(r,w,b);

    //--------------------------------
    // Now, solving the problem
    //--------------------------------
    rwb = lmisolver(rwb,evalf);
    [r_,w_,b_] = rwb(:);
    w1 = w_(1);
    w2 = w_(2);

    //--------------------------------
    // plotting the estimated plane
    //--------------------------------
    scf();
    for k = 1:N,
      if(t(k)>0),
        plot(x(1,k),x(2,k),'rx');
      else
        plot(x(1,k),x(2,k),'bo');
      end
    end

    minx1 = min(x(1,:));
    maxx1 = max(x(1,:));
    x_ = linspace(minx1,maxx1);
    y_ = -(w1/w2)*x_-b_/w2;
    plot(x_,y_,"k-");

    a = gca();
    a.isoview = 'on';
  ```
]]

次に示すプロットの通り、分類できている。

#figure(image("./fig/plot.png", width:90%), caption: [プロット])<fig:plot>


== 第13回 RC回路のシミュレーション
= まとめ

= 参考文献
