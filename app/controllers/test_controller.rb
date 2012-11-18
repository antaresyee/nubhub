class TestController < ApplicationController
  def new
    redirect_to current_user
  end
end
