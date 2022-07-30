module ApplicationHelper

  include Pagy::Frontend

  def current(path)
    return 'is-active' if request.path == path
    ''
  end

  def is_super
    if current_user.lead? || current_user.admin?
      return true
    end
    
    return false
  end

  def format_time(time, timezone)
    time.in_time_zone(timezone)
  end

end