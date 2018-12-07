class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception

  private
  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      logger.debug(ENV["BASIC_AUTH_USER"])
      logger.debug(ENV["BASIC_AUTH_PASSWORD"])
      logger.fatal(ENV["BASIC_AUTH_PASSWORD"])
      logger(username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"])
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
