class User < ApplicationRecord
  has_secure_password
  
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  
  # has_many :follows, foreign_key: :follower_id, dependent: :destroy
  # has_many :followees, through: :follows, dependent: :destroy
  # has_many :inverse_follows, class_name: 'Following', foreign_key: :followee_id, dependent: :destroy
  # has_many :followers, through: :inverse_follows

  # has_many :followings, foreign_key: :follower_id, dependent: :destroy
  # has_many :followed_users, through: :followings, source: :followed_user

  # has_many :inverse_followings, foreign_key: :followed_user_id, class_name: 'Following', dependent: :destroy
  # has_many :followers, through: :inverse_followings, source: :follower

  validates :email, presence: true, uniqueness: {message:'is already exist'},format:{ with: URI::MailTo::EMAIL_REGEXP }
  validates :password_digest, presence: true

  # def follow(user)
  # 	followed_users << user
  # end

  # def unfollow(user)
  # 	followed_users.delete(user)
  # end

  # def following?(user)
  # 	followed_users.include?(user)
  # end

  # def error_messages
  #   errors.full_messages.to_sentence
  # end
end