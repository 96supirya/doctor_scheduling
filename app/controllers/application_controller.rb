class ApplicationController < ActionController::API

  def render_success_response(resources = {}, message = "", status = 200)
    json_response({ success: true, message: message, data: resources}, status)
  end

  def render_failure_response(message = '', status = 200)
    json_response({ success: false, errors: message }, status)
  end

  def single_serializer
    ActiveModelSerializers::SerializableResource
  end

  def json_response(data, status = 200)
    render json: data, status: status
  end

end

