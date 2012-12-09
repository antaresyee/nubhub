class NoteUploadRelationshipsController < ApplicationController

  def destroy
    if !params[:course].blank?
      @course = Course.find(params[:course])
      @note = Note.find(params[:note])
      if @course.notes.include?(@note)
        @course.notes.delete(@note)
      end
    end
    respond_to do |format|
      format.html
    end
  end

  def create
  	if !params[:course].blank?
	  @course = Course.find(params[:course])
	  @note = Note.find(params[:note])
      if !@course.notes.include?(@note)
        @course.notes << @note
        flash[:success] =  "Added note"
      end
    end
  end

end
