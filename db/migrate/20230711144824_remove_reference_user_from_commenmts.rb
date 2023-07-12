class RemoveReferenceUserFromCommenmts < ActiveRecord::Migration[7.0]
  def change
    remove_reference :comments, :user, foreign_key: true, index: false
  end
end
