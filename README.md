# デートサジェスター（仮）

デートをプランニングしてくれるアプリ

# APIサーバーを立てるまでの手順

※Railsを動かす環境がない方は[こちら](https://railsguides.jp/getting_started.html#rails%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)をご参照ください。


Gemの導入とDBのクリエイトとマイグレーションを行います。

```
$ bundle install
$ rails db:create
$ rails db:migrate
$ rails db:seed_fu
```

# Usage

https://api-date-suggester-dev.herokuapp.com/ にデプロイしてあります。

各APIについては[こちら](https://github.com/quelcode-0-teamA/date-suggester-rails/wiki)をご参照ください。
