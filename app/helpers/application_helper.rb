module ApplicationHelper

  def current_class?(test_path)
    return 'is-active' if request.path == test_path
    ''
  end

end