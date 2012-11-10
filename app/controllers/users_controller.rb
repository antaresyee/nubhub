class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def show
		@user = current_user
		@notes = @user.notes.paginate(page: params[:page])
		@bookedCourses = @user.courses
	end
end
