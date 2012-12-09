class NoteUploadRelationshipsController < ApplicationController

  def destroy
  end

  def create
  	if !params[:course].blank?
	  @course = Course.find(params[:course])
	  @note = Note.find(params[:note])
      if !@course.notes.include?(@note)
        @course.notes << @note
      end
    end
  end

end
