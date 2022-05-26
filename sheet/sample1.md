## find | ある日時より後に更新されたファイルを探したい
e.g. '2017/09/01 11:53' より後に更新されたファイルを探す

```
$ sudo find /home/test_taro/* -type f -newermt '20170901 11:53' | xargs ls -lh
-rwx------ 1 test_taro test  436M  9月  1 11:58 2017 /home/test_taro/S23.csv
-rwx------ 1 test_taro test  6.6M  9月  1 11:57 2017 /home/test_taro/S23_CTL.csv
-rwx------ 1 test_taro test  384M  9月  1 11:58 2017 /home/test_taro/S23_LIST.csv
-rwx------ 1 test_taro test   22M  9月  1 12:23 2017 /home/test_taro/S26.csv
-rwx------ 1 test_taro test  329K  9月  1 12:23 2017 /home/test_taro/S26_CTL.csv
...
```

オプション:

- newerat/atime: アクセスされたファイル
- newerct/ctime: 属性変更されたファイル
- newermt/mtime: 更新されたファイル



## find | ある日時以前に更新されたファイルを探したい
e.g. '2015/01/01 00:00' 以前に更新されたファイルを探す 

```
$ sudo find ./* -type f ! -newermt '20150101 00:00' | xargs ls -lh
```

