# 結婚の経済学

Code

## 結婚の経済学的な意義

結婚は主体的な選択である以上, 経済学の分析ではインセンティブの構造を理解することが必要です. 様々な要因が結婚の意思決定に影響を与えますが, 主に議論されるのは次の4つです.

1.  **規模の経済**: 実質的な所得効果
2.  **公共財の供給**: 家事労働, 子どもなど
3.  **リスクシェアリング**: 所得リスクなど
4.  **愛**: 上記3つで説明されない (確率的) 要素

### 規模の経済

二人以上で住む場合は, 家賃や光熱費などの固定費を分担できたり, 食事をまとめて作ることでコストが下げられるなど, 消費の効率が上がることがあります. これを経済学では規模の経済 (economies of scale) と呼びます. 正確にモデル化すると複雑化してしまうので, ほとんどの研究では OECD の統計による簡便な尺度を用います.

**定義 (OECD Equivalence Scale)** OECD equivalence scale は, 二人目以降の世帯員が消費する財の量を 0.7, 子どもは 0.5 として, 世帯の消費を調整する尺度である. 典型的な夫婦と子ども \\n\\ 人の世帯の消費は \\C(n) = 1 + 0.7 + 0.5n\\ と表される. 世帯所得を \\Y\\ とすると, 世帯の消費水準は \\Y/C(n)\\ で表される.

なお, 近年は再計算が行われて, 大人は 0.5, 子どもは 0.3 に調整されており, これを OECD-modified equivalence scale と呼ぶ.

他の簡便な尺度として, 世帯員の人数の根号をとる \\C(n) = \sqrt{n}\\ とする方法もあります.

### 公共財の供給

結婚している場合, 独身の場合と比べて, 家事労働の分担や子どもの養育などの便益を得ることができます. これらは, 夫婦間で共有され, かつ消費の際に競合しないため, 公共財 (public goods) と呼ばれます.

公共財をモデル化する場合は, 様々な流儀があり, 子どもの人数 \\n\\ に応じて効用を \\u(n)\\ とする方法や, 家事労働の分担を考慮して効用を \\u(h_1, h_2)\\ とする方法などがあります.

### リスクシェアリング

夫婦が共に働いている場合, 片方の所得が減少しても, もう片方の所得で生活を維持することができます. このように結婚は所得リスクを分散する効果があり, 経済学ではリスクシェアリング (risk sharing) と呼ばれます. ただし, リスクシェアリングは数ある経済学的な結婚の意義の中でも, それほど大きな効果はないと考えられています.

### 愛

結婚に最も重要な要素は愛であると考える人は多いでしょう. それらは否定されることではありませんが, 観察されることでもありません. そのため, 経済学のモデルでは, 愛は確率的な要素として扱われることが多いです. 夢のない話のように思えるかもしれませんが, 上記のような経済学的な要因を差し引いても, 結婚が成立するのは, 愛があるからだと考えることもできます.

**定義 (結婚)** 近年では多様な形のパートナーシップも広がっているが, 本講義では, 注釈のない限り異性間の法律婚を対象とします. しかし, 特に西欧諸国では事実婚と法律婚の違いが小さくなっているため, 事実婚や同居 (cohabitation) を含めた研究も多いです.

## 結婚モデルの二つの層

結婚をモデル化するときには次の二つの層があります.

1.  **マッチング**: 誰と誰が結婚するか
2.  **家庭内配分**: 結婚した後の家事労働や消費の分担など

この2つは歴史的には別々の理論として発展しました. 前者は Becker ([1973](#ref-becker1973a)) に始まるマッチング理論 (集大成として Becker ([1991](#ref-becker1991))), 後者は Chiappori ([1988](#ref-chiappori1988)) に始まる collective model や Nash 交渉 など家計内配分の理論です. しかし, 結婚する際に家庭内配分を見据えてマッチングが行われることをふまえると, 両者は同じ問題の表と裏であることが分かります. この授業では, まず[家計内配分の章](../../lesson/marriage/allocation.llms.md)で家庭内配分の理論を扱います.

マッチングの一般的な理論は[マッチング理論の章](../../lesson/marriage/matching.llms.md)で扱います.

さらに, マッチング理論には大きく分けて二つの流派があります.

**1. サーチモデル (Search and Matching Model)**

- Shimer and Smith ([2000](#ref-shimer2000)) を起源とした毎期ランダムに相手を探す動学的モデル
- 結婚のタイミング (晩婚化) や再婚などを扱いやすい
- 講義では Greenwood and Guner ([2009](#ref-greenwood2009)), Greenwood et al. ([2016](#ref-greenwood2016)), Goussé et al. ([2017](#ref-gousse2017)) を紹介

**2. 摩擦のない結婚市場モデル (Frictionless Marriage Market)**

- Choo and Siow ([2006](#ref-choo2006)) に始まる, 初期時点で全ての人が結婚相手を見つけるモデル
- より詳細な家庭の意思決定 (家庭内配分など) をモデル化しやすい
- 講義では一般枠組みとして Galichon et al. ([2019](#ref-galichon2019)) を扱い, 応用として Ciscato ([2025](#ref-ciscato2025)), Reynoso ([2024](#ref-reynoso2024)) を紹介

Becker, Gary S. 1973. “A Theory of Marriage: Part I.” *Journal of Political Economy* 81 (4): 813–46. <https://doi.org/10.1086/260084>.

Becker, Gary S. 1991. *A Treatise on the Family*. Enl. Harvard University Press.

Chiappori, Pierre-André. 1988. “Rational Household Labor Supply.” *Econometrica* 56 (1): 63–90. <https://doi.org/10.2307/1911842>.

Choo, Eugene, and Aloysius Siow. 2006. “Who Marries Whom and Why.” *Journal of Political Economy* 114 (1): 175–201. <https://doi.org/10.1086/498585>.

Ciscato, Edoardo. 2025. “Assessing Racial and Educational Segmentation in Large Marriage Markets.” *Review of Economic Studies* 92 (6): 3788–839. <https://doi.org/10.1093/restud/rdae115>.

Galichon, Alfred, Scott Duke Kominers, and Simon Weber. 2019. “Costly Concessions: An Empirical Framework for Matching with Imperfectly Transferable Utility.” *Journal of Political Economy* 127 (6): 2875–925. <https://doi.org/10.1086/702020>.

Goussé, Marion, Nicolas Jacquemet, and Jean-Marc Robin. 2017. “Marriage, Labor Supply, and Home Production.” *Econometrica* 85 (6): 1873–919. <https://doi.org/10.3982/ECTA11221>.

Greenwood, Jeremy, and Nezih Guner. 2009. “Marriage and Divorce Since World War II: Analyzing the Role of Technological Progress on the Formation of Households.” In *NBER Macroeconomics Annual 2008, Volume 23*. University of Chicago Press.

Greenwood, Jeremy, Nezih Guner, Georgi Kocharkov, and Cezar Santos. 2016. “Technology and the Changing Family: A Unified Model of Marriage, Divorce, Educational Attainment, and Married Female Labor-Force Participation.” *American Economic Journal: Macroeconomics* 8 (1): 1–41. <https://doi.org/10.1257/mac.20130156>.

Reynoso, Ana. 2024. “The Impact of Divorce Laws on the Equilibrium in the Marriage Market.” *Journal of Political Economy* 132 (12): 4155–204. <https://doi.org/10.1086/732532>.

Shimer, Robert, and Lones Smith. 2000. “Assortative Matching and Search.” *Econometrica* 68 (2): 343–69. <https://doi.org/10.1111/1468-0262.00112>.
