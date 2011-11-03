class Person < ActiveRecord::Base
  has_and_belongs_to_many :pages

  def fetch_facebook_data
    fb = FbGraph::User.me(access_token).fetch
    
    # save likes as pages
    likes = fb.likes
    likes.each do |page|
      p = Page.find_or_initialize_by_identifier(:identifier => page.identifier, :name => page.name, :category => page.category)
      pages << p unless pages.include? p
    end

  end


  def chosen_a_team?
    !preference.nil?
  end
  
  
  
  
  
  
  
  
end
