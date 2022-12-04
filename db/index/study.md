# インデックスについて

## なんのため
検索を早くするため。
テーブルは順序のない集合のため、最初の行から(求める値を)順番にスキャンしていく。
そこで、テーブルとは別に、順序付けされたデータ構造を別ファイルで保管する。これがインデックス。

## メリデメ
#### メリット
検索が早い。
ソートが不要になるため、ソートを使う処理が早くなる？？(https://use-the-index-luke.com/ja/sql/sorting-grouping)
- ORDER BY
- 集約関数(min, max, avg...)
- GROUP BY
- DISTINCT
- 集合演算(UNION INTERSECT EXCEPT)
- ウィンドウ関数

#### デメリット
INSERTやUPDATEでインデックス構造も更新しないといけないため、遅くなる。

## 実態はなに？
ファイル。なので、ストレージ領域を使う。
連結リストで作られており、[値, 行へのポインタ] のリストとして保存されている。
これらをどんなデータ構造で保持するかがINDEXの種類。

## INDEXの種類
有名どころ
- Bツリーインデックス
  - 一番定番
  - 値の大小で分かれた木構造
  - 計算量は木の深さで、数百万レコードでも深さは4~5くらいらしい。
  - 下２つの良さをいいとこ取りでバランスタイプ
- ビットマップインデックス
- ハッシュインデックス

## Bツリーインデックスの挙動
https://use-the-index-luke.com/static/fig01_02_tree_structure.ja.RBybVdNo.png
という構造になっていて、検索するときは、大小比較しながらノードを見つけていく。
https://use-the-index-luke.com/static/fig01_03_tree_traversal.ja.bhRJyIWe.png

## 複合インデックス
複合インデックスは貼っている全列で検索しないと意味がない。
理由は1列目の大小 → ２列目の大小...で比較しているから、一つでも列が欠けている検索は無意味。
https://use-the-index-luke.com/static/fig02_01_concatenated_index.ja.Kc5gBEdc.png

## NULLや否定について
IS NULLやIS NOT NULLはインデックスが使われない。
(NULLは大小比較できないから、インデックス構造に適用不可)
→ と思ったが。NULLはBツリーの先頭か末尾に格納されるため、NULLか非NULLが偏っていたら使われるらしい。

不等号検索もインデックス使われない。


## CREATE INDEX
CREATE INDEXしたときって、既存のレコードに対してもindexを構築しているの？

INDEXが作られると、テーブルに対するデータ構造が作成される。

## 検索で一部だけindexがあるとき
```sql
SELECT col_1, col_2
  FROM table
where col_1 = 1 and col_2 = 2
```
で、col_1だけインデックスが貼られているときは、
col_1が1となる検索結果からcol_2が2となる行をフルスキャンしているのかな？？

