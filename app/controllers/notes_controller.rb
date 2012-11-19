class NotesController < ApplicationController
  def index
  	@notes = Note.all
    respond_to do |format|
      format.html { render partial: "notes/index" }
      format.js
    end
  end

  def show
  end

  def new
  	@note = Note.new
  end

  def create
  	@note = current_user.notes.build(file: params[:note][:file])
  	if @note.save
  		flash[:success] = "Note uploaded."
  		redirect_to current_user
  	else 
  		render 'new'
  	end
  end
end
