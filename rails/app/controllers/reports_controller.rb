class ReportsController < ApplicationController

  def index
    redirect_to :action => [:gender, :leaderboard, :average_friends, :breakdown].sample
  end

  def gender
    @males = Person.males.count
    @females = Person.females.count    
  end
  
  def outcomes
    @males = Person.males.count
    @females = Person.females.count    
  end
  
  def average_friends
    friend_counts = ActiveRecord::Base.connection.execute("select count(friendships.friend_id) from people inner join friendships on people.id = friendships.person_id where gender is not null group by name").to_a.flatten
    @average_friends = friend_counts.inject(0){|a,b| a + b} / friend_counts.size
  end
  
end
