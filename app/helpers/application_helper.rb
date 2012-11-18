module ApplicationHelper

	def gravatar_for(user)
		gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
		gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png"
		image_tag(gravatar_url, atl: user.name, class: "gravatar")
	end

	def gravatar_change(user)
		link_to("Change", "http://gravatar.com/email")
	end

	def capitalize(str)
		retstring = ""
		for part in str.split
			retstring=retstring+part.capitalize!+ " "
		end
		return retstring.strip
	end

	def courseToString(course)
		courseToCode(course)+" "+course.name
	end

	def courseToStringNoSpc(course)
		ret = ""
		courseToString(course).delete("-/()").split.each do |str|
			ret += str
		end
		return ret
	end

	def courseToCode(course)
		course.subject.abbr+course.new_number+"/"+course.old_number
	end

end
