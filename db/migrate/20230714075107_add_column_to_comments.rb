class AddColumnToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :user
    add_reference :likes, :user
    remove_reference :likes, :post
  end
end
