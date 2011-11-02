class PartyController < ApplicationController
  
  before_filter :orientation_check, :except => [:orientation, :choose]
  
  def index
  end

  def orientation
  end
  
  def peep
  end

  def choose
    # sanitize choice
    redirect_to :action => :orientation unless ["male","female","both"].include? params[:choice] 
    
    @person.preference = params[:choice]
    @person.save
    
    redirect_to :action => :index
    
  end

  
  private

  def orientation_check
    if !@person.chosen_a_team?
      redirect_to :action => :orientation
    end
  end

end
