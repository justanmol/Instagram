class Following < ApplicationRecord
	validates :followee_id, uniqueness: { scope: :follower_id }
end
