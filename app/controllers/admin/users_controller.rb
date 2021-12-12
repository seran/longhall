class Admin::UsersController < ApplicationController

	def index
		if !params[:search].blank?
			@parameter = params[:search].downcase
			@users = User.all.where("lower(email) LIKE :search", search: "%#{@parameter}%")
		else
			@users = User.all()
		end
	end
end
