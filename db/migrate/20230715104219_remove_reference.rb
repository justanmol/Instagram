class RemoveReference < ActiveRecord::Migration[7.0]
  def change
    remove_reference :followings, :users, foreign_key: true, null: false
  end
end
