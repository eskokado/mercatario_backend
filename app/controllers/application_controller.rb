class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  allow_browser versions: :modern
end
