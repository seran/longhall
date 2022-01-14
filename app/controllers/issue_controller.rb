class IssueController < ApplicationController

	before_action :authenticate_user!
	before_action :set_record, only: [:view, :edit, :update, :delete]

	def index
			query = Issue.where(nil)

			if !params[:status].blank?
				query = query.filter_by_status(params[:status]) if params[:status].present?
			end

			if !params[:severity].blank?
				query = query.filter_by_severity(params[:severity]) if params[:severity].present?
			end

			if !params[:scope].blank?
				query = query.filter_by_scope(params[:scope]) if params[:scope].present?
			end

			@open_records = query.where("status = 0").size
			@closed_records = query.where("status = 1").size
			@inprogress_records = query.where("status = 2").size
			@pagy, @records = pagy(query.order('id desc'), items: 5)

	end

	def view
		@pagy, @comments = pagy(@record.comments.order('id desc'), items: 3)

		@comment = Comment.new
		@comment.issue_id = @record.id
	end


	def new
		if !params[:uuid].nil?
			@scope = Scope.find_by(uuid: params[:uuid])

			@record = Issue.new
			@record.scope_id = @scope.id

			@scope_uuid = @scope.uuid
		else
			@record = Issue.new
			@scope_uuid = nil
		end
	end

	def create
			@record = Issue.new(request_params)
			if !params[:uuid].nil?
				@scope = Scope.find_by(uuid: params[:uuid])
				@record.scope_id = @scope.id
			end
			@record.user_id = current_user.id
			@record.save!

			if @record.valid?
				redirect_to(view_issue_path(@record.uuid), notice: 'Issue created successfully.' )
			else
				redirect_to({:controller => "issue", :action => "index"}, notice: 'Unable to save, try again.' )
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
		params.require(:issue).permit(:title, :issue, :description, :score, :severity, :status, :scope_id)
	end

end
