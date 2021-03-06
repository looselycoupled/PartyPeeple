class PublicController < ApplicationController

  def index
    if authenticated?
      redirect_to party_url
    end
    @body_id = "homepage"
  end

  def closed
    logout_user
  end

  def login
    auth = FbGraph::Auth.new(FB_CONFIG[:app_id], FB_CONFIG[:app_secret])
    auth.from_cookie(cookies) 
    @fb = auth.user.fetch
    
    # find/create and save user data
    @person = Person.find_or_initialize_by_identifier(@fb.identifier)

    if @person.gender.nil?
      @person.name = @fb.name
      @person.identifier = @fb.identifier
      @person.access_token = @fb.access_token.access_token
      @person.email = @fb.email
      @person.first_name = @fb.first_name
      @person.birthday = @fb.birthday
      @person.gender = @fb.gender
      @person.religion = @fb.religion
      @person.political = @fb.political
      @person.relationship_status = @fb.relationship_status
      if @fb.interested_in.count == 2
        @person.preference = "both"
      elsif @fb.interested_in.count == 1
        @person.preference = @fb.interested_in[0]
      end
      @person.save

      # add jobs to fetch more info
      @person.delay.fetch_facebook_data
    end

    
    # save session info
    session[:identifier] = @fb.identifier
    session[:administrator] = FB_CONFIG[:administrators].include? @fb.identifier
    
    redirect_to party_url
    
  end

  def logout
    logout_user
    redirect_to root_url
  end

  private
  
  def logout_user
    session[:identifier] = nil
    cookies.delete "fbsr_#{FB_CONFIG[:app_id]}"
  end


end
