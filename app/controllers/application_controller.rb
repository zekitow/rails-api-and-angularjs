class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
 protect_from_forgery with: :null_session

  def record_not_found
    render nothing: true, status: 404
  end
end
