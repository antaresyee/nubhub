class SubjectsController < ApplicationController
  
  def show
    @subject = Subject.find(params[:id])
    @courses = @subject.courses
    if request.xhr?
      respond_to do |format|
        format.html { render partial: 'show' }
      end
  	else
  		render 'show'
    end
  end

end
