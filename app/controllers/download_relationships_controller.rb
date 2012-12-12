class DownloadRelationshipsController < ApplicationController

	def index
	end

	def create
		if !params[:note].blank?
			@note = Note.find(params[:note])
			@user = User.find(params[:user])
			@note.users << @user
			uploader = @note.file
			uploader.retrieve_from_store!(File.basename(@note.file.to_s))
			uploader.cache_stored_file!
			send_file uploader.file.path
		end
		redirect_to :back
	end

	def destroy
	end

end
