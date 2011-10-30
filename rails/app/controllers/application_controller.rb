class ApplicationController < ActionController::Base
  before_filter :load_person
  protect_from_forgery

  private 
    
  def authenticated?
    if session[:identifier].nil?
      false
    else
      true
    end
  end
  
  def load_person
    if authenticated?
      @person = Person.find_by_identifier(session[:identifier])
    end
  end
  
end
