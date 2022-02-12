class ProjectController < ApplicationController

	before_action :authenticate_user!
	before_action :set_record, only: [:view, :edit, :update, :delete, :delete_file]
	before_action :check_super, only: [:new, :create, :edit, :update]

	def index
		if !params[:search].blank?
			@parameter = params[:search].downcase
			@records = Project.all.where("lower(name) LIKE :search", search: "%#{@parameter}%")
		else
			@pagy, @records = pagy(Project.all, items: 2)
		end
	end

	def view
		@pagy, @records = pagy(@record.scope, items: 2)
	end

	def new
		@record = Project.new
	end

	def create
		@record = Project.new(request_params)
		@record.user_id = current_user.id

		if @record.valid?
			@record.save!
			redirect_to(new_scope_path(@record.uuid), notice: 'Created successfully.' )
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @record.update(request_params)
			redirect_to view_project_path(@record.uuid), notice: 'Updated successfully.'
		else
			redirect_to edit_project_path(@record.uuid), alert: 'Unable to save, try again.'
		end
	end

	def delete
		if current_user.id == @record.user_id || current_user.admin?
			@record.destroy
			if current_user.admin?
				redirect_back(fallback_location: root_path, notice: 'Deleted successfully.')
			else
				redirect_to({:controller => "home", :action => "index"}, notice: 'Deleted successfully.' )
			end
		else
			redirect_to({:action => "show", :uuid => @record.uuid}, notice: 'Unable to delete.' )
		end
	end

	private
	def set_record
		@record = Project.find_by(uuid: params[:uuid])
		if @record.nil?
			redirect_to(root_path, notice: "No record found!")
		end
	end

	def request_params
		params.require(:project).permit(:title, :description)
	end

end
