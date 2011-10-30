class ApplicationController < ActionController::Base
  before_filter :setup_fb_graph, :load_person
  protect_from_forgery


  private 
  
  def setup_fb_graph
    @app_id = "133107960128280"
    @app_secret = "f751d36bbfe6e9dd983f2516c040baaf"
    @app_perms = ""
  end
  
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
