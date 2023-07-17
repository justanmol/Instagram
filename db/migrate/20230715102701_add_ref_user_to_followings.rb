class AddRefUserToFollowings < ActiveRecord::Migration[7.0]
  def change
    add_reference :followings, :users, foreign_key:true, null: false
  end
end
