
class BrowserController < ApplicationController

	def index
    	@subjects = Subject.all.sort_by &:abbr
	end

	def ajax
		@notes = Note.all
    	@subjects = Subject.all.sort_by &:abbr
    	@path = params[:path]
		@newHtml = render_to_string partial: @path
		respond_to do |format|
			format.html { redirect_to browser_index_path + "#notes" }
			format.js
			flash[:success] = "RUNNING"
		end
	end

	def ajax_forward
		respond_to do |format|
			format.html { redirect_to :back }
			format.js
		end
	end

end
