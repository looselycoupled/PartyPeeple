class PartyController < ApplicationController
  
  before_filter :orientation_check, :except => [:orientation, :choose]
  
  def index
    if @person.preference == "both"
      @peeps = Person.where("id <> ?", @person.id)
    else
      @peeps = Person.where(:gender => @person.preference).where("id <> ?", @person.id)
      # @peeps = Person.all
    end
  end

  def orientation
  end
  
  def peep
    @peep = Person.find_by_identifier(params[:identifier])
  end

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

  def orientation_check
    if !@person.chosen_a_team?
      redirect_to :action => :orientation
    end
  end

end
