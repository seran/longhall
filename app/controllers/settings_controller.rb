class SettingsController < ApplicationController
	before_action :check_admin, :authenticate_user!

	def index
	end

	private
	def check_admin
		return true
	end
end
