class ApplicationController < ActionController::Base
  protect_from_forgery

before_filter :print_secret

def print_secret
  logger.debug ENV['RUBY_SU_FACEBOOK_APP_SECRET']
end

end
