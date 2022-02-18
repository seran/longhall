class Admin::UsersController < ApplicationController

	before_action :authenticate_user!, :check_admin
	before_action :set_record, only: [:view, :edit, :update, :delete]

	def index
		if !params[:search].blank?
			@parameter = params[:search].downcase
			@users = User.all.where("lower(email) LIKE :search", search: "%#{@parameter}%")
		else
			@users = User.all()
		end
	end

	def new
		@record = User.new
	end

	def create
	end

	def edit

	end

	def update
	end

	private
	def set_record
		@record = User.find_by(uuid: params[:uuid])
		if @record.nil?
			redirect_to(root_path, notice: "No record found!")
		end
	end
end
