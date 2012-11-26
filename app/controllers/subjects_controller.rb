class SubjectsController < ApplicationController
  
  def show
    @subject = Subject.find(params[:id])
    @courses = @subject.courses.paginate(per_page: 10, page: params[:page])
    @instructors = @subject.instructors_by_count
    if request.xhr?
      respond_to do |format|
        format.html { render partial: 'show' }
      end
    end
  end

  def index
    @subjects = Subject.paginate(
      per_page: 10, 
      page: params[:page],
      order: 'abbr'
    )
  end

  def results
    @search = Subject.search do
      fulltext params[:search]
    end
    @subjects = @search.results
  end

  def show_courses
    @subject = Subject.find(params[:id])
    @courses = @subject.courses.paginate(
        :page => params[:page], 
        :per_page => 15
      )
  end

  def show_instructors
    @subject = Subject.find(params[:id])
    @instructors = Instructor.select{|i|
      i.subjects_by_count.include?(@subject)
    }
  end
end
