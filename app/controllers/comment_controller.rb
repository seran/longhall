class CommentController < ApplicationController

  before_action :authenticate_user!

  def create
    @issue = Issue.find_by(uuid: params[:uuid])

    if @issue.nil?
      redirect_to root_path
    else

      @record = Comment.new(request_params)
      @record.user_id = current_user.id
      @record.issue_id = @issue.id

      if @record.valid?
        @record.save!
        redirect_to(view_issue_path(@issue.uuid), notice: 'Comment added successfully.' )
      else
        redirect_to(view_issue_path(@issue.uuid), alert: 'Comment can not be blank.')
      end
    end
  end

  private
  def request_params
    params.require(:comment).permit(:message)
  end
end
