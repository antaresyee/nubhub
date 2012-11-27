class CoursesController < ApplicationController
  def show
    @course = Course.find_by_id(params[:id])
    @sections = @course.sections.paginate(per_page: 10, page: params[:page])
    if request.xhr?
      respond_to do |format|
        format.html { render partial: 'show' }
      end
    end
  end

  def index
    @subjects = Subject.all.sort_by &:abbr
    respond_to do |format|
      format.html { render partial: 'courses/index' }
      format.js
    end
  end

  def results
    @search = Course.search do |q|
      q.fulltext(params[:search])
    end
    @courses = @search.results
  end
end
