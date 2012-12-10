class NoteBookedRelationshipsController < ApplicationController

  def destroy
    if !params[:user].blank?
      @user = User.find(params[:user])
      @course = Course.find(params[:course])
      if @user.courses.include?(@course)
        @user.courses.delete(@course)
        flash[:success] =  "Removed course"
      end
      if params[:on_user_page]
        return
      else 
        @subject = Subject.find(params[:id])
        respond_to do |format|
          format.html { redirect_to @subject } 
          format.js
        end
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
      @subject = Subject.find(params[:subject])
      respond_to do |format|
        format.html { redirect_to @subject } 
        format.js
      end
    end
  end

end
