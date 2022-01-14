class CommentController < ApplicationController

  before_action :authenticate_user!

  def create
    @issue = Issue.find_by(uuid: params[:uuid])

    if @issue.nil?
      redirect_to root_path
    else

      @record = Comment.new(request_params)
      @record.issue_id = @issue.id
      @record.save

      if @record.valid?
        redirect_to(view_issue_path(@issue.uuid), notice: 'Comment added successfully.' )
      else
        redirect_to(root_path, notice: 'Unable to save, try again.' )
      end
    end
  end

  private
  def request_params
    params.require(:comment).permit(:message)
  end
end
