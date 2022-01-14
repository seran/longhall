class ApplicationController < ActionController::Base
	include Pagy::Backend

	private
	def check_admin
		if !current_user.admin?
			redirect_to(root_path, notice: "You need administrative access!")
		end
	end
end
