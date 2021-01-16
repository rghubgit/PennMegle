class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :config_opentok
  helper_method :get_opentok

  # initialize OpenTok API
  def config_opentok
    tries = 5
    begin
      @opentok = OpenTok::OpenTok.new Rails.application.credentials.vonage[:api_key], Rails.application.credentials.vonage[:secret]
      
      logger.debug "opentok connected."
     rescue Errno::ETIMEDOUT => e
      log.error e 
      tries -= 1
        if tries > 0
          logger.debug "retrying opentok.new..."
        retry 
        else
          logger.debug "opentok.new timed out..."
          puts "ERROR: #{e.message}" 
        end
    end
  end

  # getter: returns OpenTok object
  def get_opentok
    @opentok
  end

  protected

  # Allows Devise to permit other inputs for the User model
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :username])
  end
end
