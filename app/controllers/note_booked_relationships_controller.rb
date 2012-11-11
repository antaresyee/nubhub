class NoteBookedRelationshipsController < ApplicationController

  def destroy
    if !params[:user].blank?
      @user = User.find(params[:user])
      @course = Course.find(params[:course])
      if @user.courses.include?(@course)
        @course = @user.courses.find(params[:course])
        @course.destroy
      end
      respond_to do |format|
        flash[:success] = "Deleted"
        format.html { redirect_to :back} 
        format.js
      end
    end
  end

  def create
  	if !params[:user].blank?
		  @user = User.find(params[:user])
		  @course = Course.find(params[:course])
      if !@user.courses.include?(@course)
        @user.courses << @course
      end
      respond_to do |format|
        flash[:success] = "HELLO OKAY"
        format.html { redirect_to :back} 
        format.js
      end
    end
  end

end
