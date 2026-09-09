# Family Macroeconomics (神戸大学大学院)

神戸大学大学院の講義 **Family Macroeconomics** の講義ノートと課題です.
結婚, 離婚, 出生, 家計内の資源配分といった家族の意思決定を, マクロ経済学の
定量的な手法 (動的計画法, 構造推定, 均衡モデル) で分析します.

- **講義サイト**: <https://kazuyanagimoto.com/course-kobe-macro4-2026/>
- **講義ノート (PDF)**: <https://kazuyanagimoto.com/course-kobe-macro4-2026/Family-Macroeconomics.pdf>

> [!NOTE]
> サイトは準備中です. ビルド済みのものは `gh-pages` ブランチにあります.

## 課題

提出期限は変更されることがあります. 出題前の課題は「未公開」と表示され,
出題した回に問題の PDF が公開されます.

<!-- assignments:start -->
| 課題 | 提出期限 | 問題 |
| --- | --- | --- |
| Exercise 0 |  | [00-exercise.pdf](assignment/00-exercise/00-exercise.pdf) |
| Exercise 1 | 2026年10月27日 | [01-exercise.pdf](assignment/01-exercise/01-exercise.pdf) |
| Exercise 2 | 2026年12月1日 | 未公開 |
| Exercise 3 | 2027年1月12日 | 未公開 |
| Exercise 4 | 2027年1月26日 | 未公開 |
<!-- assignments:end -->

## このレポジトリについて

このレポジトリの中身は非公開の開発レポジトリ
[`course-kobe-macro4-2026-dev`](https://github.com/kazuyanagimoto/course-kobe-macro4-2026-dev)
から自動で同期されています. **直接編集しても次の同期で上書きされます.**
誤りを見つけた場合は Issue でお知らせください.

`main` への push で GitHub Actions が Quarto book をレンダリングし,
`gh-pages` ブランチへ置きます. 計算結果は `_freeze/` にキャッシュ
されているので, ビルドに Julia は不要です.

## ライセンス

講義資料の著作権は柳本和春に帰属します. 引用元のある図表はそれぞれの出典に従います.
