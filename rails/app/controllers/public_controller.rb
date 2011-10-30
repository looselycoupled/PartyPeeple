class PublicController < ApplicationController
  def index
    if authenticated?
      
    else
      render '_login'
    end
  end

  def login
    auth = FbGraph::Auth.new(FB_CONFIG[:app_id], FB_CONFIG[:app_secret])
    auth.from_cookie(cookies) 
    @fb = auth.user.fetch
    
    @person = Person.find_or_initialize_by_identifier(@fb.identifier)
    @person.name = @fb.name
    @person.identifier = @fb.identifier
    @person.access_token = @fb.access_token.access_token
    
    @person.save!
    @person.delay.fetch_email
    
    session[:identifier] = @fb.identifier
    
    redirect_to root_url
    
  end

  def logout
    session[:identifier] = nil
    cookies.delete "fbsr_#{FB_CONFIG[:app_id]}"
    redirect_to root_url
  end

  def about
  end

end
