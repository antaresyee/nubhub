class SubjectsController < ApplicationController
  
  def show
    @subject = Subject.find(params[:id])
    @courses = @subject.courses
    @instructors = @subject.instructors_by_count
    if request.xhr?
      respond_to do |format|
        format.html { render partial: 'show' }
      end
    end
  end

end
