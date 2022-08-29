class ApplicationController < ActionController::API
  include Serializable
  include Jsonable
  
  rescue_from ActiveRecord::RecordNotFound do |e|
    json_response({ message: e.message }, :not_found)
  end
end
