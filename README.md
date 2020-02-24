
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
