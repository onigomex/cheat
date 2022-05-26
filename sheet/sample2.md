## git | add したファイルの diff を確認する( commit 前）
```
$ git diff --cached
$ git diff --cached <ファイルパス>
```



## git | ブランチを強制削除したい
```
$ git branch -D foo
```



## git | リモートブランチを削除したい
:（コロン）をブランチの前につける（ローカルは残るので、git branch -D BRANCH で削除する）

```
$ git push origin :new-feature
To https://source.developers.google.com/p/projectid/r/default
 - [deleted]         new-feature
```

