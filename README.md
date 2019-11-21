## users table

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
|tel|integer|unique: true|
|address|text|null: true|
|profile|text|null: true|
|point|integer|null: true|
|assets|integer|null: true|
|prefecture_id|references|null: false, foreign_key: true|
|credit_id|references|null: false, foreign_key: true|

### Association
- belongs_to :prefecture
- belongs_to :credit
- has_many :comments
- has_many :likes
- has_many :ratings
- has_many :notices
- has_many :todos
- has_many :items

## credits table

|Column|Type|Options|
|------|----|-------|
|number|integer|null: false|
|security|integer|null: false|
|year|date|null: false|
|month|date|null: false|

### Association
- belongs_to :user

## likes table

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item

## ratings table

|Column|Type|Options|
|------|----|-------|
|rank|integer|null: false|
|user_id|references|null: false, foreign_key: true|
|rated_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user

## items table
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|size|string|null: false|
|price|string|null: false|
|condition|string|null: false|
|explanation|string|null: false|
|shipping_cost|integer|null: false|
|shipping_method|integer|null: false|
|days|date|null: false|
|seller_id|references|null: false, foreign_key: true|
|buyer_id|references|null: false, foreign_key: true|
|prefecture_id|references|null: false, foreign_key: true|
|category_id|references|null: false, foreign_key: true|
|brand_id|references|null: false, foreign_key: true|


### Association
- belongs_to :user
- belongs_to :prefecture
- belongs_to :brand
- belongs_to :categories_hierarchie
- has_many :likes
- has_many :comments
- has_many :images
- has_many :todos
- has_many :notices

## image table

|Column|Type|Options|
|------|----|-------|
|image|text|null: false|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item

## comments table

|Column|Type|Options|
|------|----|-------|
|text|string|null: false|
|item_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item
- belongs_to :user

## notices table

|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item
- belongs_to :user

## categories table

|Column|Type|Options|
|------|----|-------|
|content|string|null: false, unique: true|
|parent_id|references|null: false, foreign_key: true|

### Association
- has_many :brands, through: :categories_brands
- has_many :categories_hierarchies

## categories_hierarchies table

|Column|Type|Options|
|------|----|-------|
|ancestor_id|references|null: false, foreign_key: true|
|descendant_id|references|null: false, foreign_key: true|
|generations|references|null: false, foreign_key: true|

### Association
- belongs_to :category
- has_many :items

## brands table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|

### Association
- has_many :items
- has_many :brands, through: :categories_brands

## categories_brands table

|Column|Type|Options|
|------|----|-------|
|brand_id|references|null: false, foreign_key: true|
|category_id|references|null: false, foreign_key: true|

### Association
- belongs_to :brand
- belongs_to :category

## todos table

|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|references|null: false, foreign_key: true|
|items_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item
- belongs_to :user

## prefecture table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|

### Association
- has_many :items
- has_many :users
