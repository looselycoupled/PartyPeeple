module ApplicationHelper

  def authenticated?
    if session[:identifier].nil?
      false
    else
      true
    end
  end
  
  # provide access to facebook config to views
  def FB_CONFIG
    FB_CONFIG
  end
  
end
