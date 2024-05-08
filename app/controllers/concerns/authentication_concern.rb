# Maybe rename this concern ; do you want this to be for Devise (Devisable) or for Pundit (Punditable) ? Or both
module AuthenticationConcern
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
  end

  # This method is given by devise ; you are overriding it here to work with Pundit
  def authenticate_user!
    raise Pundit::NotAuthorizedError, "You need to log in to access this page." unless user_signed_in?
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back fallback_location: root_url
  end
end
