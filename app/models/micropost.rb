class Micropost < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	validates :content, presence: true, length: { maximum: 140 }
	validates :user_id, presence: true

	def self.from_users_followed_by(user)

		#followed_users_ids = user.followed_users_ids
		#where("user_id IN (?) OR user_id = ?", followed_users_ids, user)
		#
		#The following is a better implementation based in subselect which 
		#arranges for all the 'set logic' to be pushed into the database, which is more efficient.
		
		followed_users_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
		where("user_id IN (#{followed_users_ids}) OR user_id = :user_id",
			user_id: user.id)
	end
end
