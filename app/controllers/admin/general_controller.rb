class Admin::GeneralController < ApplicationController
  before_action :authenticate_user!, :check_admin
end
