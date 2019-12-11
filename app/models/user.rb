class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook]
  has_one  :address
  has_one :card
  has_one  :credit
  has_many :items
  has_many :purchases
  has_many :sns_auths, dependent: :destroy

  before_validation :change_string
  validates :nickname, :password, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth, presence: {message: "%{attribute}を入力してください"}
  validates :tel, presence: {message: "会員登録できません"}, uniqueness: {message: "すでに使用されている電話番号です"}
  validates :nickname, ban_reserved: true
  validates :nickname, mercari_fomat: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-zA-Z\d\-.]+\.[a-zA-Z]+\z/i, message: "フォーマットが不適切です"}
  validates :email, {uniqueness: {message: "メールアドレスに誤りがあります。ご確認いただき、正しく変更してください。"}}
  validates :password, length: {in: 7..128, message: "パスワードは7文字以上128文字以下で入力してください"}
  validates :password, {format: { with: /\A[a-zA-Z0-9]+\z/, message: "英字と数字両方を含むパスワードを設定してください"}}
  validates :first_name, :last_name, :first_name_kana,:last_name_kana, format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: "%{attribute}に数字や特殊文字は使用できません"}
  validates :first_name_kana, :last_name_kana, format: { with: /\A(?:\p{Katakana})+\z/, message: "%{attribute}はカナ文字を入力してください"}
  validates :tel, format: { with: /\A\d{10}$|^\d{11}\z/, message: "電話番号の書式を確認してください"}

  def change_string
    self.first_name_kana    = self.first_name_kana.tr('ぁ-ん','ァ-ン')
    self.last_name_kana     = self.last_name_kana.tr('ぁ-ん','ァ-ン')
    self.password = self.password.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')
  end

  def self.find_oauth(auth)
    snsauth = SnsAuth.where(uid: auth.uid, provider: auth.provider).first
    user = User.where(email: auth.info.email).first
    return { snsauth: snsauth, user: user}
  end

end