module Jsonable
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def json_not_found(type, input)
    json_response({ errors: "Could not find merchant with a name matching #{input}." }, :not_found)
    json_response({ errors: "Could not find merchant with an id matching #{input}." }, :not_found)
  end

  def json_missing_input
    json_response({ errors: "Please enter a valid search parameter and try again." }, :bad_request)
  end
end