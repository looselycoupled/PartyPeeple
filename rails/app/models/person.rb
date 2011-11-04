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

    self.digital_capital = calculate_digital_capital(fb)
    save!
  end


  
  def chosen_a_team?
    !preference.nil?
  end
  
  
private
  
  def calculate_digital_capital(fb)
    # Digital Capital (rounded to nearest whole number) 
    # c = The number of comments attached to the user’s most 25* recent Facebook status updates and shared articles. 
    # l = The number of likes attached to the user’s most 25* recent Facebook status updates and shared articles. 
    # f = The number of Facebook friends the user has. 
    # p = The number of photo tags from users that is not the user in the last 30 days.
    
    f = fb.friends.count
    l = fb.statuses.map{|s| s.likes.count}.inject(0){|r,n| r + n}
    c = fb.statuses.map{|s| s.comments.count}.inject(0){|r,n| r + n}
    p = 0
    
    ((((20 * (5 * c + 2 * l)) + f) / Math.sqrt(f)) + p).round
    
  end
  
  
  
  
  
  
end
