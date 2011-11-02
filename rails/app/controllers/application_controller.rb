class ApplicationController < ActionController::Base
  before_filter :load_person
  protect_from_forgery

  layout "general"

  private 
    
  def authenticated?
    if session[:identifier].nil?
      false
    else
      true
    end
  end
  
  def administrator?
    session[:administrator]
  end
  
  def load_person
    if authenticated?
      @person = Person.find_by_identifier(session[:identifier])
    end
  end
  
end
