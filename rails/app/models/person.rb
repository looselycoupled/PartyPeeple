class Person < ActiveRecord::Base
  has_and_belongs_to_many :pages

  def fetch_facebook_data
    fb = FbGraph::User.me(access_token).fetch
    
    likes = fb.likes




  end


  def chosen_a_team?
    !preference.nil?
  end
  
  
  
  
  
  
  
  
end
