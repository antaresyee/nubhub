class NotesController < ApplicationController
  def index
  	@notes = Note.all
  end

  def show
  end

  def new
  	@note = Note.new
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def create
  	@note = current_user.notes.build(file: params[:note][:file])
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
end
