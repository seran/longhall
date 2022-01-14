class ScopeController < ApplicationController

	before_action :authenticate_user!
	before_action :set_record, only: [:view, :edit, :update, :delete]

	def index
		if !params[:search].blank?
			@parameter = params[:search].downcase
			@records = Scope.all.where("lower(name) LIKE :search", search: "%#{@parameter}%")
		else
			@records = Scope.all()
		end
	end

	def view
		if @record.issue.length > 0
			@pagy, @records = pagy(@record.issue.order('id desc'), items: 2)
		end
	end

	def new
		@project = Project.find_by(uuid: params[:uuid])

		if @project.nil?
			redirect_to root_path
		else
			@record = Scope.new
			@record.user_id = current_user.id
			@record.project_id = @project.id
		end
	end

	def create
		@project = Project.find_by(uuid: params[:uuid])

		if @project.nil?
			redirect_to root_path
		else

			@record = Scope.new(request_params)
			@record.project_id = @project.id
			@record.user_id = current_user.id
			@record.save!

			if @record.valid?
				redirect_to(view_scope_path(@record.uuid), notice: 'Scope created successfully.' )
			else
				redirect_to({:controller => "issue", :action => "index"}, notice: 'Unable to save, try again.' )
			end
		end
	end

	def edit
		if !current_user.id == @record.user_id
			redirect_to({:controller => "issue", :action => "index", :uuid => @record.uuid}, notice: 'You can not edit this Scope.' )
		end
	end

	def update
		if @record.update(request_params)
			redirect_to({:action => "show", :uuid => @record.uuid}, notice: 'Product was successfully updated.' )
		else
			redirect_to({:controller => "issue", :action => "index"}, notice: 'Unable to save, try again.' )
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
		@record = Scope.find_by(uuid: params[:uuid])
		if @record.nil?
			redirect_to(root_path, notice: "No record found!")
		end
	end

	def request_params
		params.require(:scope).permit(:title, :version, :project, :description)
	end

end
