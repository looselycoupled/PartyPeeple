class PartyController < ApplicationController
  
  before_filter :orientation_check, :except => [:orientation, :choose]
  before_filter :body_setup
  
  # display list of compatible peeps
  def index
    # TODO: veryify that params[:letter] is a letter
    if params[:letter].nil?
      @peeps = Person.where("id <> ? and gender is not null", @person.id).order(:updated_at)
    else
      @peeps = Person.where("first_name like ? and id <> ? and gender is not null", params[:letter] + "%",  @person.id)      
    end
  end

  # display form to choose orientation
  def orientation
    @body_id = "orientation"
  end
  
  # display a person's details
  def peep
    @peep = Person.find_by_identifier(params[:identifier])
    @recommendation = (Party::recommendation @person, @peep).titleize
    @friends_in_common = Party::friends_in_common(@person, @peep)
    @shared_books = @person.books & @peep.books
    @shared_tv_shows = @person.tv_shows & @peep.tv_shows
    @shared_movies = @person.movies & @peep.movies
    @shared_bands = @person.bands & @peep.bands
    
    @primary_matches = 0
    @primary_match_limit = 5
    
    
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
  
  def body_setup
    @body_class = "small"
  end
  
  # has the person chosen a preference?  if not forward to the orientation form
  def orientation_check
    if !@person.chosen_a_team?
      redirect_to :action => :orientation
    end
  end

end
