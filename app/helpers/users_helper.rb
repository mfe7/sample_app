module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

	def active_card
  		if @customer.active_card == nil
			puts 'No active card.'
		else
			puts "$"+ ticket_price*@user.tickets_wanted.to_i() +".00"
		end
	end
end
