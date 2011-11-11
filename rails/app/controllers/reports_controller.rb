class ReportsController < ApplicationController

  def index
    redirect_to :action => [:gender, :leaderboard].sample
  end

  def gender
    @males = Person.males.count
    @females = Person.females.count    
  end
  
  def average_friends
    @average_friends = Person.partiers.inject(0){|a,b| a + b.friends.count} / Person.partiers.count
  end
  
end
