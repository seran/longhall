class IssueController < ApplicationController

	before_action :authenticate_user!
	before_action :set_record, only: [:view, :edit, :update, :delete]

	def index
		if !params[:search].blank?
			@parameter = params[:search].downcase
			search_query = Issue.all.where("lower(title) LIKE :search", search: "%#{@parameter}%")
			@open_records = search_query.where("status = 0").size
			@closed_records = search_query.where("status = 1").size
			@inprogress_records = search_query.where("status = 2").size
			@pagy, @records = pagy(search_query.order('id desc'), items: 5)
		else
			all_records_query = Issue.all
			@open_records = all_records_query.where("status = 0").size
			@closed_records = all_records_query.where("status = 1").size
			@inprogress_records = all_records_query.where("status = 2").size
			@pagy, @records = pagy(all_records_query.order('id desc'), items: 5)
		end
	end

	def view
		@pagy, @comments = pagy(@record.comments.order('id desc'), items: 3)

		@comment = Comment.new
		@comment.issue_id = @record.id
	end


	def new
		@scope = Scope.find_by(uuid: params[:uuid])

		if @scope.nil?
			redirect_to root_path
		else
			@record = Issue.new
			@record.scope_id = @scope.id
		end
	end

	def create
		@scope = Scope.find_by(uuid: params[:uuid])

		if @scope.nil?
			redirect_to root_path
		else

			@record = Issue.new(request_params)
			@record.scope_id = @scope.id
			@record.user_id = current_user.id
			@record.save!

			if @record.valid?
				redirect_to(view_issue_path(@record.uuid), notice: 'Issue created successfully.' )
			else
				redirect_to({:controller => "issue", :action => "index"}, notice: 'Unable to save, try again.' )
			end
		end
	end

	def edit
		if !current_user.id == @record.user_id
			redirect_to({:controller => "issue", :action => "index", :uuid => @record.uuid}, notice: 'You can not edit this Issue.' )
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
		@record = Issue.find_by(uuid: params[:uuid])
		if @record.nil?
			redirect_to(root_path, notice: "No record found!")
		end
	end

	def request_params
		params.require(:issue).permit(:title, :issue, :description, :score, :severity, :status)
	end

end
