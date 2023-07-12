class RemoveReferenceUserFromlike < ActiveRecord::Migration[7.0]
  def change
    remove_reference :likes, :user, foreign_key: true, index: false
  end
end
