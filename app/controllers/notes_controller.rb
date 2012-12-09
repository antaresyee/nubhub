class NotesController < ApplicationController
  def index
  	@notes = Note.all
  end

  def show
  end

  def new
  	@note = Note.new
    @course = Course.find(params[:course])
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def create
  	@note = current_user.notes.build(file: params[:note][:file])
    @note.course = Course.find(params[:course])
    if !params[:course].blank?
      @course = Course.find(params[:course])
      if !@course.notes.include?(@note)
        @course.notes << @note
      end
    end
  	if @note.save
  		flash[:success] = "Note uploaded."
    end
    if request.xhr?
      respond_to do |format|
        format.html { redirect_to current_user }
      end
    else 
      redirect_to current_user
  	end
  end

  def destroy
    if !params[:note].blank?
      @note = Note.find(params[:note])
      @course = Course.find(params[:course])
      if @course.notes.include?(@note)
        @course.notes.delete(@note)
      end
      if @note.delete
        flash[:success] = "Note destroyed."
      end
    end
    respond_to do |format|
      format.html { redirect_to current_user }
    end
  end




end
