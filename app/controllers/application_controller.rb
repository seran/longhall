class ApplicationController < ActionController::Base
	include Pagy::Backend

	private
	def check_admin
		if !current_user.admin?
			redirect_to(root_path, notice: "You need administrative access!")
		end
	end

	def check_lead
		if !current_user.lead?
			redirect_to(root_path, notice: "You need leader access!")
		end
	end
end
