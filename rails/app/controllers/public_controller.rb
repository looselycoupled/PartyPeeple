class PublicController < ApplicationController

  def index
    if authenticated?
      redirect_to party_url
    else
      render '_login'
    end
  end

  def login
    auth = FbGraph::Auth.new(FB_CONFIG[:app_id], FB_CONFIG[:app_secret])
    auth.from_cookie(cookies) 
    @fb = auth.user.fetch
    
    # find/create and save user data
    @person = Person.find_or_initialize_by_identifier(@fb.identifier)
    @person.name = @fb.name
    @person.identifier = @fb.identifier
    @person.access_token = @fb.access_token.access_token
    @person.first_name = @fb.first_name
    @person.birthday = @fb.birthday
    @person.gender = @fb.gender
    @person.relationship_status = @fb.relationship_status
    @person.save!

    # add jobs to fetch more info
    # @person.delay.fetch_email
    
    # save session info
    session[:identifier] = @fb.identifier
    session[:administrator] = FB_CONFIG[:administrators].include? @fb.identifier
    
    redirect_to party_url
    
  end

  def logout
    session[:identifier] = nil
    cookies.delete "fbsr_#{FB_CONFIG[:app_id]}"
    redirect_to root_url
  end

  def about
  end

  def help
  end

end
