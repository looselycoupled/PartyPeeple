class DashboardController < ApplicationController
  layout "dashboard"
  
  before_filter :require_security
  
  def index
    # @people = Person.all
    @people = Person.where("identifier in ('737428913')") if Rails.env.development?
    @people.each do |u|
      UserMailer.user_data_confirmation(u).delay.deliver
    end
    
    
  end
  
  def reset
    Party::cleanup
    logger.info "INFO: Application data reset"
    session[:identifier] = nil
    cookies.delete "fbsr_#{FB_CONFIG[:app_id]}"
    redirect_to root_url, :notice => "App has been reset!"
  end
  
  private
  
  def require_security
    if !authenticated? || !administrator?
      logger.warn "WARN: Invalid attempt to access dashboard"
      raise ActionController::RoutingError.new('Not Found')
    end
  end
  
end
