## ER図

https://www.draw.io/?state=%7B%22ids%22:%5B%221sEhle2n1CE_6fTWH9v8_9e-L5-2EO3Bo%22%5D,%22action%22:%22open%22,%22userId%22:%22103206935538130992501%22%7D#G1sEhle2n1CE_6fTWH9v8_9e-L5-2EO3Bo

## users table

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|birth|date|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|tel|integer|unique: true, null: false|
|profile|text|
|point|integer|default: 0|
|assets|integer|default: 0|

### Association
- has_one :address, dependent: destroy
- has_one :credit, dependent: destroy
- has_many :comments
- has_many :likes
- has_many :ratings
- has_many :notices, dependent: destroy
- has_many :todos, dependent: destroy
- has_many :items
- has_many :messages
- has_many :purchases

## messeages table

|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|item_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

### Association

- belongs_to :user
- belongs_to :item

## purchases table

|Column|Type|Options|
|------|----|-------|
|item_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

### Association

- has_one    :item
- belongs_to :user

## address table

|Column|Type|Options|
|------|----|-------|
|zip_code|integer|null: false|
|prefecture|text|null: false|
|city|text|null: false|
|address|text|null: false|
|building|text||
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|tel|integer|null: false|
|user_id|references|null: false, foreign_key: true|

### Association

## credits table

|Column|Type|Options|
|------|----|-------|
|number|integer|null: false|
|security|integer|null: false|
|name|string|null: false|
|year|date|null: false|
|month|date|null: false|
|user_id|references|null: false, foreign_key: true|

### Association

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
|rater_id|references|null: false, foreign_key: true|
|rated_id|references|null: false, foreign_key: true|

### Association
- belongs_to :rater class_name: 'User' :foreign key rater_id
- belongs_to :rated class_name: 'User' :foreign key rated_id

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
|status|integer|null: false|
|seller_id|references|null: false, foreign_key: true|
|buyer_id|references|null: false, foreign_key: true|
|categories_hierarchie_id|references|null: false, foreign_key: true|
|brand_id|references|null: false, foreign_key: true|


### Association
- belongs_to :seller class_name: 'User' :foreign key seller_id
- belongs_to :buyer class_name: 'User' :foreign key buyer_id
- belongs_to :prefecture
- belongs_to :brand
- belongs_to :categories_hierarchie
- has_many :likes, dependent: destroy
- has_many :comments, dependent: destroy
- has_many :images, dependent: destroy
- has_many :todos, dependent: destroy
- has_many :notices, dependent: destroy
- has_many :messages

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
|content|string|null: false|
|parent_id|references|foreign_key: true|

### Association
- has_many :brands, through: :categories_brands
- has_many :categories_hierarchies, dependent: destroy
- belongs_to :parent class_name: 'Category' :foreign key parent_id

## categories_hierarchies table

|Column|Type|Options|
|------|----|-------|
|ancestor_id|references|null: false, foreign_key: true|
|descendant_id|references|null: false, foreign_key: true|
|generations|references|null: false, foreign_key: true|

### Association
- belongs_to :ancestor class_name: 'Category' :foreign key ancestor_id
- belongs_to :descendant class_name: 'Category' :foreign key descendant_id
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
