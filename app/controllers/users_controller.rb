class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def show
		@user = current_user
		if params[:state].nil?
			@state = "following"
		else
			@state = "upload"
		end
		@notes = @user.notes.paginate(page: params[:page])
		@courses = @user.courses
    	if request.xhr?
    		respond_to do |format|
    			format.html { redirect_to current_user }
    		end
    	end
	end

end
