class BrowserController < ApplicationController

	def index
    	@subjects = Subject.all.sort_by &:abbr
	end

	def ajax
		@search = params[:search]
    	@subjects = Subject.all.sort_by &:abbr
    	if !@search.nil?
    		if @search.length == 1 && "ABCDEFGHIJKLMOPQRSTUVWXYZ".include?(@search)
    			filtered_list = Array.new
    			@subjects.each do |sub|
    				if sub.name.starts_with?(@search) || sub.name.starts_with?(@search.downcase)
    					filtered_list << sub
    				end
    			end
    			@subjects = filtered_list
    		end
    	end
		respond_to do |format|
			format.html { render partial: 'browser/filtered' } 
			format.js
		end
	end

	def default
		@subjects = Subject.all.sort_by &:abbr
		respond_to do |format|
			format.html { render partial: 'browser/default' }
			format.js
		end
	end


	def results
		@search = Sunspot.search Course, Subject do
			keywords params[:search]
		end
		@search_results = @search.results		
	end



	def ajax_forward
		respond_to do |format|
			format.html { redirect_to :back }
			format.js
		end
	end




end
