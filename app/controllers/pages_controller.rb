class PagesController < ApplicationController
  def home
    if signed_in?
      @note  = current_user.notes.build
    end
  end

  def help
  end
end
