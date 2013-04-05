module StaticPagesHelper

	def ticket_goal
		ticket_goal = 100
	end

	def signed_in?
  		!current_user.nil?
  	end

  	def current_user
  		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
  	end
end
