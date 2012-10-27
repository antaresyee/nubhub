class NotesController < ApplicationController
  def index
  	@notes = Note.all
  end

  def show
  end

  def new
  	@note = Note.new
  end

  def create
  	@note = Note.new(user_id: current_user.id, 
  		file: params[:note][:file])
  	if @note.save
  		flash[:success] = "Note uploaded."
  		redirect_to current_user
  	else 
  		render 'new'
  	end
  end
end
