class CoursesController < ApplicationController
  def show
    @course = Course.find_by_id(params[:id])
  end

  def index
    @subjects = Subject.all.sort_by &:abbr
    #here so the check boxes work
  end

  def results
    #for check boxes
    @search = Course.search do |q|
      q.fulltext(params[:search])
    end
    @courses = @search.results
  end
end
