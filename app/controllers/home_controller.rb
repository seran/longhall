class HomeController < ApplicationController

	before_action :authenticate_user!

	def index
		redirect_to(issues_list_path)
	end
end
