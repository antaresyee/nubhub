class NotesController < ApplicationController

  before_filter :signed_in_user, only: [:create, :destroy]

  def index
  end

  def create
    @note = current_user.notes.build(params[:micropost])
    if @note.save
      flash[:success] = "Note created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'pages/home'    
    end
  end

  def destroy
    @note.destroy
    redirect_to root_url
  end

  private

    def correct_user
      @note = current_user.notes.find_by_id(params[:id])
      redirect_to root_url if @note.nil?
    end
end
