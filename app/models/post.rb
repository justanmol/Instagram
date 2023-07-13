class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :content, presence: true 
  validates :post, presence: true
  validates :like, numericality: { only_integer: true }

  has_one_attached :post
  def set_default_like
    self.like = 0 if like.nil?
  end
end