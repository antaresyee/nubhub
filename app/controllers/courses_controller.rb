class CoursesController < ApplicationController
  def show
    @course = Course.find_by_id(params[:id])
    if request.xhr?
      respond_to do |format|
        format.html { render partial: 'show' }
      end
    else
      render 'show'
    end
  end

  def index
    @subjects = Subject.all.sort_by &:abbr
    if request.xhr?
      respond_to do |format|
        format.html { render partial: 'courses/index' }
      end
    else
      render 'index'
    end
  end

  def results
    @search = Course.search do |q|
      q.fulltext(params[:search])
    end
    @courses = @search.results
  end
end
