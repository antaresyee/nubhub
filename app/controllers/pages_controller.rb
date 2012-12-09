class PagesController < ApplicationController
	def landing
		if user_signed_in?
			redirect_to current_user
		else 
			redirect_to action: "home"
		end
	end

	def home
	end

	def help
	end

	def about
	end
end
