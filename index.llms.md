# Family Macroeconomics

Code

Author

Affiliation

Kazuharu Yanagimoto [](mailto:yanagimoto@econ.kobe-u.ac.jp) [![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA2ZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYwIDYxLjEzNDc3NywgMjAxMC8wMi8xMi0xNzozMjowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDo1N0NEMjA4MDI1MjA2ODExOTk0QzkzNTEzRjZEQTg1NyIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDozM0NDOEJGNEZGNTcxMUUxODdBOEVCODg2RjdCQ0QwOSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDozM0NDOEJGM0ZGNTcxMUUxODdBOEVCODg2RjdCQ0QwOSIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M1IE1hY2ludG9zaCI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkZDN0YxMTc0MDcyMDY4MTE5NUZFRDc5MUM2MUUwNEREIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjU3Q0QyMDgwMjUyMDY4MTE5OTRDOTM1MTNGNkRBODU3Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+84NovQAAAR1JREFUeNpiZEADy85ZJgCpeCB2QJM6AMQLo4yOL0AWZETSqACk1gOxAQN+cAGIA4EGPQBxmJA0nwdpjjQ8xqArmczw5tMHXAaALDgP1QMxAGqzAAPxQACqh4ER6uf5MBlkm0X4EGayMfMw/Pr7Bd2gRBZogMFBrv01hisv5jLsv9nLAPIOMnjy8RDDyYctyAbFM2EJbRQw+aAWw/LzVgx7b+cwCHKqMhjJFCBLOzAR6+lXX84xnHjYyqAo5IUizkRCwIENQQckGSDGY4TVgAPEaraQr2a4/24bSuoExcJCfAEJihXkWDj3ZAKy9EJGaEo8T0QSxkjSwORsCAuDQCD+QILmD1A9kECEZgxDaEZhICIzGcIyEyOl2RkgwAAhkmC+eAm0TAAAAABJRU5ErkJggg==)](https://orcid.org/0009-0007-1967-8304)

Kobe University

Published

October 1, 2026

# はじめに

本書は, 神戸大学大学院の講義 Family Macroeconomics の講義ノートです. 結婚, 離婚, 出生, 家計内の資源配分といった家族の意思決定を, マクロ経済学の定量的な手法 (動的計画法, 構造推定, 均衡モデル) で分析します.

## 講義の概要

この講義は次の2つの部分から構成されます.

**数値計算**では, 家族のマクロモデルを解き, 推定するための道具を Julia で実装しながら学びます. 求根法と非線形最適化, 関数近似 (補間・数値微分・数値積分・離散化) という基礎の上に, 動的計画法を3段階 (決定論的 → 確率的 → 異質エージェント) で積み上げ, 最後に構造推定のための GMM (識別, 標準誤差, 最小距離推定) を扱います.

**結婚と出生**が本書の本体です. サーチモデル ([Greenwood and Guner 2009](#ref-greenwood2009); [Greenwood et al. 2016](#ref-greenwood2016)), 摩擦のない結婚市場 ([Galichon et al. 2019](#ref-galichon2019); [Ciscato 2025](#ref-ciscato2025); [Reynoso 2024](#ref-reynoso2024)), そして出生の古典理論とその変化 ([Doepke et al. 2023](#ref-doepke2023)), 140年の構造変化の定量分析 ([Greenwood et al. 2023](#ref-greenwood2023)) を読みます. 各章の冒頭では, その章の論文を読むために必要な理論 (最適停止と留保値, 確率効用モデルとロジット) を証明付きで準備します.

数値計算はすべて Julia で書かれており, リポジトリの `Project.toml` から実行環境を再現できます. 前提知識としては, 大学院初年級のミクロ経済学・マクロ経済学と, 基礎的な確率論を想定しています.

## 成績評価と課題

この講義は, 60% の課題と 40% の期末レポートで評価されます. 課題の提出は全て, [Quarto](https://quarto.org) と Julia を用いたレポートとします. Julia と Quarto の使い方は TA セッションにて解説予定です.

内容は, 講義で扱った内容の手計算の部分と数値計算の部分の両方を含みます.

### GitHub による提出

課題は GitHub を通じて提出します. TAセッションで解説がありますが, 次の手順に従ってください.

0.  教員 (柳本) と学生 (個人) 専用のプライベートレポジトリを作成する. 講義を通じて一つのレポジトリを使う
1.  課題の提出期限までに, レポジトリに解答の qmd ファイルを push する
2.  GitHub Actions が起動し, 自動的に解答の qmd ファイルのコードを実行して PDF を生成する
3.  成績評価はPDFの内容をもとに行われる

Ciscato, Edoardo. 2025. “Assessing Racial and Educational Segmentation in Large Marriage Markets.” *Review of Economic Studies* 92 (6): 3788–839. <https://doi.org/10.1093/restud/rdae115>.

Doepke, Matthias, Anne Hannusch, Fabian Kindermann, and Michèle Tertilt. 2023. “The Economics of Fertility: A New Era.” In *Handbook of the Economics of the Family*, vol. 1. Elsevier. <https://doi.org/10.1016/bs.hefam.2023.01.003>.

Galichon, Alfred, Scott Duke Kominers, and Simon Weber. 2019. “Costly Concessions: An Empirical Framework for Matching with Imperfectly Transferable Utility.” *Journal of Political Economy* 127 (6): 2875–925. <https://doi.org/10.1086/702020>.

Greenwood, Jeremy, and Nezih Guner. 2009. “Marriage and Divorce Since World War II: Analyzing the Role of Technological Progress on the Formation of Households.” In *NBER Macroeconomics Annual 2008, Volume 23*. University of Chicago Press.

Greenwood, Jeremy, Nezih Guner, Georgi Kocharkov, and Cezar Santos. 2016. “Technology and the Changing Family: A Unified Model of Marriage, Divorce, Educational Attainment, and Married Female Labor-Force Participation.” *American Economic Journal: Macroeconomics* 8 (1): 1–41. <https://doi.org/10.1257/mac.20130156>.

Greenwood, Jeremy, Nezih Guner, and Ricardo Marto. 2023. “The Great Transition: Kuznets Facts for Family-Economists.” In *Handbook of the Economics of the Family*, edited by Shelly Lundberg and Alessandra Voena, vol. 1. Handbook of the Economics of the Family, Volume 1. North-Holland. <https://doi.org/10.1016/bs.hefam.2023.01.006>.

Reynoso, Ana. 2024. “The Impact of Divorce Laws on the Equilibrium in the Marriage Market.” *Journal of Political Economy* 132 (12): 4155–204. <https://doi.org/10.1086/732532>.
