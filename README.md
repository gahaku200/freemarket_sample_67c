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
