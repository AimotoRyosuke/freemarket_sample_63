class SnsAuth < ApplicationRecord
belongs_to :user
validates :provider, :uid, presence: true, uniqueness: true

end
