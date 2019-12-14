class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
  has_one :address
  has_one :card
  has_one  :credit
  has_many :items
  has_many :purchases

  before_validation :change_string
  validates :nickname, :password, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth, presence: {message: "%{attribute}を入力してください"}
  validates :tel, presence: {message: "会員登録できません"}, uniqueness: {message: "この電話番号はすでに存在します"}
  validates :nickname, ban_reserved: true
  validates :nickname, mercari_fomat: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-zA-Z\d\-.]+\.[a-zA-Z]+\z/i, message: "フォーマットが不適切です"}
  validates :password, length: {in: 7..128, message: "パスワードは7文字以上128文字以下で入力してください"}
  validates :password, {format: { with: /\A[a-zA-Z0-9]+\z/, message: "英字と数字両方を含むパスワードを設定してください"}}
  validates :first_name, :last_name, :first_name_kana,:last_name_kana, format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: "%{attribute}に数字や特殊文字は使用できません"}
  validates :first_name_kana, :last_name_kana, format: { with: /\A(?:\p{Katakana})+\z/, message: "%{attribute}はカナ文字を入力してください"}
  validates :tel, format: { with: /\A\d{10}$|^\d{11}\z/, message: "電話番号の書式を確認してください"}

  def change_string
    self.first_name_kana    = first_name_kana.tr('ぁ-ん','ァ-ン')
    self.last_name_kana     = last_name_kana.tr('ぁ-ん','ァ-ン')
  end
end