#import "template.typ": *
#show: jarticle.with(
  fontsize:10pt,
  title: [実験タイトル],
  authors: ([著者名],),
  date: "yyyy/MM/dd",
)

= 目的
このように引用 @rust-docs します．
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
  image("figures/sample.png", width: 200pt),
  caption: [図の例],
) <fig:sample-figure>
= 結果
= 考察
= 参考文献
#bibliography("references.yml", title:none)
