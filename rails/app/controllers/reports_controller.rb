class ReportsController < ApplicationController

  def index
    redirect_to :action => [:gender].sample
  end

  def gender
    @males = Person.males.count
    @females = Person.females.count    
  end
  
end
