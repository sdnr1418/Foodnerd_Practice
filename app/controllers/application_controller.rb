class ApplicationController < ActionController::Base
  # Protect against CSRF if handling traditional browser sessions
  protect_from_forgery with: :exception

  private

  # 1. Mock current_user helper for testing roles locally
  def current_user
    # Define a simple structural blueprint on the fly
    user_blueprint = Struct.new(:role, :name)
    user_blueprint.new('cashier', 'Saad Nasir')
  end

  # 2. Before-action filter to restrict access
  def authorize_manager!
    unless current_user && current_user.role == 'manager'
      render json: { 
        error: "Not Authorized", 
        message: "You do not have manager privileges to access this resource." 
      }, status: :forbidden # Status 403
      
      # Calling 'render' inside a before_action automatically halts the request cycle
    end
  end
end