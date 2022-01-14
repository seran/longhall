class Admin::UsersController < ApplicationController

	before_action :authenticate_user!, :check_admin

	def index
		if !params[:search].blank?
			@parameter = params[:search].downcase
			@users = User.all.where("lower(email) LIKE :search", search: "%#{@parameter}%")
		else
			@users = User.all()
		end
	end
end