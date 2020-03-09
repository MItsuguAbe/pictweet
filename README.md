# はじめに
 
はじめまして。  
現在就職活動中でポートフォリオを作成したのでそれの説明をしたいと思います。
 
# URL
 
https://quiet-scrubland-31677.herokuapp.com

テストユーザー
email: 123@gmail.com
password: 111111
 
# 主な機能

・記事表示一覧
・記事詳細一覧
・新規投稿
・新規登録
・ログイン・ログアウト機能
・コメント機能
・コメント機能の非同期通信化
・検索機能
・インクリメンタルサーチ
・いいね機能
・タグ付け機能  (すみません、本番環境だと機能していません)
・RSpecによる単体テスト、システムテスト
 
 
# 概要
 
基礎的なCRUD機能をもつSNSサービスに上の機能を追加しました。
 
# どうやって作成したか
 
1. 必要な機能を洗い出す。

2. その機能を実現するために必要なテーブル、カラムを洗い出す。

3. ER図を作成

4. 各リソースを追加
UserやTweetといった核となるリソースから順に追加。

5. デバッグの繰り返し
binding.pryやrails cを何回も繰り返し、値が取れていなかったらなぜ取れていないのか仮説と検証を行った。

 
# 難しかったところ
 
非同期通信処理の部分です。
コメント機能とインクリメンタルサーチの部分で実装したのですが、なかなかうまくいかず、何度もデバッグしながら作りました。
まだ自分でJavaScriptのコードが書けていない気がしたので、非同期通信を使って、リアルタイムのチャットアプリを作りました。
 
# このアプリの課題
 
タグ機能: ローカル環境ではうまく動いていたタグをつけて投稿する機能と、タグによる検索機能が本番環境だと使えない状態なので、
現在、原因を探しています。

フロントエンド: 記事一覧の画面などがダサすぎるので、jQueryなどを用いて、扱いやすいようにする。
 

# スペック

・Ruby 2.5.1
・Rails 5.2.4.1
・MySQL 5.6

# サーバー

Heroku


# テーブルについて

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|email|string|null: false|
|password|string|null: false|
|nickname|string|null: false|
### Association
- has_many :tweets
- has_many :comments

## tweetsテーブル
|Column|Type|Options|
|------|----|-------|
|image|text||
|text|text||
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- has_many :comments

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text||
|user_id|integer|null: false, foreign_key: true|
|tweet_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :tweet
- belongs_to :user


## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer||
|tweet_id|integer||
### Association


## tagsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :tweet_tag_relations
- has_many :tweets


## tweet_tag_relationsテーブル
|Column|Type|Options|
|------|----|-------|
|tweet_id|integer|null: false|
|user_id|integer|null: false|
### Association
- belongs_to :tweet
- belongs_to :tag
