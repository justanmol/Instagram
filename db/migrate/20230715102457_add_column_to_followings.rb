class AddColumnToFollowings < ActiveRecord::Migration[7.0]
  def change
    add_column :followings, :follower_id, :integer
    add_column :followings, :followee_id, :integer
  end
end
