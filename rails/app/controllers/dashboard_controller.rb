class DashboardController < ApplicationController
  layout "dashboard"
  
  before_filter :require_security
  
  def index
  end
  
  private
  
  def require_security
    if !authenticated?
      logger.warn "WARN: Invalid attempt to access dashboard"
      raise ActionController::RoutingError.new('Not Found')
    end
  end
  
end
