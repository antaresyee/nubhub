class SearchesController < ApplicationController

	def results
		@courses_search = Sunspot.search Course do
			keywords params[:search]
		end
		@courses_results = @courses_search.results
	end

end
