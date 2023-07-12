class Post < ApplicationRecord
  belongs_to :user
  # belongs_to :comment
  has_many :likes
  has_many :comments

  validates :content, presence: true 
  validates :post, presence: true
  validates :like, numericality: { only_integer: true }

  has_one_attached :post
  def set_default_like
    self.like = 0 if like.nil?
  end
end