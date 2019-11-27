class Credit < ApplicationRecord
  has_many :users
  validates :number, :year, :month, :security, presence: {message: "必須項目です"}
  validates :number, numericality: {message: "半角数字で入力してください"}, length: { in: 14..16, message: "カード番号が正しくありません"}
  validates :security, format: { with: /\A\d{3,4}\z/, message: "セキュリティコードが正しくありません"} 
end
