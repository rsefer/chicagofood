module TryHelper

	def user_try_count(user_id)
	  Try.where(user_id: user_id).count()
	end
	
end
