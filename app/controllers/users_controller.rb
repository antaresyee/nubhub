class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def show
		@user = current_user
		@notes = @user.notes.paginate(page: params[:page])
		@courses = @user.courses
    	if request.xhr?
    		respond_to do |format|
    			format.html { redirect_to current_user }
    		end
    	end
	end

	def ajax
		@user = User.find(params[:user])
		@course = Course.find(params[:course])
		@course_id = params[:course]
		if @user.courses.include?(@course)
			@course = @user.courses.find(params[:course])
			@user.courses.delete(@course)
		end
		respond_to do |format|
			format.html { redirect_to current_user }	
			format.js
		end
	end
end
