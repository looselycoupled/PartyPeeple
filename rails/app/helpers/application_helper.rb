module ApplicationHelper

  def authenticated?
    if session[:identifier].nil?
      false
    else
      true
    end
  end
  
end
