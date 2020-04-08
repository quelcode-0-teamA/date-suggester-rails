# デートサジェスター（仮）

デートをプランニングしてくれるアプリ

# APIサーバーを立てるまでの手順

※Railsを動かす環境がない方は[こちら](https://railsguides.jp/getting_started.html#rails%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)をご参照ください。


Docker環境を立ち上げ、DBの用意を行います。

```
$ dokcer-compose build
$ dokcer-compose up
$ docker-compose run web rails db:create
$ docker-compose run web rails db:migrate
$ docker-compose run web rails db:seed_fu
```

locahostのポート3000にてご確認ください。

`http://localhost:3000/`

# Usage

開発環境のAPIサーバーはこちらに立ててあります。
https://api-date-suggester-dev.herokuapp.com/

各APIについては[APIドキュメント](https://github.com/quelcode-0-teamA/date-suggester-rails/wiki)をご参照ください。
