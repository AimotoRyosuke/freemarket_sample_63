class Image < ApplicationRecord
  mount_uploader :image, ImagesUploader
  belongs_to :item
  
end
