class SecureBlobsController < ApplicationController
	include ActiveStorage::SetBlob
	before_action :authenticate_user!

	def show
		# expires_in ActiveStorage.service_urls_expire_in
		# redirect_to @blob.service_url(disposition: params[:disposition])

		if current_user.report.includes(:files_blobs).where(active_storage_blobs: {id: @blob.id}).exists?
			expires_in ActiveStorage.service_urls_expire_in
			redirect_to @blob.url(disposition: params[:disposition])
		else
			head :unauthorized
		end

	end
end
end
