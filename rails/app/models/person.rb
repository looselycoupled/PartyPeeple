class Person < ActiveRecord::Base
  has_many :friendships
  has_many :friends, :through => :friendships
  # has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  # has_many :inverse_friends, :through => :inverse_friendships, :source => :person
  
  has_and_belongs_to_many :pages

  zodiac_reader :birthday

  scope :males, where(:gender => "male")
  scope :females, where(:gender => "female")


  def self.percentage_of_people(num)
    begin
      (num / Person.count.to_f * 100).round
    rescue
      0
    end
  end




  # provide first_name if not populated (move to create callback?)
  def first_name
    if read_attribute(:first_name).nil?
      read_attribute(:name).split(" ")[0]
    else
      read_attribute(:first_name)
    end
  end


  def fetch_facebook_data
    fb = FbGraph::User.me(access_token).fetch
    
    # save friends 
    fb.friends.each do |friend|
      p = Person.find_or_initialize_by_identifier(friend.identifier, :name => friend.name)
      friends << p unless friends.include? p
    end
    
    # save likes as pages
    likes = fb.likes
    likes.each do |page|
      p = Page.find_or_initialize_by_identifier(:identifier => page.identifier, :name => page.name, :category => page.category)
      pages << p unless pages.include? p
    end
    
    # save education 
    # TODO: fix category save
    # fb.education.each do |edu|
    #   page = edu.school
    #   p = Page.find_or_initialize_by_identifier(:identifier => page.identifier, :name => page.name, :category => page.category)
    #   pages << p unless pages.include? p
    # end
    # 
    # save work history
    # TODO: fix category save
    # fb.work.each do |job|
    #   page = job.employer
    #   p = Page.find_or_initialize_by_identifier(:identifier => page.identifier, :name => page.name, :category => page.category)
    #   pages << p unless pages.include? p
    # end
    
    self.digital_capital = calculate_digital_capital(fb)
    save!
  end

  
  
  
  def chosen_a_team?
    !preference.nil?
  end
  
  def books
    pages.select{|p| p.category == "Book"}
  end
  
  def tv_shows
    pages.select{|p| p.category == "Tv show"}
  end
  
  def movies
    pages.select{|p| p.category == "Movie"}
  end
  
  def bands
    pages.select{|p| p.category == "Musician/band"}
  end
  
  def teams
    pages.select{|p| p.category == "Professional sports team"}
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
    
    if (f > 0 )
      ((((20 * (5 * c + 2 * l)) + f) / Math.sqrt(f)) + p).round
    else
      1
    end
    
  end
  
  
  
  
  
  
end
