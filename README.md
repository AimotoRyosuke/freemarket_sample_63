## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|birth|date|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|tell|integer|unique: true|
|address|text|null: true|
|payment|integer|null: true|
|profile|text|null: true|
|prefecture_id|references|null: false, foreign_key: true|

### Association
- belongs_to :prefecture
- has_many :comments
- has_many :likes
- has_many :ratings
- has_many :notices
- has_many :todos
- has_many :items

## likesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item

## ratingsテーブル

|Column|Type|Options|
|------|----|-------|
|rank|integer|null: false|
|user_id|references|null: false, foreign_key: true|
|rated_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user

## itesmsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|size|string|null: false|
|price|string|null: false|
|condition|string|null: false|
|explanation|string|null: false|
|shipping_cost|integer|null: false|
|shipping_method|integer|null: false|
|days|integer|null: false|
|seller_id|references|null: false, foreign_key: true|
|buyer_id|references|null: false, foreign_key: true|
|prefecture_id|references|null: false, foreign_key: true|
|category_id|references|null: false, foreign_key: true|
|brand_id|references|null: false, foreign_key: true|


### Association
- belongs_to :user
- belongs_to :prefecture
- belongs_to :brand
- belongs_to :category
- has_many :likes
- has_many :comments
- has_many :images
- has_many :todos
- has_many :notices

## imageテーブル

|Column|Type|Options|
|------|----|-------|
|image|text|null: false|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item

## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|text|string|null: false|
|item_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item
- belongs_to :user

## noticesテーブル

|text|text|null: false|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item
- belongs_to :user

## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|

### Association
- has_many :items
- has_many :brands, through: :categories_brands
- has_many :details

## detailsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|
|category_id|references|null: false, foreign_key: true|

### Association
- belongs_to :category
- has_many :words

## wordsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|
|details_id|references|null: false, foreign_key: true|

### Association
- belongs_to :detail
- has_many :items

## brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|ユニーク

### Association
- has_many :items
- has_many :brands, through: :categories_brands

## categories_brandsテーブル

|Column|Type|Options|
|------|----|-------|
|brand_id|references|null: false, foreign_key: true|
|category_id|references|null: false, foreign_key: true|

### Association
- belongs_to :brand
- belongs_to :category

## todosテーブル

|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|references|null: false, foreign_key: true|
|items_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item
- belongs_to :user

## prefectureテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|

### Association
- has_many :items
- has_many :users
