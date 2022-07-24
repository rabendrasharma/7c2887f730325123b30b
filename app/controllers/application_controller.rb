class ApplicationController < ActionController::Base
  def error(message)
    render json: {error: message}
  end
end
