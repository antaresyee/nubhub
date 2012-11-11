module ApplicationHelper

	def gravatar_for(user)
		gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
		gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png"
		image_tag(gravatar_url, atl: user.name, class: "gravatar")
	end

	def gravatar_change(user)
		link_to("Change", "http://gravatar.com/email")
	end

end
