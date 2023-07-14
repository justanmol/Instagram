class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true
  validates :likeable_type, inclusion: {in: %w(Post Comment), message: "Type is not valid"}
end