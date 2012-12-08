class NoteBookedRelationshipsController < ApplicationController

  def destroy
    if !params[:user].blank?
      @user = User.find(params[:user])
      @course = Course.find(params[:course])
      if @user.courses.include?(@course)
        @course = @user.courses.find(params[:course])
        @user.courses.delete(@course)
      end
    end
    respond_to do |format|
      format.html
    end
  end

  def create
  	if !params[:user].blank?
      puts params[:user]
		  @user = User.find(params[:user])
		  @course = Course.find(params[:course])
      if !@user.courses.include?(@course)
        @user.courses << @course
        flash[:success] =  "Added course"
      end
    end
  end

end
