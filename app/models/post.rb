class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  belongs_to :author

  has_many :elements, dependent: :destroy

  has_one_attached :header_image
  
  validates_presence_of :title, :description

  scope :published, -> do 
    where(published: true)
  end
  
  scope :recently_published, -> do
    order(published_at: :desc)
  end
  
end
