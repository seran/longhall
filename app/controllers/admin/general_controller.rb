class Admin::GeneralController < ApplicationController
  before_action :authenticate_user!, :check_admin
  before_action :set_record, only: [:index, :update]

  def index
    if Option.exists?(1)
      @record = Option.find(1)
    else
      @record = Option.new
    end
  end

  def update
    if @record.update(request_params)
      redirect_to admin_general_page_path, notice: 'Updated successfully.'
    else
      redirect_to admin_general_page_path, alert: "Unable to update!"
    end
  end

  private
  def set_record
    @record = Option.find(1)
    if @record.nil?
      redirect_to(root_path, notice: "Options not found!")
    end
  end

  def request_params
    params.require(:option).permit(:slack, :notify_new, :notify_updates)
  end

end
