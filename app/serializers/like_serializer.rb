class LikeSerializer < ActiveModel::Serializer
  attributes :id, :post

  def post
    object.likeable_type
  end
end
