
class BrowserController < ApplicationController

	def index
    	@subjects = Subject.all.sort_by &:abbr
	end

	def ajax
		@notes = Note.all
		@newHtml = render_to_string 'notes/index'
		respond_to do |format|
			format.html { redirect_to :back }
			format.js
		end
	end

end
