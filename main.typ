#import "template.typ": *
#show: jarticle.with(
  fontsize:10pt,
  title: [タイトル],
  authors: ([著者名],),
  date: "yyyy/MM/dd",
)

= 目的
typstのテンプレートです．
= 原理
#tbl(
  table(
    columns: 2,
    stroke: none,
    table.hline(stroke:0.5pt),
    [a], [b],
    table.hline(stroke: 0.5pt),
    [1], [2],
    table.hline(stroke: 0.5pt),
  ),
  caption: [表のサンプル],
) <tbl:sample-table>
= 方法
#fig(
  image("figures/sample.png", width: 80pt),
  caption: [図の例],
) <fig:sample-figure>
= 結果
@tbl:sample-table から〜〜〜〜 \
@fig:sample-figure から〜〜〜〜 \
のように参照することができます．
= 考察
このように引用 @pierce2002tapl します．

// 参考文献
#bibliography("refs.bib")
