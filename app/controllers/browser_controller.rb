class BrowserController < ApplicationController

	def index
    	@subjects = Subject.all
    	if request.xhr?
    		respond_to do |format|
    			format.html { render partial: 'default' }
    		end
    	else 
    		render 'index'
    	end
	end

	def results
		@search = Sunspot.search Course, Subject do
			keywords params[:search]
		end
		@search_results = @search.results		
	end

end
