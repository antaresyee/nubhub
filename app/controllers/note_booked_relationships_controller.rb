class NoteBookedRelationshipsController < ApplicationController

  def destroy
    if !params[:user].blank?
      @user = User.find(params[:user])
      @course = Course.find(params[:course])
      if @user.courses.include?(@course)
        @user.courses.delete(@course)
        flash[:success] =  "Removed course"
      end
      @subject = Subject.find(params[:id])
      respond_to do |format|
        format.html { redirect_to @subject } 
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
      @subject = Subject.find(params[:subject])
      respond_to do |format|
        format.html { redirect_to @subject } 
        format.js
      end
    end
  end

  def create_for_user
    if !params[:user].blank?
      @user = User.find(params[:user])
      @course = Course.find(params[:course])
      if !@user.courses.include?(@course)
        @user.courses << @course
        flash[:success] =  "Added course"
      end
    end
  end

  def destroy_for_user
    if !params[:user].blank?
      @user = User.find(params[:user])
      @course = Course.find(params[:course])
      if @user.courses.include?(@course)
        @user.courses.delete(@course)
        flash[:success] =  "Removed course"
      end
    end
    respond_to do |format|
      format.js
    end
  end





end
