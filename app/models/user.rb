class User < ApplicationRecord
  has_secure_password
  has_many :likes, through: :post
  has_many :posts
  validates :email, presence:true, uniqueness: {message:'is already exist'},format:{ with: URI::MailTo::EMAIL_REGEXP }
  validates :password_digest, presence:true

  def error_messages
    errors.full_messages.to_sentence
  end
end