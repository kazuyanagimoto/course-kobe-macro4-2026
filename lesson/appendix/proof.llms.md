# Appendix A — 証明

Code

## A.1 黄金分割法における黄金比

[sec-golden-section](#sec-golden-section) 節 の黄金分割法では, 区間の内分点を黄金比 \\\varphi = \frac{\sqrt{5} - 1}{2} \approx 0.618\\ で取りました. ここでは, なぜ黄金比が現れるのかを示します.

各反復で関数値が必要になりますが, 関数評価はコストが高いため, できるだけ評価回数を減らしたいです. そこで, 次の2つの条件を満たすように内分点を配置することを考えます.

1.  **縮小率を一定にする.** 各反復で区間が同じ割合 \\r \in (0, 1)\\ だけ縮小する.
2.  **計算済みの点を再利用する.** 前の反復で評価した2つの内分点のうち一方が, 新しい区間の内分点としてそのまま使える. これにより, 1反復あたりの新規の関数評価を1回に抑えられる.

**命題 A.1 (黄金分割法の内分比)** 区間 \\\[a, b\]\\ の幅を \\L = b - a\\ とし, 比率 \\\varphi \in \left(\frac{1}{2}, 1\right)\\ で左右対称に2つの内分点 \\x_1 = a + \left(1 - \varphi\right) L\\, \\x_2 = a + \varphi L\\ を取る配置のうち, 上の2条件 (一定の縮小率と点の再利用) を満たすものは

\\ \varphi = \frac{\sqrt{5} - 1}{2} \approx 0.618 \\

(黄金比の逆数) に限る.

*Proof*. 区間 \\\[a, b\]\\ の幅を \\L = b - a\\ とし, 内分点を左右対称に取る.

\\f(x_1) \> f(x_2)\\ の場合, 極小値は \\x_1\\ より右にあるので, 区間を \\\[x_1, b\]\\ に更新する. 新しい区間の幅は \\L' = b - x_1 = \varphi L\\ となるため, 縮小率は \\r = \varphi\\ で一定である (条件1). 対称な場合 \\f(x_1) \leq f(x_2)\\ でも, 区間は \\\[a, x_2\]\\ となり幅は \\\varphi L\\ で同じである.

次に点の再利用を考える. 区間を \\\[x_1, b\]\\ に更新したとき, 古い点 \\x_2\\ は新しい区間の内部に残っている. これを新しい区間の (左側の) 内分点として再利用するには, \\x_2\\ が新しい区間 \\\[x_1, b\]\\ の左端から幅の \\1 - \varphi\\ の位置になければならない (条件2).

\\ x_2 = x_1 + (1 - \varphi) L'= x_1 + (1 - \varphi)\varphi L. \\

ここで \\x_1 = a + (1 - \varphi)L\\, \\x_2 = a + \varphi L\\ を代入すると,

\\ \begin{aligned} a + \varphi L &= a + (1 - \varphi) L + (1 - \varphi)\varphi L \\ \varphi &= (1 - \varphi)(1 + \varphi) \\ \varphi &= 1 - \varphi^2. \end{aligned} \\

整理すると \\\varphi^2 + \varphi - 1 = 0\\ であり, \\\varphi \in \left(\frac{1}{2}, 1\right)\\ の解は \\\varphi = \frac{\sqrt{5} - 1}{2}\\ に限る.

得られた \\\varphi\\ は黄金比 \\\phi = \frac{1 + \sqrt{5}}{2} \approx 1.618\\ の逆数 \\\varphi = 1/\phi\\ に等しく, \\\varphi^2 = 1 - \varphi\\ という自己相似的な関係を満たすことが, 区間の縮小と点の再利用を両立させる鍵になっています.

## A.2 3次スプライン補間の最小曲率性

[sec-interpolation](#sec-interpolation) 節 では, 補間の手法として線形補間と3次スプライン補間を比較しました. ここでは, 3次スプライン補間が「滑らかさ」という明確な意味で最良の補間になっていることを示します.

**補間関数と滑らかさ.** データ点 \\(x_1, y_1), \dots, (x_n, y_n)\\ (\\x_1 \< \cdots \< x_n\\) が与えられたとき, これらを通る関数 \\f\\ (すなわち \\f(x_i) = y_i\\ を満たす関数) を補間関数と呼びます. 補間関数は無数に存在するため, 何らかの意味で「良い」ものを選ぶ必要があります. スプラインの語源は製図で用いる薄い弾性板 (しなう定規) で, その弾性エネルギーは曲率の2乗の積分に比例します. 勾配が小さいとき曲率は \\f''\\ で近似できるので, 「なめらかさ」を測る指標として次の**曲げエネルギー** (bending energy) を考えます.

\\ J(f) = \int\_{x_1}^{x_n} \left(f''(x)\right)^2 dx. \\

\\J(f)\\ が小さいほど関数の曲がりが少なく, 不要な振動のない滑らかな補間だといえます.

**定義 A.1 (自然な3次スプライン)** 関数 \\g\\ が次をすべて満たすとき, データ点を補間する**自然な3次スプライン** (natural cubic spline) と呼ぶ.

1.  各小区間 \\\[x_i, x\_{i+1}\]\\ 上で \\g\\ は3次以下の多項式である.
2.  \\g\\ は区間全体 \\\[x_1, x_n\]\\ で2階連続微分可能である (\\g \in C^2\\).
3.  データ点を補間する: \\g(x_i) = y_i\\.
4.  両端で2階微分がゼロ (自然境界条件): \\g''(x_1) = g''(x_n) = 0\\.

**定理 A.1 (自然な3次スプラインの最小曲率性)** データ点を補間する任意の \\C^2\\ 級関数 \\f\\ の中で, 自然な3次スプライン \\g\\ は曲げエネルギー \\J\\ を最小にする.

\\ J(g) \leq J(f), \qquad \text{with equality iff } f = g. \\

つまり, 与えられた点を通る滑らかな関数のうち, 自然な3次スプラインが最も曲がりの少ない補間を与えます.

*Proof*. \\h := f - g\\ とおく. \\f, g\\ はともにデータ点を補間するので, 各ノードで \\h(x_i) = f(x_i) - g(x_i) = 0\\ である. \\f = g + h\\ より, 曲げエネルギーを展開すると

\\ J(f) = \int\_{x_1}^{x_n} \left(g'' + h''\right)^2 dx = J(g) + 2\int\_{x_1}^{x_n} g'' h''\\ dx + \int\_{x_1}^k{x_n} \left(h''\right)^2 dx. \\

交差項が消えることを示す. 部分積分すると

\\ \int\_{x_1}^{x_n} g'' h''\\ dx = \left\[g''(x) h'(x)\right\]\_{x_1}^{x_n} - \int\_{x_1}^{x_n} g'''(x) h'(x)\\ dx. \\

第1項は自然境界条件 \\g''(x_1) = g''(x_n) = 0\\ よりゼロである. 第2項は, \\g\\ が各小区間 \\\[x_i, x\_{i+1}\]\\ で3次多項式なので \\g'''\\ がその区間で定数 \\c_i\\ となることを使う.

\\ \int\_{x_1}^{x_n} g'''(x) h'(x)\\ dx = \sum\_{i=1}^{n-1} c_i \int\_{x_i}^{x\_{i+1}} h'(x)\\ dx = \sum\_{i=1}^{n-1} c_i \left(h(x\_{i+1}) - h(x_i)\right) = 0. \\

最後の等号は, すべてのノードで \\h(x_i) = 0\\ であることによる. したがって交差項はゼロとなり,

\\ J(f) = J(g) + \int\_{x_1}^{x_n} \left(h''(x)\right)^2 dx \geq J(g). \\

等号が成立するのは \\\int (h'')^2 dx = 0\\, すなわち \\h'' \equiv 0\\ のときに限る. このとき \\h\\ は1次関数だが, \\h\\ は2つ以上のノードでゼロになるため \\h \equiv 0\\, つまり \\f = g\\ でなければならない.

以上より, 自然な3次スプラインは「与えられた点を通る最も滑らかな関数」という変分問題の解になっています. これが, 高次の多項式補間で生じる不要な振動 (Runge 現象) を避けつつ, 線形補間と違って2階微分まで連続な補間が得られる理由です.

## A.3 縮小写像と動的計画法

数値計算パートの動的計画法 (第 [sec-dynamic-programming](#sec-dynamic-programming) 章) では, 価値関数反復 (VFI) がひとつの関数に収束していく様子を可視化で確認しました. ここでは, その背後にある理論を証明付きで整理します. ベルマン方程式の解 (価値関数) は存在するのか, 一意なのか, そして VFI はなぜ, どれくらいの速さで収束するのか. 答えはすべて, 縮小写像 (contraction mapping) という一つの概念から得られます. 標準的な教科書としては Stokey, Lucas and Prescott (1989) があります.

### A.3.1 縮小写像

関数の列の収束を扱うので, 議論の舞台は「関数同士の距離」が定義された空間です.

**定義 A.2 (距離空間と完備性)** 集合 \\S\\ と関数 \\d \colon S \times S \to \mathbb{R}\_{\geq 0}\\ の組 \\\left(S, d\right)\\ が距離空間であるとは, 任意の \\f, g, h \in S\\ に対して次が成り立つことをいう.

- \\d\left(f, g\right) = 0 \iff f = g\\
- 対称性: \\d\left(f, g\right) = d\left(g, f\right)\\
- 三角不等式: \\d\left(f, h\right) \leq d\left(f, g\right) + d\left(g, h\right)\\

距離空間が完備 (complete) であるとは, 任意のコーシー列 (項同士の距離がいくらでも小さくなる列) が \\S\\ の中に極限を持つことをいう.

ここで使うのは, 状態空間 \\X\\ 上の有界関数の空間 \\B\left(X\right)\\ と sup ノルムの距離

\\ d\left(f, g\right) = \left\\ f - g \right\\\_{\infty} = \sup\_{x \in X} \left\| f\left(x\right) - g\left(x\right) \right\| \\

です. この空間が完備であることは知られています (有界関数の一様収束極限は有界).

**定義 A.3 (縮小写像)** 距離空間 \\\left(S, d\right)\\ 上の写像 \\T \colon S \to S\\ が係数 \\\beta \in \left(0, 1\right)\\ の縮小写像 (contraction mapping) であるとは, 任意の \\f, g \in S\\ に対して

\\ d\left(Tf, Tg\right) \leq \beta\\ d\left(f, g\right) \\

が成り立つことをいう.

縮小写像は「どの2点も, 写すたびに距離が \\\beta\\ 倍以下に縮む」写像です. 直感的には, 空間全体が1点に向かって縮んでいくので, その1点が不動点になるはずです. これを正確に述べたのが次の定理です.

**定理 A.2 (Banach の不動点定理)** \\\left(S, d\right)\\ を完備距離空間, \\T\\ を係数 \\\beta\\ の縮小写像とする. このとき,

1.  \\T\\ はただ1つの不動点 \\v^\* \in S\\ (\\T v^\* = v^\*\\) を持つ.
2.  任意の初期点 \\v_0 \in S\\ から反復列 \\v_n = T v\_{n-1}\\ を作ると, \\v_n \to v^\*\\ であり, 収束は幾何級数的である. \\ d\left(v_n, v^\*\right) \leq \beta^n d\left(v_0, v^\*\right). \\

*Proof*. Step1 (反復列はコーシー列): \\d\left(v\_{n+1}, v_n\right) = d\left(T v_n, T v\_{n-1}\right) \leq \beta\\ d\left(v_n, v\_{n-1}\right)\\ を繰り返すと \\d\left(v\_{n+1}, v_n\right) \leq \beta^n d\left(v_1, v_0\right)\\ である. \\m \> n\\ に対して三角不等式を使うと

\\ d\left(v_m, v_n\right) \leq \sum\_{k=n}^{m-1} d\left(v\_{k+1}, v_k\right) \leq \sum\_{k=n}^{\infty} \beta^k d\left(v_1, v_0\right) = \frac{\beta^n}{1 - \beta} d\left(v_1, v_0\right) \\

となり, \\n \to \infty\\ でゼロに収束する. よって \\\left\\v_n\right\\\\ はコーシー列であり, 完備性からある \\v^\* \in S\\ に収束する.

Step2 (\\v^\*\\ は不動点): 任意の \\n\\ に対して

\\ d\left(T v^\*, v^\*\right) \leq d\left(T v^\*, v\_{n+1}\right) + d\left(v\_{n+1}, v^\*\right) \leq \beta\\ d\left(v^\*, v_n\right) + d\left(v\_{n+1}, v^\*\right) \\

であり, 右辺は \\n \to \infty\\ でゼロに収束するので \\d\left(T v^\*, v^\*\right) = 0\\, すなわち \\T v^\* = v^\*\\.

Step3 (一意性): \\v, w\\ がともに不動点なら \\d\left(v, w\right) = d\left(Tv, Tw\right) \leq \beta\\ d\left(v, w\right)\\ であり, \\\beta \< 1\\ より \\d\left(v, w\right) = 0\\, すなわち \\v = w\\.

Step4 (収束の速さ): \\d\left(v_n, v^\*\right) = d\left(T^n v_0, T^n v^\*\right) \leq \beta^n d\left(v_0, v^\*\right)\\.

ある写像が縮小写像かどうかを定義から直接確かめるのは面倒ですが, 経済学に現れる作用素には次の便利な十分条件があります.

**命題 A.2 (Blackwell の十分条件)** \\T \colon B\left(X\right) \to B\left(X\right)\\ が次の2条件を満たすなら, \\T\\ は sup ノルムに関して係数 \\\beta\\ の縮小写像である.

1.  **単調性**: \\f \leq g\\ (すべての \\x\\ で \\f\left(x\right) \leq g\left(x\right)\\) ならば \\Tf \leq Tg\\.
2.  **割引**: ある \\\beta \in \left(0, 1\right)\\ が存在して, 任意の定数 \\a \geq 0\\ に対して \\T\left(f + a\right) \leq Tf + \beta a\\.

*Proof*. 任意の \\f, g\\ に対して, すべての \\x\\ で \\f\left(x\right) \leq g\left(x\right) + \left\\ f - g \right\\\_{\infty}\\ が成り立つ. 単調性と割引を順に使うと

\\ Tf \leq T\left(g + \left\\ f - g \right\\\_{\infty}\right) \leq Tg + \beta \left\\ f - g \right\\\_{\infty}. \\

\\f\\ と \\g\\ を入れ替えれば逆向きの不等式も得られるので, すべての \\x\\ で \\\left\| \left(Tf\right)\left(x\right) - \left(Tg\right)\left(x\right) \right\| \leq \beta \left\\ f - g \right\\\_{\infty}\\ となり, sup をとって \\\left\\ Tf - Tg \right\\\_{\infty} \leq \beta \left\\ f - g \right\\\_{\infty}\\.

### A.3.2 ベルマン方程式への適用

動的計画法の章で扱った問題を一般形で書きます. 状態 \\x \in X\\, 実行可能な選択の集合 \\\Gamma\left(x\right)\\, 当期リターン \\u\left(x, a\right)\\, 状態の遷移 \\x' \sim Q\left(\cdot \mid x, a\right)\\, 割引因子 \\\beta \in \left(0, 1\right)\\ とし, \\u\\ は有界とします. ベルマン方程式は

\\ V\left(x\right) = \max\_{a \in \Gamma\left(x\right)} \left\\ u\left(x, a\right) + \beta\\ \mathbb{E}\left\[V\left(x'\right) \mid x, a\right\] \right\\ \tag{A.1}\\

であり, 右辺を関数 \\V\\ への操作とみなしたものがベルマン作用素 \\T\\ です.

\\ \left(TV\right)\left(x\right) = \max\_{a \in \Gamma\left(x\right)} \left\\ u\left(x, a\right) + \beta\\ \mathbb{E}\left\[V\left(x'\right) \mid x, a\right\] \right\\. \\

[式 eq-bellman](#eq-bellman) を解くことは, \\T\\ の不動点を見つけることにほかなりません.

**命題 A.3 (ベルマン作用素は縮小写像)** \\u\\ が有界なら, ベルマン作用素 \\T\\ は \\B\left(X\right)\\ 上の係数 \\\beta\\ の縮小写像である. したがって [式 eq-bellman](#eq-bellman) の有界な解 \\V^\*\\ はただ1つ存在し, 任意の初期関数 \\V_0\\ からの価値関数反復 \\V_N = T V\_{N-1}\\ は

\\ \left\\ V_N - V^\* \right\\\_{\infty} \leq \beta^N \left\\ V_0 - V^\* \right\\\_{\infty} \\

を満たして \\V^\*\\ に収束する.

*Proof*. \\u\\ が有界 (\\\left\|u\right\| \leq \bar{u}\\) なら, \\\left\|V\right\| \leq M\\ に対して \\\left\|TV\right\| \leq \bar{u} + \beta M\\ なので \\T\\ は \\B\left(X\right)\\ を \\B\left(X\right)\\ に写す. Blackwell の条件を確かめる.

単調性: \\f \leq g\\ なら, どの \\\left(x, a\right)\\ でも \\u\left(x, a\right) + \beta\\ \mathbb{E}\left\[f\right\] \leq u\left(x, a\right) + \beta\\ \mathbb{E}\left\[g\right\]\\ であり, 各選択肢の値が大きくなるので max も大きくなる. よって \\Tf \leq Tg\\.

割引: 定数 \\a \geq 0\\ に対して

\\ T\left(V + a\right)\left(x\right) = \max\_{a' \in \Gamma\left(x\right)} \left\\ u\left(x, a'\right) + \beta\\ \mathbb{E}\left\[V\left(x'\right)\right\] + \beta a \right\\ = \left(TV\right)\left(x\right) + \beta a. \\

よって [命題 prp-blackwell](#prp-blackwell) より \\T\\ は係数 \\\beta\\ の縮小写像であり, \\B\left(X\right)\\ は完備なので [定理 thm-banach](#thm-banach) のすべての結論が従う.

この命題が, 数値計算パートで見た事実の理論的な裏付けです. 価値関数は存在して一意であり, VFI は**どんな初期関数から始めても**収束し, 収束の速さは \\\beta\\ で決まります. \\\beta\\ が1に近い (将来を重視する) 問題ほど収束が遅い, という数値計算上の経験則も, 誤差が \\\beta^N\\ で減ることの直接の帰結です.[^1]

#### 停止基準と誤差の保証

実際の計算では真の \\V^\*\\ を知らないまま反復を止める必要があります. 隣り合う反復の差から, 真の誤差を評価できます.

**命題 A.4 (事後誤差評価)** \\ \left\\ V_N - V^\* \right\\\_{\infty} \leq \frac{\beta}{1 - \beta} \left\\ V_N - V\_{N-1} \right\\\_{\infty}. \\

*Proof*. 三角不等式と縮小性より

\\ \left\\ V_N - V^\* \right\\\_{\infty} \leq \sum\_{k=N}^{\infty} \left\\ V\_{k+1} - V_k \right\\\_{\infty} \leq \sum\_{j=1}^{\infty} \beta^j \left\\ V_N - V\_{N-1} \right\\\_{\infty} = \frac{\beta}{1 - \beta} \left\\ V_N - V\_{N-1} \right\\\_{\infty}. \\

数値計算パートの VFI で使った「更新幅 \\\left\\ V_N - V\_{N-1} \right\\\_{\infty}\\ が許容誤差 \\\varepsilon\\ を下回ったら停止」という基準は, この命題によって真の誤差が \\\beta \varepsilon / \left(1 - \beta\right)\\ 以下であることを保証します. 係数 \\\beta / \left(1 - \beta\right)\\ は \\\beta = 0.96\\ なら \\24\\ です. 更新幅と真の誤差は1〜2桁ずれうるので, 許容誤差はその分だけ小さめに設定する必要があります.

#### 価値関数が引き継ぐ性質

縮小写像の議論には, もうひとつ便利な使い方があります. \\B\left(X\right)\\ の閉部分集合 \\S'\\ (たとえば非減少関数の集合や凹関数の集合) に対して \\T\left(S'\right) \subset S'\\ が示せれば, 不動点 \\V^\*\\ も \\S'\\ に属します. 反復列がずっと \\S'\\ の中にいて, \\S'\\ が閉じているので極限も \\S'\\ に残るからです.

**命題 A.5 (単調性と凹性の継承)** リターン \\u\left(x, a\right)\\ が \\x\\ について非減少で, 実行可能集合が拡大的 (\\x \leq \tilde{x}\\ ならば \\\Gamma\left(x\right) \subset \Gamma\left(\tilde{x}\right)\\), 遷移が単調なら, \\V^\*\\ は \\x\\ について非減少である. さらに \\u\\ が凹, \\\Gamma\\ のグラフが凸, 遷移が線形 (決定論的な線形遷移や凹性を保つ確率遷移) なら, \\V^\*\\ は凹である.

*Proof*. 非減少な \\V\\ に対して \\TV\\ も非減少になることを見る. \\x \leq \tilde{x}\\ とすると, どの \\a \in \Gamma\left(x\right)\\ に対しても \\u\left(\tilde{x}, a\right) + \beta\\ \mathbb{E}\left\[V \mid \tilde{x}, a\right\] \geq u\left(x, a\right) + \beta\\ \mathbb{E}\left\[V \mid x, a\right\]\\ であり (\\u\\ の単調性と遷移の単調性), さらに \\\tilde{x}\\ では選択肢が増えるので max は下がらない. よって \\\left(TV\right)\left(\tilde{x}\right) \geq \left(TV\right)\left(x\right)\\. 非減少関数の集合は sup ノルムで閉じているので, 非減少な \\V_0\\ から始めた反復列の極限 \\V^\*\\ も非減少である. 凹性も同様に, \\T\\ が凹関数を凹関数に写すこと (凸結合の状態で凸結合の政策が実行可能であり, リターンが凹であること) を確かめればよい.

数値計算パートで補間 (関数近似の章) が素直に機能したのは, 近似対象の \\V^\*\\ がこうした形状の規則性を持つからです. 逆に, 離散選択が入って価値関数にキンクが生じる場合には, 結婚の部の frictionless marriage の章で見た対数和による平滑化が効いてきます.

縮小写像の枠組みは, サーチ理論の章での留保値の存在の議論にもそのまま使われています.

## A.4 家計内配分の証明

### A.4.1 効率性と加重和最大化の双対性

*Proof*. (\\\Leftarrow\\) \\\mu \in \left(0, 1\right)\\ とする. もし \\\left(u_W^\*, u_H^\*\right)\\ を Pareto 支配する配分が \\\mathcal{U}\\ にあれば, その配分は加重和 [式 eq-collective](#eq-collective) を厳密に大きくするので, 最大性に矛盾する. (\\\mu\\ が \\0\\ または \\1\\ の端点の場合は, 最大化解のうち Pareto 効率的なものを選べばよい.)

(\\\Rightarrow\\) \\\left(u_W^\*, u_H^\*\right)\\ が Pareto 効率的とする. 集合 \\A = \left\\ u \in \mathbb{R}^2 : u_W \> u_W^\*,\\ u_H \> u_H^\* \right\\\\ は凸で, 効率性より \\\mathcal{U}\\ と交わらない. 分離超平面定理より, ゼロでないベクトル \\\left(\mu, 1 - \mu\right)\\ (正規化済み) が存在して, \\\mathcal{U}\\ 上の任意の点で \\\mu u_W + \left(1 - \mu\right) u_H \leq \mu u_W^\* + \left(1 - \mu\right) u_H^\*\\ となる. \\A\\ の形状より \\\mu \geq 0\\ かつ \\1 - \mu \geq 0\\ であり, \\\left(u_W^\*, u_H^\*\right)\\ は [式 eq-collective](#eq-collective) の解である.

### A.4.2 Slutsky 行列の SR1 条件

*Proof*. [式 eq-collective-demand](#eq-collective-demand) を \\\pi_l\\ と \\Y\\ で微分し, [式 eq-slutsky](#eq-slutsky) に代入する.

\\ S\_{kl} = \underbrace{\frac{\partial \tilde{q}\_k}{\partial \pi_l} + q_l\\ \frac{\partial \tilde{q}\_k}{\partial Y}}\_{\Sigma\_{kl}} + \frac{\partial \tilde{q}\_k}{\partial \mu} \left(\frac{\partial \mu}{\partial \pi_l} + q_l\\ \frac{\partial \mu}{\partial Y}\right). \\

第1項は, \\\mu\\ を固定した標準的な需要関数 \\\tilde{q}\left(\cdot, \cdot, \mu\right)\\ の Slutsky 行列なので対称かつ負値半定符号である. 第2項は \\a_k b_l\\ の形, すなわち2つのベクトルの外積なので, 行列としてのランクは高々 \\1\\ である.

### A.4.3 Nash 交渉と collective model の双対性

*Proof*.

1.  フロンティア上で \\u_H = \Psi\left(u_W\right)\\ を代入すると, Nash 交渉問題は \\\left(u_W - T_W\right)^{\beta}\left(\Psi\left(u_W\right) - T_H\right)^{1-\beta}\\ の最大化になる. 対数を取って微分した一階条件は

\\ \frac{\beta}{u_W^\* - T_W} + \frac{\left(1 - \beta\right)\Psi'\left(u_W^\*\right)}{\Psi\left(u_W^\*\right) - T_H} = 0 \quad \Longleftrightarrow \quad -\Psi'\left(u_W^\*\right) = \frac{\beta}{1 - \beta} \cdot \frac{u_H^\* - T_H}{u_W^\* - T_W}. \\

一方, collective model の目的関数 \\\mu u_W + \left(1 - \mu\right) \Psi\left(u_W\right)\\ の一階条件は \\-\Psi'\left(u_W\right) = \mu / \left(1 - \mu\right)\\ である. \\\Psi\\ の凹性からどちらの一階条件も十分条件なので, [式 eq-nash-weight](#eq-nash-weight) のもとで両者の解は一致する.

2.  効率的な内点 \\\left(u_W^\circ, u_H^\circ\right)\\ における接線の傾きを \\-\lambda = \Psi'\left(u_W^\circ\right) \< 0\\ とする. 任意の \\a \> 0\\ に対して脅威点を \\T_W = u_W^\circ - a\\, \\T_H = u_H^\circ - \lambda a \left(1 - \beta\right) / \beta\\ と選べば, \\\left(u_W^\circ, u_H^\circ\right)\\ は (1) の一階条件を満たし, 凹性よりこの脅威点に対する Nash 交渉解になる.

### A.4.4 限定コミットメントのもとでの Pareto ウェイトの動き

[式 eq-lc-weight](#eq-lc-weight) を導きます. 導出は Theloudis et al. ([2025](#ref-theloudis2025)) に従います.

*Proof*. 結婚時のウェイト \\\mu\_{j0} = \mu_j\left(\Omega_0\right)\\ のもとで, 家計は生涯効用の加重和

\\ \sum\_{j} \mu\_{j0}\\ \mathbb{E}\_0 \sum\_{t=0}^{\bar{t}} \beta^t u\_{jt} \\

を, 予算制約と, 各期 \\t \geq 1\\・各人 \\j\\ の参加制約 [式 eq-participation](#eq-participation) のもとで最大化する. ここで \\u\_{jt} = u_j\left(q_t, h\_{jt}\right)\\ と略記する. 期 \\t\\ の参加制約の Lagrange 乗数を \\\beta^t \nu\_{jt}\\ と基準化する. \\\nu\_{jt} \geq 0\\ は期 \\t\\ までの情報で決まる確率変数で, 制約が等号で成り立たない状態ではゼロである (相補スラック条件). Lagrangian のうち参加制約の部分は

\\ \sum_j \mathbb{E}\_0 \sum\_{t=1}^{\bar{t}} \beta^t \nu\_{jt} \left(\mathbb{E}\_t \sum\_{\tau = t}^{\bar{t}} \beta^{\tau - t} u\_{j\tau} - \tilde{V}\_{jt}\right) \\

である. \\\nu\_{jt}\\ は期 \\t\\ に分かっているので, 繰り返し期待値の法則から

\\ \mathbb{E}\_0 \left\[\beta^t \nu\_{jt}\\ \mathbb{E}\_t \sum\_{\tau = t}^{\bar{t}} \beta^{\tau - t} u\_{j\tau}\right\] = \mathbb{E}\_0 \sum\_{\tau = t}^{\bar{t}} \beta^{\tau} \nu\_{jt}\\ u\_{j\tau} \\

となる. さらに和の順序を入れ替えると

\\ \sum\_{t=1}^{\bar{t}} \sum\_{\tau = t}^{\bar{t}} \beta^{\tau} \nu\_{jt}\\ u\_{j\tau} = \sum\_{\tau = 1}^{\bar{t}} \beta^{\tau} u\_{j\tau} \sum\_{t=1}^{\tau} \nu\_{jt} \\

なので, Lagrangian は

\\ \mathbb{E}\_0 \sum\_{\tau = 0}^{\bar{t}} \beta^{\tau} \sum_j \mu\_{j\tau}\\ u\_{j\tau} - \sum_j \mathbb{E}\_0 \sum\_{t=1}^{\bar{t}} \beta^t \nu\_{jt}\\ \tilde{V}\_{jt}, \qquad \mu\_{j\tau} := \mu\_{j0} + \sum\_{t=1}^{\tau} \nu\_{jt} \\

と書ける. 期 \\\tau\\ の効用にかかる重みは \\\mu\_{j\tau}\\ であり, 定義から \\\mu\_{j\tau} = \mu\_{j, \tau - 1} + \nu\_{j\tau}\\ が成り立つ. これが [式 eq-lc-weight](#eq-lc-weight) である. 外部オプションの価値 \\\tilde{V}\_{jt}\\ が家計の選択 (離婚時に分ける資産など) に依存する場合は, 第2項から各期の目的関数に追加の項が加わるが ([Theloudis et al. 2025](#ref-theloudis2025)), 効用にかかる重みの動きは変わらない.

## A.5 サーチモデルの証明

### A.5.1 留保賃金, reservation wage

*Proof*. Step1 (存在と一意性): [式 eq-mccall](#eq-mccall) の右辺は [sec-apdx-contraction](#sec-apdx-contraction) 節で見たベルマン作用素の形をしており, オファーの台が有界なら Blackwell の条件を満たす縮小写像である. よって有界な解 \\V\\ が一意に存在する.

Step2 (閾値ルール): 受諾の価値 \\w / (1 - \beta)\\ は \\w\\ に対して狭義単調増加であり, 継続価値は定数なので,

\\ w^\* = (1 - \beta) C, \\ に対して, 閾値ルール「\\w \geq w^\*\\ なら受諾」が最適である.

Step3 (留保賃金と一意性): \\V\\ の表現を \\C\\ の定義に代入する.

\\ \begin{aligned} \frac{w^\*}{1 - \beta} &= C \\ &= b + \frac{\beta}{1 - \beta} \int V\left(w'\right) dF\left(w'\right) \\ &= b + \frac{\beta}{1 - \beta} \left(w^\* + \int\_{w^\*}^{\infty} \left(w - w^\*\right) dF\left(w\right) \right)\\ w^\* &= b + \frac{\beta}{1-\beta} \int\_{w^\*}^{\infty} \left(w - w^\*\right) dF\left(w\right). \end{aligned} \\

これは, 左辺が \\w^\*\\ に関して単調増加, 右辺が単調減少する方程式であり, 交点は一意に存在する.

### A.5.2 留保賃金の比較静学

*Proof*.

1.  [式 eq-reservation](#eq-reservation) の右辺をすべて左辺に集めた式を定義する.

\\ \Phi\left(w^\*, b\right) := w^\* - b - \frac{\beta}{1 - \beta} \int\_{w^\*}^{\infty} \left(w - w^\*\right) dF\left(w\right) = 0. \\

オプション価値項の微分は [補題 lem-option-value](#lem-option-value) より,

\\ \frac{\partial}{\partial w^\*} \int\_{w^\*}^{\infty} \left(w - w^\*\right) dF\left(w\right) = -\left(1 - F\left(w^\*\right)\right). \\

よって,

\\ \frac{\partial \Phi}{\partial w^\*} = 1 + \frac{\beta}{1 - \beta}\left(1 - F\left(w^\*\right)\right) \> 0, \qquad \frac{\partial \Phi}{\partial b} = -1 \\

であり, 陰関数定理から

\\ \frac{d w^\*}{d b} = -\frac{\partial \Phi / \partial b}{\partial \Phi / \partial w^\*} = \frac{1}{1 + \frac{\beta}{1 - \beta}\left(1 - F\left(w^\*\right)\right)} \> 0. \\

2.  右辺の積分は \\\int \max\left\\ w - w^\*, 0 \right\\ dF\left(w\right)\\ と書け, \\\max\left\\ w - w^\*, 0 \right\\\\ は \\w\\ の凸関数である. Rothschild and Stiglitz ([1970](#ref-rothschild1970)) の定理 ([thm-mps](#thm-mps)) より, 平均保存的な広がりは凸関数の期待値を下げない. したがって右辺は上方 (少なくとも同水準) にシフトし, [式 eq-reservation](#eq-reservation) の解 \\w^\*\\ は上がる.

## A.6 留保賃金方程式のオプション価値項

サーチ理論の章の [命題 prp-mccall-cs](#prp-mccall-cs) (留保賃金の比較静学) では, 留保賃金方程式のオプション価値項

\\ H\left(x\right) := \int\_{x}^{\infty} \left(w - x\right) dF\left(w\right) \\

を閾値 \\x\\ で微分して \\H'\left(x\right) = -\left(1 - F\left(x\right)\right)\\ を使いました. ここではこれを証明します. \\x\\ は積分の下端と被積分関数の両方に現れるので, ライプニッツ則 (積分記号下の微分) の出番です. 積分区間が無限に伸びていることが唯一の注意点で, 上端からの寄与を心配する必要はない代わりに, 微分と積分の交換を正当化する条件が要ります.

**補題 A.1 (オプション価値項の微分)** \\F\\ を分布関数とし, \\\mathbb{E}\left\[w\right\] = \int w \\ dF\left(w\right) \< \infty\\ とする. このとき \\H\left(x\right) = \int\_{x}^{\infty}\left(w - x\right) dF\left(w\right)\\ はすべての \\x\\ で有限であり, \\F\\ が \\x\\ に質点を持たない (すなわち \\F\\ が \\x\\ で連続な) 各点で微分可能で

\\ H'\left(x\right) = -\left(1 - F\left(x\right)\right) \\

が成り立つ. とくに \\F\\ の台が有界ならば, 前提はつねに満たされる.

*Proof*. Step1 (有限性): \\0 \leq \left(w - x\right)\mathbb{1}\left\\w \> x\right\\ \leq \left\|w\right\| + \left\|x\right\|\\ であり, 右辺は \\\mathbb{E}\left\[w\right\] \< \infty\\ より可積分である. よって \\H\left(x\right)\\ は有限である.

Step2 (ライプニッツ則): \\F\\ が密度 \\f\\ を持つ場合を考える. 端点が動く積分に対するライプニッツ則は

\\ \frac{d}{dx} \int\_{a\left(x\right)}^{b\left(x\right)} g\left(w, x\right) dw = g\left(b\left(x\right), x\right) b'\left(x\right) - g\left(a\left(x\right), x\right) a'\left(x\right) + \int\_{a\left(x\right)}^{b\left(x\right)} \frac{\partial g}{\partial x}\left(w, x\right) dw \\

である. 境界の2項は「端が動いた分だけ積分区間に出入りする短冊の面積」であり, その大きさは端における被積分関数の値に端の動く速さを掛けたものになる.

いまの場合 \\g\left(w, x\right) = \left(w - x\right) f\left(w\right)\\, \\a\left(x\right) = x\\, \\b\left(x\right) = \infty\\ である. 上端は \\x\\ に依存しない定数なので, 動かない端からは短冊が出入りせず, 上端の境界項はそもそも現れない.[^2] 下端については \\a'\left(x\right) = 1\\ であるが, 被積分関数が \\w = x\\ でちょうどゼロになるため

\\ - g\left(x, x\right) a'\left(x\right) = -\left(x - x\right) f\left(x\right) = 0 \\

と消える. 残る積分項は \\\partial g / \partial x = -f\left(w\right)\\ より

\\ \int\_{x}^{\infty} \frac{\partial g}{\partial x}\left(w, x\right) dw = -\int\_{x}^{\infty} f\left(w\right) dw = -\left(1 - F\left(x\right)\right) \\

である.

Step3 (交換の正当化): 有限区間であれば微分と積分の交換は被積分関数の連続性から従うが, 積分区間が無限のときは広義積分の極限と微分の極限を入れ替えることになるため, 優関数が必要である. ここでは \\x\\ を含む任意の近傍上で

\\ \left\|\frac{\partial}{\partial x}\left(w - x\right)\right\| = 1, \qquad \int 1 \\ dF\left(w\right) = 1 \< \infty \\

であり, 定数関数 \\1\\ が優関数として使える. よって優収束定理から交換が許され, Step2 の計算が正当化される.

Step4 (密度を仮定しない場合): \\F\\ が密度を持たなくても結論は変わらない. \\H\left(x\right) = \mathbb{E}\left\[\max\left\\w - x, 0\right\\\right\]\\ と書き, \\h \> 0\\ に対して差分を場合分けすると

\\ H\left(x + h\right) - H\left(x\right) = -h \left(1 - F\left(x + h\right)\right) - \int\_{\left(x,\\ x + h\right\]} \left(w - x\right) dF\left(w\right) \\

が厳密に成り立つ. 右辺第2項は \\0\\ 以上 \\h \left(F\left(x + h\right) - F\left(x\right)\right)\\ 以下なので, 差分商は

\\ -\left(1 - F\left(x\right)\right) \leq \frac{H\left(x + h\right) - H\left(x\right)}{h} \leq -\left(1 - F\left(x + h\right)\right) \\

に挟まれる. \\F\\ は右連続だから \\h \downarrow 0\\ で両端が \\-\left(1 - F\left(x\right)\right)\\ に収束し, 右微分係数が定まる. 左からの差分商についても同様に計算すると極限は \\-\left(1 - F\left(x^{-}\right)\right)\\ となるので, 両側微分が一致するのは \\F\left(x^{-}\right) = F\left(x\right)\\, すなわち \\F\\ が \\x\\ に質点を持たないときである.

\\H\\ が \\x\\ について非増加であることは \\H'\left(x\right) \leq 0\\ から, 凸であることは \\H'\left(x\right) = -\left(1 - F\left(x\right)\right)\\ が \\x\\ について非減少であることから分かります. なお [命題 prp-mccall-cs](#prp-mccall-cs) の (2) で使うのは, 同じ被積分関数 \\\max\left\\w - x, 0\right\\\\ が \\w\\ について凸であるという別の性質で, そちらは平均保存的な広がりのもとでの期待値の単調性から従います.

## A.7 平均保存的な広がりと凸順序

[命題 prp-mccall-cs](#prp-mccall-cs) の (2) は, 「オファー分布の平均が同じでも分散が大きければ留保賃金は上がる」という主張でした. 証明では, 待つことのオプション価値 \\\mathbb{E}\left\[\max\left\\w - w^\*, 0\right\\\right\]\\ が被積分関数の凸性ゆえに広がりとともに増える, という事実を使っていました.

**定理 A.3 (平均保存的な広がりと凸順序, Rothschild and Stiglitz ([1970](#ref-rothschild1970)))** 平均の等しい2つの分布 \\F\\ と \\G\\ について, 次の3条件は同値である.

1.  \\X \sim F\\ と \\\mathbb{E}\left\[\varepsilon \mid X\right\] = 0\\ を満たすノイズ \\\varepsilon\\ を用いて \\X + \varepsilon \sim G\\ と書ける. このとき \\G\\ は \\F\\ の平均保存的な広がり (mean-preserving spread) であるという.
2.  期待値の存在する任意の凸関数 \\\varphi\\ について \\\mathbb{E}\_G\left\[\varphi\left(w\right)\right\] \geq \mathbb{E}\_F\left\[\varphi\left(w\right)\right\]\\ が成り立つ.
3.  すべての \\x\\ について \\\int\_{-\infty}^{x}\left(F\left(t\right) - G\left(t\right)\right) dt \leq 0\\ が成り立つ.

*Proof*. ここでは [命題 prp-mccall-cs](#prp-mccall-cs) で使う 1 \\\Rightarrow\\ 2 の向きだけを示す. \\X \sim F\\, \\\mathbb{E}\left\[\varepsilon \mid X\right\] = 0\\, \\X + \varepsilon \sim G\\ とする. \\\varphi\\ が凸なら, \\X\\ で条件付けた上でイェンセンの不等式を適用して

\\ \mathbb{E}\left\[\varphi\left(X + \varepsilon\right) \mid X\right\] \geq \varphi\left(\mathbb{E}\left\[X + \varepsilon \mid X\right\]\right) = \varphi\left(X\right) \\

が得られる. 両辺の期待値を取れば \\\mathbb{E}\_G\left\[\varphi\right\] = \mathbb{E}\left\[\varphi\left(X + \varepsilon\right)\right\] \geq \mathbb{E}\left\[\varphi\left(X\right)\right\] = \mathbb{E}\_F\left\[\varphi\right\]\\ である.

残りの向きは非自明である. 2 \\\Rightarrow\\ 1 は, 与えられた凸順序を実現する結合の存在を主張するもので, Strassen の定理による ([Strassen 1965](#ref-strassen1965)). 2 \\\Leftrightarrow\\ 3 は部分積分による書き換えで, Rothschild and Stiglitz ([1970](#ref-rothschild1970)) にある.

## A.8 標本統計量の影響関数

[sec-md](#sec-md) 節 のターゲットは, 労働時間の平均 \\\bar{h}\\ と標準偏差 \\s_h\\, 対数月収の標準偏差 \\s_y\\, 両者の相関 \\r\_{hy}\\, 40時間ちょうどの割合 \\\bar{d}\\ の5本でした. 標本平均そのものは1本目と5本目で, 残りの3本は標本平均の非線形な関数です. その分散共分散行列をデルタ法で導きます. 出発点は, 個人 \\i\\ から作れる6つの量です.

\\ a_i = \left(h_i,\\ h_i^2,\\ y_i,\\ y_i^2,\\ h_i y_i,\\ d_i\right)^\top, \qquad \bar{a} = \frac{1}{N}\sum\_{i=1}^{N} a_i \tag{A.2}\\

5本のモーメントは, どれもこの標本平均の関数として書けます.

\\ \hat{m} = \phi\left(\bar{a}\right), \qquad \phi\left(a\right) = \left(a_1,\\ \sqrt{a_2 - a_1^2},\\ \sqrt{a_4 - a_3^2},\\ \frac{a_5 - a_1 a_3}{\sqrt{\left(a_2 - a_1^2\right)\left(a_4 - a_3^2\right)}},\\ a_6\right)^\top \tag{A.3}\\

\\\bar{a}\\ は標本平均なので中心極限定理がそのまま使えます. \\\mu_a = \mathbb{E}\left\[a_i\right\]\\, \\\Sigma_a = \operatorname{Var}\left(a_i\right)\\ として \\\sqrt{N}\left(\bar{a} - \mu_a\right) \xrightarrow{d} \mathcal{N}\left(0, \Sigma_a\right)\\ です. あとは \\\phi\\ を通すだけで, \\D = \partial \phi / \partial a^\top\\ を \\\mu_a\\ で評価した \\5 \times 6\\ 行列とすると

\\ \sqrt{N}\left(\hat{m} - m\right) \xrightarrow{d} \mathcal{N}\left(0,\\ D\\ \Sigma_a\\ D^\top\right) \tag{A.4}\\

となります. これがデルタ法です. ここで \\\xi_i = D\left(a_i - \mu_a\right)\\ と置くと, [式 eq-apdx-if-delta](#eq-apdx-if-delta) の分散は \\\operatorname{Var}\left(\xi_i\right)\\ そのもので, \\\hat{m} - m \simeq \frac{1}{N}\sum_i \xi_i\\ と, 推定誤差が個人ごとの寄与の平均として書けます. この \\\xi_i\\ を影響関数 (influence function) と呼びます. 行列 \\D\\ と \\\Sigma_a\\ を別々に持つ代わりに \\\xi_i\\ を1本の列として持てば, 実装は標本分散共分散を1回取るだけになります.

\\D\\ を計算します. 第1行は \\\phi_1 = a_1\\ なので \\\partial \phi_1 / \partial a = \left(1, 0, 0, 0, 0, 0\right)\\, すなわち

\\ \xi\_{1i} = h_i - \mathbb{E}\left\[h\right\] \\

です. 第5行の指標も同じで, \\\xi\_{5i} = d_i - \mathbb{E}\left\[d\right\]\\ です. 第2行は \\\phi_2 = \left(a_2 - a_1^2\right)^{1/2}\\ の微分です. 分母に現れる \\\sqrt{a_2 - a_1^2}\\ を \\\mu_a\\ で評価したものは \\h\\ の母標準偏差, つまりターゲットの2本目 \\m_2 = \phi_2\left(\mu_a\right)\\ そのものなので, それで書くと

\\ \frac{\partial \phi_2}{\partial a_1} = \frac{-a_1}{\sqrt{a_2 - a_1^2}} = -\frac{\mathbb{E}\left\[h\right\]}{m_2}, \qquad \frac{\partial \phi_2}{\partial a_2} = \frac{1}{2\sqrt{a_2 - a_1^2}} = \frac{1}{2 m_2} \\

なので, 2つの成分を合わせて

\\ \xi\_{2i} = -\frac{\mathbb{E}\left\[h\right\]}{m_2}\left(h_i - \mathbb{E}\left\[h\right\]\right) + \frac{1}{2 m_2}\left(h_i^2 - \mathbb{E}\left\[h^2\right\]\right) \tag{A.5}\\

となります. 第2項を平均のまわりで書き直すと \\h_i^2 - \mathbb{E}\left\[h^2\right\] = \left(h_i - \mathbb{E}\left\[h\right\]\right)^2 - m_2^2 + 2\\ \mathbb{E}\left\[h\right\] \left(h_i - \mathbb{E}\left\[h\right\]\right)\\ なので, これを [式 eq-apdx-if-psi2-raw](#eq-apdx-if-psi2-raw) に代入すると第1項がちょうど打ち消えて

\\ \xi\_{2i} = \frac{\left(h_i - \mathbb{E}\left\[h\right\]\right)^2 - m_2^2}{2\\ m_2} \tag{A.6}\\

が残ります. 平均を推定したことによる誤差が, 標準偏差の影響関数には残らないということです. 第3行も \\h\\ を \\y\\ に, \\m_2\\ を \\m_3\\ に置き換えれば同じ形になります.

第4行の相関も同じ手続きですが, \\\phi_4\\ が5つの成分に依存するので項が増えます. 標準化した値 \\u_i = \left(h_i - \mathbb{E}\left\[h\right\]\right)/m_2\\, \\v_i = \left(y_i - \mathbb{E}\left\[y\right\]\right)/m_3\\ を使うと, 整理した結果は次の形にまとまります.

\\ \xi\_{4i} = u_i v_i - m_4 - \frac{m_4}{2}\left(u_i^2 - 1\right) - \frac{m_4}{2}\left(v_i^2 - 1\right) \tag{A.7}\\

第1項は共分散の影響関数で, 残りの2項は分母の2つの標準偏差を推定したことの効果です. 相関は標準偏差で割った量なので, 分母の推定誤差も相関の推定誤差に効いてくる, ということです.

実装では母数を標本の値に置き換えて \\\hat\xi_i\\ を作り, その標本分散共分散を \\N\\ で割ります ([式 eq-ls-vhat](#eq-ls-vhat)).

## A.9 Goussé, Jacquemet, Robin (2017) の式の導出

[sec-search-matching](#sec-search-matching) 章 の Goussé et al. ([2017](#ref-gousse2017)) のモデルについて, 本文で結果だけを示した式を導きます. 記号は本文のとおりで, 男性のタイプを \\i\\, 女性のタイプを \\j\\, マッチの質を \\z\\ とし, 混乱の恐れがないところではタイプの引数を省きます.

### A.9.1 コミットメントのない結婚の価値

まず, コミットメントのない結婚の純価値を与える [式 eq-gousse-nocommit](#eq-gousse-nocommit) を, 既婚者の価値の HJB 方程式 [式 eq-gousse-married](#eq-gousse-married) から導きます. コミットメントがないので, 契約の価値 \\W_m\left(i, j, z\right)\\ は継続価値 \\V_m^1\left(i, j, z\right)\\ に等しくなければなりません. 以下ではタイプの引数 \\\left(i, j\right)\\ を省き, \\u_m = u_m\left(i, j, z\right)\\ と書きます. [式 eq-gousse-married](#eq-gousse-married) に \\W_m = V_m^1\left(z\right)\\ を代入した

\\ r V_m^1\left(z\right) = u_m + \delta \int \left\[\max\left\\V_m^0, V_m^1\left(z'\right)\right\\ - V_m^1\left(z\right)\right\] dG\left(z'\right) \\

から出発します.

まず, 自明に次の表現を得ます. \\ \max\left\\V_m^0, V_m^1\left(z'\right)\right\\ = V_m^0 + \left\[V_m^1\left(z'\right) - V_m^0\right\]^{+}. \\

これを [式 eq-gousse-nocommit](#eq-gousse-nocommit) に代入すると, 次の式が得られます. \\ \begin{aligned} r V_m^1\left(z\right) &= u_m + \delta \int \left\[V_m^0 + \left\[V_m^1\left(z'\right) - V_m^0\right\]^{+} - V_m^1\left(z\right)\right\] dG\left(z'\right) \\ &= u_m + \delta V_m^0 + \delta \int \left\[V_m^1\left(z'\right) - V_m^0\right\]^{+} dG\left(z'\right) - \delta V_m^1\left(z\right) \end{aligned} \\

\\\delta V_m^1\left(z\right)\\ を左辺に移して, \\(r+\delta)V_m^0\\ を引くと, 次の式を得ます.

\\ \left(r + \delta\right)\left\[V_m^1\left(z\right) - V_m^0\right\] = u_m + \delta \int \left\[V_m^1\left(z'\right) - V_m^0\right\]^{+} dG\left(z'\right) - r V_m^0. \\

### A.9.2 余剰の方程式

本文の間接効用の特定化 \\\psi_i\left(R, q\right) = q\left(R - A_i\right)/B_i\\ のもとで, 夫婦のフロー効用は \\u_m = z F\_{ij}\left(R_m - A_i\right)/B_i\\, \\u_f = z F\_{ij}\left(R_f - A_j\right)/B_j\\ です. 価格指数で重みづけて足すと

\\ B_i u_m + B_j u_f = z F\_{ij}\left(R_m + R_f - A_i - A_j\right) =: z F\_{ij} X\_{ij} \\ となり, 移転 \\\left(t_m, t_f\right)\\ が消えます. \\X\_{ij} = w_i\left(1 - d_m\right) + w_j\left(1 - d_f\right) - C\_{ij} - A_i - A_j\\ は, 世帯の私的支出から最低私的支出を差し引いた純私的支出で, 分配には依存しません.

余剰を \\S\_{ij}\left(z\right) := B_i\left\[V_m^1\left(z\right) - V_m^0\right\] + B_j\left\[V_f^1\left(z\right) - V_f^0\right\]\\ と定義します. TU のもとで Nash 交渉の解は余剰を交渉力の比で分けるので, 次の式を得ます.

\\ B_i\left\[V_m^1\left(z\right) - V_m^0\right\] = \beta\\ S\_{ij}\left(z\right), \qquad B_j\left\[V_f^1\left(z\right) - V_f^0\right\] = \left(1 - \beta\right) S\_{ij}\left(z\right) \tag{A.8}\\

したがって夫婦がともに結婚を続けることに合意するのは \\S\_{ij}\left(z\right) \geq 0\\ のときで, 正の部分についても \\B_i\left\[V_m^1\left(z'\right) - V_m^0\right\]^{+} = \beta\\ S\_{ij}\left(z'\right)^{+}\\, 女性側は \\\left(1 - \beta\right) S\_{ij}\left(z'\right)^{+}\\ です.

男性の [式 eq-gousse-nocommit](#eq-gousse-nocommit) を \\B_i\\ 倍, 女性側の同じ式を \\B_j\\ 倍して足します. 左辺は \\\left(r + \delta\right) S\_{ij}\left(z\right)\\, 右辺のフロー効用の和は上の \\z F\_{ij} X\_{ij}\\, 積分の中は \\\beta S^{+} + \left(1 - \beta\right) S^{+} = S\_{ij}\left(z'\right)^{+}\\ にまとまるので, 次の式を得ます.

\\ \left(r + \delta\right) S\_{ij}\left(z\right) = z F\_{ij} X\_{ij} - B_i\\ r V_m^0 - B_j\\ r V_f^0 + \delta \int S\_{ij}\left(z'\right)^{+} dG\left(z'\right) \\

### A.9.3 家事時間の効率性条件

夫婦は Nash 交渉で家事時間 \\\left(d_m, d_f\right)\\ と移転 \\\left(t_m, t_f\right)\\ を選びます. TU のもとでは Nash 交渉の解は「まず余剰 \\S\_{ij}\left(z\right)\\ を最大化し, 次にそれを [式 eq-apdx-nash-split](#eq-apdx-nash-split) の比で分ける」と2段階に分かれます. 余剰の方程式で \\\left(d_m, d_f\right)\\ に依存するのは今期のフロー \\z F\_{ij}\left(d_m, d_f\right) X\_{ij}\left(d_m, d_f\right)\\ だけです. 独身の価値 \\V_m^0, V_f^0\\ は結婚市場の状態で決まる所与の量であり, 継続価値の項は引き直された \\z'\\ のもとで改めて選ばれる配分の価値なので, 今期の家事時間には依存しません. 移転は \\X\_{ij}\\ に入らないので, 家事時間の問題は

\\ \max\_{d_m, d_f}\\ F\_{ij}\left(d_m, d_f\right)\\ X\_{ij}\left(d_m, d_f\right), \qquad X\_{ij} = w_i\left(1 - d_m\right) + w_j\left(1 - d_f\right) - C\_{ij} - A_i - A_j \\

という静学的な問題に落ちます. \\z\\ は掛け算の定数なので解に影響せず, これが本文で再帰性と呼んだ性質です. 一階条件は, \\\partial X\_{ij} / \partial d_m = -w_i\\ を使って

\\ \frac{\partial F\_{ij}}{\partial d_m} X\_{ij} - w_i F\_{ij} = 0 \quad\Longleftrightarrow\quad \frac{1}{w_i}\frac{\partial \ln F\_{ij}}{\partial d_m} = \frac{1}{X\_{ij}}, \\

女性側も同様に \\\frac{1}{w_j}\frac{\partial \ln F\_{ij}}{\partial d_f} = \frac{1}{X\_{ij}}\\ です. 2本を並べれば本文の効率性条件

\\ \frac{1}{w_i}\frac{\partial \ln F\_{ij}}{\partial d_m} = \frac{1}{w_j}\frac{\partial \ln F\_{ij}}{\partial d_f} \\

になります. 左右はそれぞれ「家事時間を1単位増やしたときの公共財の増加率を, その時間の機会費用 (賃金) で割ったもの」で, 家事1円あたりの限界生産性が夫婦で等しい, という標準的な効率性条件です.

Stone-Geary 型 \\F\_{ij} = Z\_{ij}\left(d_m - D_m\right)^{K_m}\left(d_f - D_f\right)^{K_f}\\ では \\\partial \ln F\_{ij} / \partial d_m = K_m / \left(d_m - D_m\right)\\ なので, 一階条件は \\d_m - D_m = K_m X\_{ij} / w_i\\, \\d_f - D_f = K_f X\_{ij} / w_j\\ と解けます. これを \\X\_{ij}\\ の定義に戻すと \\X\_{ij} = w_i\left(1 - D_m\right) + w_j\left(1 - D_f\right) - C\_{ij} - A_i - A_j - \left(K_m + K_f\right) X\_{ij}\\ なので,

\\ X\_{ij} = \frac{w_i\left(1 - D_m\right) + w_j\left(1 - D_f\right) - C\_{ij} - A_i - A_j}{1 + K_m + K_f} \tag{A.9}\\

と純私的支出が閉じた形で決まり, 家事時間もそれに \\K / w\\ を掛けたものとして決まります. ここから本文の比較静学が読めます. 夫の賃金 \\w_i\\ が上がると \\X\_{ij} / w_i\\ は下がり (分子の \\w_i\\ を含まない部分が正なら), 夫の家事時間は減ります. 妻の最低投入時間 \\D_f\\ が大きい (家族観が保守的) と \\X\_{ij}\\ が \\w_j / \left(1 + K_m + K_f\right)\\ だけ下がるので, 夫の家事時間 \\D_m + K_m X\_{ij} / w_i\\ は減り, 妻の家事時間 \\D_f + K_f X\_{ij} / w_j\\ は \\D_f\\ の直接の増加が \\X\_{ij}\\ を通じた減少 (\\K_f / \left(1 + K_m + K_f\right) \< 1\\) を上回るので増えます.

独身者の家事時間も同じ形で決まります. 本文の \\u_m^0\left(i\right) = \max_d \psi_i\left(w_i\left(1 - d\right), F_i^0\left(d\right)\right)\\ の一階条件は \\\frac{1}{w_i}\frac{\partial \ln F_i^0}{\partial d} = \frac{1}{w_i\left(1 - d\right) - A_i}\\ で, 分配の相手がいない分だけ右辺の純私的支出が本人のものだけになります. \\F_i^0\left(d\right) = \left(d - D_m^0\right)^{K_m^0}\\ を代入すると \\K_m^0 \left(w_i\left(1 - d\right) - A_i\right) = w_i\left(d - D_m^0\right)\\ なので,

\\ d_m^0 = D_m^0 + \frac{K_m^0}{1 + K_m^0}\left(1 - D_m^0 - \frac{A_i}{w_i}\right) \\

と閉じた形で決まります (女性も同様).

### A.9.4 独身の価値

独身男性の HJB 方程式 [式 eq-gousse-single](#eq-gousse-single) の両辺を \\B_i\\ 倍し, 正の部分に [式 eq-apdx-nash-split](#eq-apdx-nash-split) を使うと

\\ B_i\\ r V_m^0 = B_i u_m^0 + \lambda \iint \beta\\ S\_{ij}\left(z\right)^{+} n_f\left(j\right)\\ dG\left(z\right)\\ dj = B_i u_m^0 + \lambda \beta \int \bar{S}\_{ij}\\ n_f\left(j\right)\\ dj \\

となります. ここで \\\bar{S}\_{ij} := \int S\_{ij}\left(z\right)^{+} dG\left(z\right)\\ は正の部分の期待余剰です. 女性側は \\\beta\\ を \\1 - \beta\\ に, \\n_f\\ を \\n_m\\ に替えれば同じ形です. 余剰の方程式と合わせると, \\\left(S\_{ij}, V_m^0, V_f^0\right)\\ はタイプの組ごとに連立する線形の積分方程式系になります.

### A.9.5 Sharing rule

夫が受け取る純私的支出のシェアを \\\beta\_{ij}\left(z\right) := B_i u_m = \left(R_m - A_i\right) / X\_{ij}\\ と定義します. フロー効用の式から \\B_i u_m = z F\_{ij}\left(R_m - A_i\right)\\ なので, \\\beta\_{ij}\left(z\right) = B_i u_m / \left(z F\_{ij} X\_{ij}\right)\\ です. \\B_i u_m\\ は2通りに書けます. 男性の [式 eq-gousse-nocommit](#eq-gousse-nocommit) に [式 eq-apdx-nash-split](#eq-apdx-nash-split) を入れると

\\ \left(r + \delta\right)\beta\\ S\_{ij}\left(z\right) = B_i u_m + \delta \beta \int S\_{ij}\left(z'\right)^{+} dG\left(z'\right) - B_i\\ r V_m^0, \\

一方, [式 eq-gousse-surplus](#eq-gousse-surplus) を \\\beta\\ 倍すると

\\ \left(r + \delta\right)\beta\\ S\_{ij}\left(z\right) = \beta z F\_{ij} X\_{ij} - \beta B_i\\ r V_m^0 - \beta B_j\\ r V_f^0 + \delta \beta \int S\_{ij}\left(z'\right)^{+} dG\left(z'\right). \\

2式の右辺を等しいとおくと積分の項が消え,

\\ B_i u_m = \beta\\ z F\_{ij} X\_{ij} + \left(1 - \beta\right) B_i\\ r V_m^0 - \beta B_j\\ r V_f^0 \\

を得ます. 両辺を \\z F\_{ij} X\_{ij}\\ で割れば本文の sharing rule

\\ \beta\_{ij}\left(z\right) = \beta + \frac{\left(1 - \beta\right) B_i\\ r V_m^0 - \beta B_j\\ r V_f^0}{z F\_{ij} X\_{ij}} \\

です. 第1項が Nash ウェイト, 第2項が外部機会の差で, 分母に \\z\\ が入るので同じタイプの夫婦でも \\z\\ が高いほどシェアは \\\beta\\ に近づきます. 外部機会の差はフローの水準として一定なのに, 分けるべきパイ \\z F\_{ij} X\_{ij}\\ が大きくなるからです.

### A.9.6 推定の手順

本文で3段階にまとめた推定手順を, 式のレベルで説明します. 論文の本文 6.3 節, 付録 B (識別), 付録 C (推定), 付録 D (数値計算) に基づきます ([Goussé et al. 2017](#ref-gousse2017)). 以下では夫婦の家庭内生産のパラメータを本文どおり \\\left(D_m, D_f, K_m, K_f\right)\\, 独身のものを \\\left(D_m^0, D_f^0, K_m^0, K_f^0\right)\\ と書きます. \\F\_{ij}\\ はマッチの質 \\z\\ を掛ける前の夫婦の生産 (均衡での値) を表します. 割引率 \\r\\ は推定の対象ではなく, 所与として扱います.

**データと離散化.** 標本は BHPS の1991-2008年で, 22歳未満と50歳超を除きます. これを 91-93, 94-96, 97-99, 00-02, 03-05, 06-08 の3年ごとの6期間に分け, 各期間を「タイプの分布だけが異なる別々の定常状態」からの標本とみなします. 構造パラメータは全期間で共通です. タイプ \\i, j\\ は (学歴, 賃金, 家族観指数) の組で, 学歴3区分 (O-level, A-level, 高等教育) \\\times\\ 賃金の Chebyshev 節点16 \\\times\\ 家族観指数の Chebyshev 節点8 の格子に離散化します. 観察するのは, 独身者の家事時間 \\d^0\\ と労働時間 \\h^0\\, 夫婦それぞれの \\d_m, d_f, h_m, h_f\\ で, 余暇は \\e = 1 - d - h\\ として作ります.

#### 第1段階: 出会い率・引き直し率・マッチング確率

**ストックとフロー.** 各期間について, 3年分の横断面をプールし, 独身男性・独身女性・夫婦のストックの分布 \\n_m\left(i\right)\\, \\n_f\left(j\right)\\, \\m\left(i, j\right)\\ を上の格子上でカーネル密度推定します. フローは連続する2年の状態の遷移を数えて作ります. たとえば「1994年に独身で1995年に既婚」の人数が1994年の結婚フロー, 「1993年に既婚で1994年に独身」の人数が1994年の離婚フローです. これを3年分足して期間のフローとします. フローの標本は小さいので, フローだけは学歴のみで集計します.

**フローとマッチング確率の関係.** 独身の男女は率 \\\lambda\\ で出会い, 確率 \\\alpha\_{ij}\\ で結婚します. 結婚している夫婦は率 \\\delta\\ で \\z\\ を引き直し, 確率 \\1 - \alpha\_{ij}\\ で離婚します. よって単位時間あたりのフローは

\\ MF\left(i, j\right) = \lambda\\ n_m\left(i\right) n_f\left(j\right) \alpha\_{ij}, \qquad DF\left(i, j\right) = \delta\\ m\left(i, j\right) \left(1 - \alpha\_{ij}\right) \tag{A.10}\\

です ([Goussé et al. 2017](#ref-gousse2017), eqs. B.1-B.2). 結婚率 \\MR\left(i, j\right) := MF\left(i, j\right) / \left\[n_m\left(i\right) n_f\left(j\right)\right\]\\ と離婚率 \\DR\left(i, j\right) := DF\left(i, j\right) / m\left(i, j\right)\\ を定義すると, [式 eq-apdx-gousse-flows](#eq-apdx-gousse-flows) は \\MR / \lambda = \alpha\_{ij}\\, \\DR / \delta = 1 - \alpha\_{ij}\\ と書けます. 2本を足すと \\\alpha\_{ij}\\ が消え,

\\ \frac{MR\left(i, j\right)}{\lambda} + \frac{DR\left(i, j\right)}{\delta} = 1 \tag{A.11}\\

を得ます ([Goussé et al. 2017](#ref-gousse2017), eq. B.3). 同じ \\z\\ の引き直しが結婚と離婚の両方を決めているから, この制約が出てきます.

**\\\left(\xi, \delta\right)\\ の OLS.** 出会い率は Cobb-Douglas のマッチング関数 \\\lambda = \xi\left(N_m N_f\right)^{-1/2}\\ なので, [式 eq-apdx-gousse-mrdr](#eq-apdx-gousse-mrdr) は

\\ 1 = \frac{1}{\xi} \left\[\left(N_m N_f\right)^{1/2} MR\left(i, j\right)\right\] + \frac{1}{\delta}\\ DR\left(i, j\right) \\

という, 被説明変数が定数1で定数項のない線形回帰になります. 係数 \\1 / \xi\\ と \\1 / \delta\\ を OLS で推定します. \\\alpha\_{ij}\\ がタイプの組によって異なる限り2つの説明変数は共線にならないので, この回帰で識別できます. 推定には中間の4期間 (94-96 から 03-05) をプールし, 両端の2期間は使いません. 1991年は前年の状態がないので離婚フローが, 2008年は翌年の状態がないので結婚フローが作れないからです. 生存時間モデルを使わないのは, 結婚期間にも独身期間にも打ち切りがあるためです. 推定値は \\\hat\xi = 0.151\\, \\\hat\delta = 0.0378\\ です. 出会いの間隔は中央値で約4.5年, \\z\\ の引き直しの間隔は中央値で約18年に対応します.

**マッチング確率.** \\\lambda\\ と \\\delta\\ が分かれば, [式 eq-apdx-gousse-mrdr](#eq-apdx-gousse-mrdr) の2つの項からフローだけで \\\alpha\_{ij} = \delta MR / \left(\delta MR + \lambda DR\right)\\ とも書けます ([Goussé et al. 2017](#ref-gousse2017), eq. B.4). しかし論文は, 流入と流出が等しい (\\MF = DF\\) という定常状態の条件 [式 eq-gousse-steady](#eq-gousse-steady) を \\\alpha\_{ij}\\ について解いた

\\ \alpha\_{ij} = \frac{\delta\\ m\left(i, j\right)}{\delta\\ m\left(i, j\right) + \lambda\\ n_m\left(i\right) n_f\left(j\right)} \tag{A.12}\\

を使います ([Goussé et al. 2017](#ref-gousse2017), eq. 6.14). 理由は2つあります. 第1に, 家計が定常状態の分布を前提に期待を形成するというモデルの仮定と整合的です. 第2に, フローよりストックの標本の方がはるかに大きいので, 精度よく推定できます. 論文はこの \\\hat\alpha\_{ij}\\ を「制約なしの (unconstrained)」マッチング確率と呼び, 本文の [図 fig-gousse2017-table2](#fig-gousse2017-table2) はこれを集計したものです. [式 eq-gousse-alpha-stock](#eq-gousse-alpha-stock) はモデルの経済的なメカニズム (価値関数) を一切使っていない点に注意してください.

#### 準備: \\\alpha\_{ij}\\ から外部機会と家庭内生産の水準を求める

第2段階と第3段階の両方で, 独身の価値 \\B_i r V_m^0\\, \\B_j r V_f^0\\ と夫婦の家庭内生産の水準 \\F\_{ij} X\_{ij}\\ が必要になります. これらは, パラメータ \\\left(\beta, \sigma, D, K, C, A, B\right)\\ と第1段階の \\\alpha\_{ij}\\, \\n_m\\, \\n_f\\ が与えられれば, \\Z\_{ij}\\ を知らなくても計算できます. その手順をまとめます.

**マッチの質の分布.** \\G\\ は \\\ln z \sim \mathcal{N}\left(0, \sigma^2\right)\\ の対数正規分布です. 平均を0とするのは, 0でない平均は \\Z\_{ij}\\ に吸収されるからです. 以下で \\\overline{G}\left(s\right) := \int \left(z - s\right)^{+} dG\left(z\right)\\ を使います. 対数正規分布では, 標準正規分布の CDF を \\\Phi\\ として

\\ G\left(s\right) = \Phi\left(\frac{\ln s}{\sigma}\right), \qquad \overline{G}\left(s\right) = e^{\sigma^2 / 2}\\ \Phi\left(-\frac{\ln s}{\sigma} + \sigma\right) - s\\ \Phi\left(-\frac{\ln s}{\sigma}\right) \\

です ([Goussé et al. 2017, sec. 6.1](#ref-gousse2017)). \\\overline{G}\\ は減少関数で, \\\overline{G}'\left(s\right) = -\left(1 - G\left(s\right)\right)\\ を満たします.

**Step 1: 留保値.** [式 eq-gousse-alpha-threshold](#eq-gousse-alpha-threshold) より, 留保値は

\\ \underline{z}\_{ij} = G^{-1}\left(1 - \alpha\_{ij}\right) = \exp\left(\sigma\\ \Phi^{-1}\left(1 - \alpha\_{ij}\right)\right) \\

です. \\\sigma\\ を与えれば, 第1段階の \\\alpha\_{ij}\\ からそのまま計算できます.

**Step 2: 期待余剰と外部機会の比.** \\\overline{S}\_{ij} := \int S\_{ij}\left(z'\right)^{+} dG\left(z'\right)\\ はスカラーなので, [式 eq-gousse-surplus](#eq-gousse-surplus) は

\\ \left(r + \delta\right) S\_{ij}\left(z\right) = z F\_{ij} X\_{ij} - \left(B_i r V_m^0 + B_j r V_f^0\right) + \delta\\ \overline{S}\_{ij} \\

という \\z\\ の1次式です. \\S\_{ij}\left(\underline{z}\_{ij}\right) = 0\\ で留保値を定めると

\\ \underline{z}\_{ij} = \frac{B_i r V_m^0 + B_j r V_f^0 - \delta\\ \overline{S}\_{ij}}{F\_{ij} X\_{ij}}, \qquad \alpha\_{ij} = 1 - G\left(\frac{B_i r V_m^0 + B_j r V_f^0 - \delta\\ \overline{S}\_{ij}}{F\_{ij} X\_{ij}}\right) \tag{A.13}\\

が得られ ([Goussé et al. 2017](#ref-gousse2017), eq. 5.6), 余剰は \\S\_{ij}\left(z\right) = F\_{ij} X\_{ij}\left(z - \underline{z}\_{ij}\right) / \left(r + \delta\right)\\ と書けます. これを正の部分で積分すると

\\ \overline{S}\_{ij} = \frac{F\_{ij} X\_{ij}}{r + \delta}\\ \overline{G}\left(\underline{z}\_{ij}\right) \tag{A.14}\\

です ([Goussé et al. 2017](#ref-gousse2017), eq. 5.5). [式 eq-gousse-alpha-closed](#eq-gousse-alpha-closed) の左の式を \\B_i r V_m^0 + B_j r V_f^0 = F\_{ij} X\_{ij}\\ \underline{z}\_{ij} + \delta\\ \overline{S}\_{ij}\\ と書き直し, [式 eq-gousse-sbar](#eq-gousse-sbar) で \\F\_{ij} X\_{ij} = \left(r + \delta\right) \overline{S}\_{ij} / \overline{G}\left(\underline{z}\_{ij}\right)\\ を代入すると

\\ B_i r V_m^0 + B_j r V_f^0 = \delta\\ \overline{S}\_{ij} \left\[\frac{r + \delta}{\delta} \frac{\underline{z}\_{ij}}{\overline{G}\left(\underline{z}\_{ij}\right)} + 1\right\] \\

なので, 未知の \\F\_{ij} X\_{ij}\\ を含まない関係

\\ \delta\\ \overline{S}\_{ij} = \theta\_{ij}\left(B_i r V_m^0 + B_j r V_f^0\right), \qquad \theta\_{ij} := \frac{\overline{G}\left(\underline{z}\_{ij}\right)}{\frac{r + \delta}{\delta}\\ \underline{z}\_{ij} + \overline{G}\left(\underline{z}\_{ij}\right)} \tag{A.15}\\

を得ます ([Goussé et al. 2017](#ref-gousse2017), eq. B.15). \\\theta\_{ij} \in \left\[0, 1\right\]\\ は \\\alpha\_{ij}\\ と \\\left(\sigma, r, \delta\right)\\ だけで決まる既知の数です.

**Step 3: 独身の価値を線形方程式として解く.** [式 eq-gousse-theta](#eq-gousse-theta) を [式 eq-gousse-single-value](#eq-gousse-single-value) (と女性側の対応する式) の \\\overline{S}\_{ij}\\ に代入すると

\\ \begin{aligned} B_i r V_m^0 &= B_i u_m^0 + \frac{\lambda \beta}{\delta} \int \left(B_i r V_m^0 + B_j r V_f^0\right) \theta\_{ij}\\ n_f\left(j\right) dj, \\ B_j r V_f^0 &= B_j u_f^0 + \frac{\lambda \left(1 - \beta\right)}{\delta} \int \left(B_i r V_m^0 + B_j r V_f^0\right) \theta\_{ij}\\ n_m\left(i\right) di \end{aligned} \tag{A.16}\\

となります ([Goussé et al. 2017](#ref-gousse2017), eqs. C.2-C.3). ここで独身のフロー効用は, [式 eq-gousse-utility](#eq-gousse-utility) で \\R - A_i = X_i^0\\, \\q = F_i^0\left(d_m^0\right)\\ とおいたものです. 独身の家事時間の閉じた形 ([sec-apdx-gousse-housework](#sec-apdx-gousse-housework) 節の末尾) を使うと

\\ X_i^0 := \frac{w_i\left(1 - D_m^0\right) - A_i}{1 + K_m^0}, \qquad d_m^0 = D_m^0 + \frac{K_m^0 X_i^0}{w_i}, \qquad B_i u_m^0 = \left(\frac{K_m^0 X_i^0}{w_i}\right)^{K_m^0} X_i^0 \tag{A.17}\\

です (\\R - A_i = w_i\left(1 - d_m^0\right) - A_i = X_i^0\\ は \\d_m^0\\ を代入すれば確かめられます) ([Goussé et al. 2017](#ref-gousse2017), eqs. 6.6, 6.9). \\B_i u_m^0\\, \\\theta\_{ij}\\, \\n_m\\, \\n_f\\ がすべて既知なので, [式 eq-gousse-fredholm](#eq-gousse-fredholm) は未知関数 \\B_i r V_m^0\\, \\B_j r V_f^0\\ についての**線形**の積分方程式 (第2種 Fredholm 方程式) です. 右辺の積分作用素が縮小写像なら解は一意で, その十分条件は \\\lambda \beta \int \theta\_{ij} n_f\left(j\right) dj \< \delta\\ と \\\lambda \left(1 - \beta\right) \int \theta\_{ij} n_m\left(i\right) di \< \delta\\ です ([Goussé et al. 2017](#ref-gousse2017), Appendix B). この方程式に \\Z\_{ij}\\ は現れません.

**離散化した解法.** タイプを格子点 \\i, j\\ に離散化し, 積分を Clenshaw-Curtis 求積の重み \\\omega_i, \omega_j\\ による和で置き換えます. 行列

\\ \Theta_m = -\frac{\lambda \beta}{\delta}\left\[\theta\_{ij}\\ n_f\left(j\right) \omega_j\right\]\_{i, j}, \qquad \Theta_f = -\frac{\lambda \left(1 - \beta\right)}{\delta}\left\[\theta\_{ij}\\ n_m\left(i\right) \omega_i\right\]\_{j, i}, \\

\\ \Lambda_m = I - \frac{\lambda \beta}{\delta}\\ \mathrm{diag}\left(\sum_j \theta\_{ij}\\ n_f\left(j\right) \omega_j\right), \qquad \Lambda_f = I - \frac{\lambda \left(1 - \beta\right)}{\delta}\\ \mathrm{diag}\left(\sum_i \theta\_{ij}\\ n_m\left(i\right) \omega_i\right) \\

を作ると, \\\Lambda\\ が自分の価値の係数, \\\Theta\\ が相手の価値の係数になり,

\\ \begin{bmatrix} B_i r V_m^0 \\ B_j r V_f^0 \end{bmatrix} = \begin{bmatrix} \Lambda_m & \Theta_m \\ \Theta_f & \Lambda_f \end{bmatrix}^{-1} \begin{bmatrix} B_i u_m^0 \\ B_j u_f^0 \end{bmatrix} \\

と連立1次方程式1本で解けます ([Goussé et al. 2017](#ref-gousse2017), Appendix D.3). 価値関数反復は不要です.

**Step 4: 期待余剰と家庭内生産の水準.** Step 3 の解を [式 eq-gousse-theta](#eq-gousse-theta) に入れると \\\overline{S}\_{ij}\\ が, さらに [式 eq-gousse-sbar](#eq-gousse-sbar) を逆に解くと

\\ F\_{ij} X\_{ij} = \frac{\left(r + \delta\right) \overline{S}\_{ij}}{\overline{G}\left(\underline{z}\_{ij}\right)} \tag{A.18}\\

が求まります ([Goussé et al. 2017](#ref-gousse2017), eqs. 5.7, B.14). 「このタイプの組がこの確率 \\\alpha\_{ij}\\ で結婚するには, 家庭内生産がこの水準でなければならない」という逆算です.

#### 第2段階: 選好・家庭内生産・交渉力・マッチの質の分散

**パラメータ化.** 選好は本文の [式 eq-gousse-utility](#eq-gousse-utility) で, \\a\_{0i}, a\_{1i}, b_i\\ は本人の特性 \\x_i\\ (学歴と家族観指数) の線形関数, \\a_2\\ は性別ごとの定数です. 最低投入時間 \\D_m, D_f, D_m^0, D_f^0\\ は特性の関数, 生活費 \\C\_{ij}\\ は \\x_i\\ と \\x_j\\ の線形関数 (交差項なし) です. 第2段階で推定するのは, これらと \\\left(K_m, K_f, K_m^0, K_f^0\right)\\, Nash ウェイト \\\beta\\, マッチの質の分散 \\\sigma\\ です.

**独身者の条件付き期待値.** 独身の家事時間は [式 eq-apdx-gousse-single-flow](#eq-apdx-gousse-single-flow) の \\d_m^0\\ です. 余暇は, 本文の Roy の恒等式から得た \\w_i e = a\_{1i} w_i + a_2 w_i^2 + b_i\left(R - A_i\right)\\ に \\R - A_i = X_i^0\\ を入れたものです. したがって残差は

\\ \varepsilon_i^0 = d_i^0 - D_m^0 - \frac{K_m^0 X_i^0}{w_i}, \qquad \eta_i^0 = e_i^0 - a\_{1i} - a_2 w_i - \frac{b_i X_i^0}{w_i} \\

です (女性も同様) ([Goussé et al. 2017](#ref-gousse2017), Appendix C).

**夫婦の条件付き期待値.** 家事時間は付録 [sec-apdx-gousse-housework](#sec-apdx-gousse-housework) 節のとおり \\d_m = D_m + K_m X\_{ij} / w_i\\, \\d_f = D_f + K_f X\_{ij} / w_j\\ で, \\X\_{ij}\\ は [式 eq-apdx-gousse-X](#eq-apdx-gousse-X) です. \\z\\ に依存しないので, そのまま残差が作れます. 余暇は私的支出の分け方に依存します. Sharing rule の定義から \\R_m - A_i = \beta\_{ij}\left(z\right) X\_{ij}\\, \\R_f - A_j = \left(1 - \beta\_{ij}\left(z\right)\right) X\_{ij}\\ なので

\\ w_i e_m = a\_{1i} w_i + a_2 w_i^2 + b_i\\ \beta\_{ij}\left(z\right) X\_{ij}, \qquad w_j e_f = a\_{1j} w_j + a_2 w_j^2 + b_j \left(1 - \beta\_{ij}\left(z\right)\right) X\_{ij} \tag{A.19}\\

です ([Goussé et al. 2017](#ref-gousse2017), eqs. B.5-B.6). \\z\\ は計量経済学者には見えないので, 結婚していることを条件とした期待値を取ります. 既存の夫婦の \\z\\ は, 独立に引かれた最後の値のうち留保値を上回ったものなので, その分布は \\G\\ を \\z \geq \underline{z}\_{ij}\\ で切断したものです. 本文の sharing rule を使うと

\\ \overline{\beta}\_{ij} := E\left\[\beta\_{ij}\left(z\right) \mid z \geq \underline{z}\_{ij}\right\] = \beta + E\left\[\frac{1}{z} \mid z \geq \underline{z}\_{ij}\right\] \frac{\left(1 - \beta\right) B_i r V_m^0 - \beta B_j r V_f^0}{F\_{ij} X\_{ij}} \tag{A.20}\\

です ([Goussé et al. 2017](#ref-gousse2017), eq. C.1). 右辺の \\B_i r V_m^0\\, \\B_j r V_f^0\\, \\F\_{ij} X\_{ij}\\ は [sec-apdx-gousse-values](#sec-apdx-gousse-values) 節の手順で計算します. 残差は

\\ \begin{aligned} \varepsilon\_{m, ij} &= d\_{m, ij} - D_m - \frac{K_m X\_{ij}}{w_i}, & \varepsilon\_{f, ij} &= d\_{f, ij} - D_f - \frac{K_f X\_{ij}}{w_j}, \\ \eta\_{m, ij} &= e\_{m, ij} - a\_{1i} - a_2 w_i - \frac{b_i\\ \overline{\beta}\_{ij} X\_{ij}}{w_i}, & \eta\_{f, ij} &= e\_{f, ij} - a\_{1j} - a_2 w_j - \frac{b_j \left(1 - \overline{\beta}\_{ij}\right) X\_{ij}}{w_j} \end{aligned} \\

です.

**2次のモーメント.** 同じタイプの夫婦でも \\z\\ が違えば分け方 \\\beta\_{ij}\left(z\right)\\ が違うので, 余暇がばらつきます. このばらつきが \\\sigma\\ の情報源です. 分け方の条件付き分散は

\\ \sigma\_{ij}^2 := \mathrm{Var}\left\[\beta\_{ij}\left(z\right) \mid z \geq \underline{z}\_{ij}\right\] = \mathrm{Var}\left\[\frac{1}{z} \mid z \geq \underline{z}\_{ij}\right\] \left(\frac{\left(1 - \beta\right) B_i r V_m^0 - \beta B_j r V_f^0}{F\_{ij} X\_{ij}}\right)^2 \\

です ([Goussé et al. 2017](#ref-gousse2017), eq. C.4). [式 eq-apdx-gousse-leisure](#eq-apdx-gousse-leisure) より夫の余暇の偏差は \\b_i X\_{ij} / w_i\\ 倍, 妻の余暇の偏差は \\-b_j X\_{ij} / w_j\\ 倍の \\\beta\_{ij}\left(z\right) - \overline{\beta}\_{ij}\\ なので, 2次のモーメントの残差は

\\ \nu\_{mm, ij} = \eta\_{m, ij}^2 - \frac{b_i^2 \sigma\_{ij}^2 X\_{ij}^2}{w_i^2}, \qquad \nu\_{ff, ij} = \eta\_{f, ij}^2 - \frac{b_j^2 \sigma\_{ij}^2 X\_{ij}^2}{w_j^2}, \qquad \nu\_{mf, ij} = \eta\_{m, ij}\\ \eta\_{f, ij} + \frac{b_i b_j \sigma\_{ij}^2 X\_{ij}^2}{w_i w_j} \\

となります. 夫婦の余暇の共分散が負 (夫の取り分が増えれば妻の取り分が減る) なので, \\\nu\_{mf}\\ は足し算になります.

**切断対数正規分布のモーメント.** [式 eq-apdx-gousse-betabar](#eq-apdx-gousse-betabar) と \\\sigma\_{ij}^2\\ には \\1/z\\ の切断モーメントが現れます. 以下は論文には書かれていない標準的な計算です. \\x = \ln z \sim \mathcal{N}\left(0, \sigma^2\right)\\ について \\E\left\[e^{-k x} \mathbb{1}\left\\x \geq \ell\right\\\right\] = e^{k^2 \sigma^2 / 2}\\ \Phi\left(-\ell / \sigma - k \sigma\right)\\ が成り立ちます. \\\ell = \ln \underline{z}\_{ij}\\, \\\alpha\_{ij} = \Phi\left(-\ell / \sigma\right)\\ とおくと

\\ E\left\[\frac{1}{z} \mid z \geq \underline{z}\_{ij}\right\] = \frac{e^{\sigma^2 / 2}\\ \Phi\left(-\ell / \sigma - \sigma\right)}{\alpha\_{ij}}, \qquad E\left\[\frac{1}{z^2} \mid z \geq \underline{z}\_{ij}\right\] = \frac{e^{2 \sigma^2}\\ \Phi\left(-\ell / \sigma - 2 \sigma\right)}{\alpha\_{ij}} \\

で, 分散は2番目から1番目の2乗を引いたものです.

**推定量.** 残差 \\\varepsilon\\, \\\eta\\, \\\nu\\ の2乗和を, 選好・家庭内生産のパラメータ, \\\beta\\, \\\sigma\\ について最小化します (非線形最小二乗). パラメータを動かすたびに, [sec-apdx-gousse-values](#sec-apdx-gousse-values) 節の手順で \\\underline{z}\_{ij}\\, \\\theta\_{ij}\\, 独身の価値, \\F\_{ij} X\_{ij}\\, \\\overline{\beta}\_{ij}\\, \\\sigma\_{ij}^2\\ を計算し直します.

付録 C の残差は第1段階の \\\hat\alpha\_{ij}\\ と分布 \\\hat n_m, \hat n_f\\ を代入すれば計算できる形をしています. ただし論文の本文 (6.3 節) は, 反実仮想ではマッチング確率と分布をモデルから予測しなければならないので, 推定でもパラメータの更新ごとにそれらをモデルで計算し直し, ベンチマーク経済そのものをデータに当てる方が望ましい, と述べています. モデルで \\\alpha\_{ij}\\ を計算するには \\Z\_{ij}\\ が要るので, 論文が手順全体を iterative と呼んでいることと合わせると, 第2段階と第3段階を交互に繰り返していると読めます (この点は論文に明示されていません).

**識別の考え方.** 付録 B の議論を要約します. 特性 \\\left(x_i, x_j\right)\\ を固定すると, 残る変動は賃金 \\\left(w_i, w_j\right)\\ と観察されない \\z\\ だけです.

1.  [式 eq-apdx-gousse-leisure](#eq-apdx-gousse-leisure) の2本から \\\beta\_{ij}\left(z\right)\\ を消去すると

    \\ w_i e_m + \frac{b_i}{b_j} w_j e_f = a\_{1i} w_i + a_2 w_i^2 + \frac{b_i}{b_j}\left(a\_{1j} w_j + a_2 w_j^2\right) + b_i X\_{ij} \\

    となり ([Goussé et al. 2017](#ref-gousse2017), eq. B.8), 賃金を固定すれば右辺は定数です. 夫婦の余暇に残る変動は \\z\\ による分け方の違いだけなので, \\w_i e_m\\ を \\w_j e_f\\ に回帰した傾きから \\b_i / b_j\\ が分かります.

2.  家事支出 \\w_i d_m = w_i D_m + K_m X\_{ij}\\ と上の合成された余暇支出は, 賃金について非線形に動きます. その変動から \\a_2\\, \\b\\, \\K\\, \\a_1\\, \\D\\ が識別されます. このためには需要体系が賃金について線形でないこと (\\a_2 \neq 0\\) と, 家事時間が賃金に反応すること (\\K_m + K_f \neq 0\\) が必要です.

3.  独身者の余暇と家事時間の式から \\a_0\\ と \\\left(K^0, D^0\right)\\ が識別され, \\X\_{ij}\\ の式から生活費 \\C\_{ij}\\ が決まります.

4.  最後に, 分け方の水準 \\\overline{\beta}\_{ij}\\ (夫婦の余暇の平均) から \\\beta\\ が, そのばらつき \\\sigma\_{ij}^2\\ (夫婦の余暇の分散・共分散) から \\\sigma\\ が識別されます.

推定値は \\\hat\beta = 0.45\\, \\\hat\sigma = 0.268\\ で, その他のパラメータは本文の [図 fig-gousse2017-estimates](#fig-gousse2017-estimates) にあります.

#### 第3段階: 公共財の質 \\Z\_{ij}\\

第2段階までで \\Z\_{ij}\\ 以外のパラメータがすべて決まっています. \\Z\_{ij}\\ は, モデルの予測するマッチング確率が第1段階の \\\hat\alpha\_{ij}\\ に一致するように逆算します.

**Step 5: 格子点ごとの \\Z\_{ij}\\.** [sec-apdx-gousse-values](#sec-apdx-gousse-values) 節の Step 1-4 を推定済みのパラメータで実行し, 各タイプの組の \\F\_{ij} X\_{ij}\\ ([式 eq-apdx-gousse-FX](#eq-apdx-gousse-FX)) を得ます. 一方, 夫婦の家事時間 \\d_m - D_m = K_m X\_{ij} / w_i\\, \\d_f - D_f = K_f X\_{ij} / w_j\\ を Stone-Geary 型の生産関数に代入すると

\\ F\_{ij} = Z\_{ij} \left(\frac{K_m X\_{ij}}{w_i}\right)^{K_m} \left(\frac{K_f X\_{ij}}{w_j}\right)^{K_f} \\

です ([Goussé et al. 2017](#ref-gousse2017), eq. 6.10). [式 eq-apdx-gousse-X](#eq-apdx-gousse-X) のとおり \\X\_{ij}\\ は \\Z\_{ij}\\ に依存しないので, 両辺に \\X\_{ij}\\ を掛けて \\Z\_{ij}\\ について解くと

\\ Z\_{ij} = F\_{ij} X\_{ij} \left\[\left(\frac{K_m}{w_i}\right)^{K_m} \left(\frac{K_f}{w_j}\right)^{K_f} X\_{ij}^{1 + K_m + K_f}\right\]^{-1} \tag{A.21}\\

となります ([Goussé et al. 2017](#ref-gousse2017), Appendix C). これでタイプの組ごとに \\Z\_{ij}\\ の値が1つずつ得られます.

**Step 6: 多項式による平滑化.** 格子点ごとの \\Z\_{ij}\\ は \\\hat\alpha\_{ij}\\ の推定誤差をそのまま含むので, 両者の特性 \\\left(x_i, x_j\right)\\ のすべての交差項を含む高次多項式で近似します. 論文はこれを, 一致推定量 \\\hat\alpha\_{ij}\\ に基づく標準的な最小距離推定と位置づけています ([Goussé et al. 2017, sec. 6.3](#ref-gousse2017)). 学歴の補完性 (同類婚の動機) は, この多項式の交差項として \\Z\_{ij}\\ に現れます.

**まとめ.** 3段階の役割を整理すると, 第1段階はモデルの価値関数を使わずにフローとストックだけから \\\left(\xi, \delta, \alpha\_{ij}\right)\\ を出し, 第2段階は時間配分から選好・生産・交渉のパラメータを出し, 第3段階は「観察されたマッチング確率を再現する公共財の質」として \\Z\_{ij}\\ を出します. 3つを結ぶのが, \\\alpha\_{ij}\\ を与えれば独身の価値が線形方程式 [式 eq-gousse-fredholm](#eq-gousse-fredholm) で解ける, という移転可能効用モデルの性質です.

## A.10 出生モデルの証明

### A.10.1 閉形式解と賃金の効果

*Proof*. \\h = \left(\theta + e\right)^{\gamma}\\ を代入すると, 目的関数は \\\log c + \delta \log n + \delta \gamma \log \left(\theta + e\right)\\ となる. 予算制約より \\c = w - n\left(\phi w + p e\right)\\.

\\n\\ と \\e\\ の一階条件はそれぞれ

\\ \frac{\phi w + p e}{c} = \frac{\delta}{n}, \qquad \frac{n p}{c} = \frac{\delta \gamma}{\theta + e}. \\

2本の比を取ると \\\gamma \left(\phi w + p e\right) = p \left(\theta + e\right)\\ となり, これを解いて \\e\\ の式を得る. \\n\\ の一階条件 \\n \left(\phi w + p e\right) = \delta c\\ を予算制約に代入すると \\c = w - \delta c\\, すなわち \\c = w / \left(1 + \delta\right)\\. また \\e\\ の式より \\\phi w + p e = \left(\phi w - p \theta\right) / \left(1 - \gamma\right)\\ なので,

\\ n = \frac{\delta c}{\phi w + p e} = \frac{\delta}{1 + \delta} \cdot \frac{w \left(1 - \gamma\right)}{\phi w - p \theta} = \frac{\delta}{1 + \delta} \cdot \frac{1-\gamma}{\phi - \frac{p}{w}\theta}. \\

比較静学は式から直ちに従う. \\w\\ が上がると分母の \\\phi - p\theta/w\\ が大きくなるので \\n\\ は減少し, \\\gamma \phi w - p \theta\\ が大きくなるので \\e\\ は増加する.

### A.10.2 女性の賃金と出生

*Proof*. [式 eq-outsource-n](#eq-outsource-n) を \\w_f\\ で微分すると, \\\partial \pi / \partial w_f = \left(1 - s\right) \phi\\ より

\\ \frac{\partial n}{\partial w_f} = \frac{\delta}{1 + \delta} \cdot \frac{\pi\left(s\right) - \left(w_m + w_f\right) \left(1 - s\right) \phi}{\pi\left(s\right)^2}. \\

分子は \\\psi + s p_s \phi + \left(1 - s\right) w_f \phi - \left(1 - s\right) w_m \phi - \left(1 - s\right) w_f \phi = \psi + \left(s p_s - \left(1 - s\right) w_m\right) \phi\\ である. これは \\s\\ の増加関数で, \\s \left(p_s + w_m\right) \phi = w_m \phi - \psi\\ のときゼロになる. \\\psi \< w_m \phi\\ なら \\s^\* \> 0\\, また \\w_m \phi - \psi \< \left(p_s + w_m\right) \phi\\ なので \\s^\* \< 1\\ である.

Goussé, Marion, Nicolas Jacquemet, and Jean-Marc Robin. 2017. “Marriage, Labor Supply, and Home Production.” *Econometrica* 85 (6): 1873–919. <https://doi.org/10.3982/ECTA11221>.

Rothschild, Michael, and Joseph E Stiglitz. 1970. “Increasing Risk: I. A Definition.” *Journal of Economic Theory* 2 (3): 225–43. <https://doi.org/10.1016/0022-0531(70)90038-4>.

Strassen, V. 1965. “The Existence of Probability Measures with Given Marginals.” *Annals of Mathematical Statistics* 36 (2): 423–39. <https://doi.org/10.1214/aoms/1177700153>.

Theloudis, Alexandros, Jorge Velilla, Pierre-André Chiappori, José Ignacio Giménez-Nadal, and José Alberto Molina. 2025. “Commitment and the Dynamics of Household Labour Supply.” *The Economic Journal* 135 (665): 354–86. <https://doi.org/10.1093/ej/ueae065>.

[^1]: なお, [式 eq-bellman](#eq-bellman) の解が逐次問題 (無限和の最大化) の価値関数と一致することは, 有界性のもとで別途確認できます (verification argument). 直感的には, ベルマン方程式を \\N\\ 回展開すると逐次問題の \\N\\ 期打ち切りと残差 \\\beta^N V\\ に分解でき, 残差は消えていくためです.

[^2]: \\g\left(\infty, x\right) \cdot \frac{d \infty}{d x}\\ のような項を書いてゼロとみなすのは誤りである. 上端が \\x\\ に依存する場合にのみ, その項が立つ.
