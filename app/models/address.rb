class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  include JpPrefecture
  jp_prefecture :prefecture_code
  belongs_to_active_hash :prefecture
  before_validation :change_string
  has_many :users

  validates :first_name, :last_name, :first_name_kana, :last_name_kana, :zip_code, :prefecture_id, :city, :address, :user_id, presence: {message: "%{attribute}を入力してください"}
  validates :first_name, :last_name, :first_name_kana,:last_name_kana, format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: "%{attribute}に数字や特殊文字は使用できません"}
  validates :first_name_kana, :last_name_kana, format: { with: /\A(?:\p{Katakana})+\z/, message: "%{attribute}はカナ文字を入力してください"}
  validates :zip_code, length: {is: 7, message: "フォーマットが不適切です"}, numericality: {message: "フォーマットが不適切です"}
  validates :tel, format: {with: /\A\d{10}$|^\d{11}\z/}

  def change_string
    self.first_name_kana    = self.first_name_kana.tr('ぁ-ん','ァ-ン')
    self.last_name_kana     = self.last_name_kana.tr('ぁ-ん','ァ-ン')
  end


  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

end
