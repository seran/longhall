class ProjectsController < ApplicationController

	before_action :authenticate_user!
	before_action :set_report, only: [:show, :edit, :update, :delete, :delete_file]

	def index
		if !params[:search].blank?
			@parameter = params[:search].downcase
			@projects = Project.all.where("lower(name) LIKE :search", search: "%#{@parameter}%")
		else
			@projects = Project.all()
		end
	end

	def show
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.new(project_params)
		@project.user_id = current_user.id
		@project.save!

		if @project.valid?
			redirect_to({:controller => "report", :action => "show", :uuid => @project.uuid}, notice: 'Report submitted successfully.' )
		else
			redirect_to({:controller => "report", :action => "index"}, notice: 'Unable to save, try again.' )
		end
	end

	def edit
		if !current_user.id == @project.user_id
			redirect_to({:controller => "report", :action => "index", :uuid => @project.uuid}, notice: 'You can not edit this Project.' )
		end
		# @store = Store.find(current_user.team[0].store_id)
	end

	def update
		if @project.update(project_params)
			redirect_to({:action => "show", :uuid => @project.uuid}, notice: 'Product was successfully updated.' )
		else
			redirect_to({:controller => "report", :action => "index"}, notice: 'Unable to save, try again.' )
		end
	end

	def delete
		if current_user.id == @project.user_id || current_user.admin?
			@project.destroy
			if current_user.admin?
				redirect_back(fallback_location: root_path, notice: 'Deleted successfully.')
			else
				redirect_to({:controller => "home", :action => "index"}, notice: 'Deleted successfully.' )
			end
		else
			redirect_to({:action => "show", :uuid => @project.uuid}, notice: 'Unable to delete.' )
		end
	end

	private
	def set_project
		@report = Project.find_by(uuid: params[:uuid])
	end

	def project_params
		params.require(:report).permit(:title, :scope, :description, :score, :severity, :status, files: [])
	end

end
