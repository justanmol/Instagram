class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :post, :like, :comment
  belongs_to :user
  # has_many :comments
  # has_many :likes

  def like
    object.likes.count
  end

  def post
    object.post.url
  end

  def comment
    object.comments.all
  end
end
