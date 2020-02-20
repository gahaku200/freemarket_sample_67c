# freemarket_sample_67c
フリマアプリのクローンサイト。

## Description
誰でも簡単に売り買いが楽しめるフリマアプリの機能を再現したページ。
ユーザー登録、商品出品、商品購入などの機能が再現されていますが、実際の取引はできません。

## Features

- haml/SASS記法と、命名規則BEMを使ったマークアップ
- ウィザード形式を用いたユーザー登録フォーム
- ajaxを使用した非同期処理
- pay.jpによる購入処理
- capistranoによるAWS EC2への自動デプロイ
- AWS S3への画像アップロード
- RSpecを使った単体テスト

## Requirement

- Ruby 2.5.1
- Rails 5.2.3

## Author
[gahaku200]
[nrfn]
[maruyoshi]

## Usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|encrypted_password|string|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birthday_year|integer|null: false|
|birthday_month|integer|null: false|
|birthday_day|integer|null: false|

### Association
- has_many :products
- has_one :address

## Addressesテーブル
|Column|Type|Options|
|------|----|-------|
|zipcode|string|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|municipality|string|null: false|
|address|string|null: false|
|building_name|string|
|phone_num|integer|
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :user

## Productsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index:true|
|description|text|null: false|
|status_id|integer|null: false|
|delivery_charge_id|integer|null: false|
|ship_from_id|integer|null: false|
|delivery_days_id|integer|null: false|
|price|integer|null: false|
|seller_id|references|null: false, foreign_key: { to_table: :users }|
|buyer_id|references|foreign_key: { to_table: :users }|
|brand|references|null: false, foreign_key: true|
|category|references|null: false, foreign_key: true|

### Association
- belongs_to_active_hash :status_id
- belongs_to_active_hash :delivery_charge_id
- belongs_to_active_hash :ship-from_id
- belongs_to_active_hash :delivery_days_id
- has_many :images
- belongs_to :brand
- belongs_to :user
- belongs_to :category

## Categorysテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false, index:true|

### Association
- has_many :products
- has_ancestry

## Imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|text|null: false|
|product|references|null: false, foreign_key: true|

### Association
- belongs_to :product

## Brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :products


## Cardsテーブル
|Column|Type|Options|
|------|----|-------|
|customer_id|string|null: false|
|card_id|string|null: false|
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :user

## Commentsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|
|product_id|integer|null: false|
|text|text|null: false|

### Association
- belongs_to :product
- belongs_to :user