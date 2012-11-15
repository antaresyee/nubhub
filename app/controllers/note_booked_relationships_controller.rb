class NoteBookedRelationshipsController < ApplicationController

  def destroy
    if !params[:user].blank?
      @user = User.find(params[:user])
      @course = Course.find(params[:course])
      if @user.courses.include?(@course)
        @course = @user.courses.find(params[:course])
        @user.courses.delete(@course)
      end
      respond_to do |format|
        flash[:success] = "Deleted"
        format.html { redirect_to subject_url } 
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
        flash[:success] =  "Added course"
      end
      respond_to do |format|
        format.html { redirect_to :back } 
        format.js
      end
    end
  end

end
