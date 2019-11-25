class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable

  before_validation {
    self.first_name_kana    = first_name_kana.tr('ぁ-ん', 'ァ-ン'),
    self.last_name_kana     = last_name_kana.tr('ぁ-ん', 'ァ-ン'),
    self.encrypted_password = encrypted_password.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')
  }

  validates :nickname, :email, :encrypted_password, :first_name, :last_name, :first_name_kana, :last_name_kana, presence: true
  validates :birth, presence: { message: "を正しく入力してください"}
  validates :nickname, ban_reserved: true
  validates :nickname, mercari_fomat: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-zA-Z\d\-.]+\.[a-zA-Z]+\z/i, message: "フォーマットが不適切です"}
  validates :email, {presence: true, uniqueness: {message: "メールアドレスに誤りがあります。ご確認いただき、正しく変更してください。"}}
  validates :encrypted_password, length: {in: 7..128}
  # , message: "パスワードは7文字以上128文字以下で入力してください"
  validates :encrypted_password, {format: { with: /\A[a-zA-Z0-9]+\z/}}
  # , message: "英字と数字両方を含むパスワードを設定してください"
  validates :first_name, :last_name, :first_name_kana,:last_name_kana, {format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/}}
  # , message: "%{attribute}に数字や特殊文字は使用できません"
  validates :first_name_kana, :last_name_kana, {format: { with: /\A(?:\p{Katakana})+\z/}}
  # , message: "%{attribute}はカナ文字を入力してください"
end