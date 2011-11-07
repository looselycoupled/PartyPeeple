class PartyController < ApplicationController
  
  before_filter :orientation_check, :except => [:orientation, :choose]
  
  # display list of compatible peeps
  def index
    @peeps = Person.where("id <> ? and gender is not null", @person.id)
  end

  # display form to choose orientation
  def orientation
  end
  
  # display a person's details
  def peep
    @peep = Person.find_by_identifier(params[:identifier])
  end

  # save orientation/preference choice
  def choose
    # sanitize choice
    redirect_to :action => :orientation unless ["male","female","both"].include? params[:choice] 
    
    # save choice and send to the party
    @person.preference = params[:choice]
    @person.save
    redirect_to :action => :index
  end

  def about
  end

  def help
  end


  
  private
  
  # has the person chosen a preference?  if not forward to the orientation form
  def orientation_check
    if !@person.chosen_a_team?
      redirect_to :action => :orientation
    end
  end

end
