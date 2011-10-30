class ApplicationController < ActionController::Base
  before_filter :setup_fb_graph, :load_person
  protect_from_forgery

  private 
  
  def setup_fb_graph
    case Rails.env
      when "development"
        @app_id = "133107960128280"
        @app_secret = "f751d36bbfe6e9dd983f2516c040baaf"
      when "production"
        @app_id = "269316813112867"
        @app_secret = "e8724d598f1ea7e49254f0f80a03c7d2"
      end

    @app_perms = "email"
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
