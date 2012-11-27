class BrowserController < ApplicationController

	def index
    	@subjects = Subject.paginate(
    		per_page: 10, 
    		page: params[:page],
    		order: 'abbr'
    	)
    	if request.xhr?
    		respond_to do |format|
    			format.html { render partial: 'default' }
    		end
    	end
	end

	def results
		@search = Sunspot.search Course, Subject do
			keywords params[:search]
		end
		@search_results = @search.results		
	end

end
