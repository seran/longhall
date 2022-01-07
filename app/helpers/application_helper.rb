module ApplicationHelper

  include Pagy::Frontend

  def current(path)
    return 'is-active' if request.path == path
    ''
  end

end