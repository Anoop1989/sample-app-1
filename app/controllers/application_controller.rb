class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_service_provider!
    instance_id = request.headers['X-Product-Instance-ID'].to_s
    render_403 "Invalid service" and return if instance_id.blank? ||
    (@service_provider = ExternalServiceProvider.find_by(auth_id: instance_id)).nil?
  end

  protected
  ["404", "500", "403"].each do |error_code|
    define_method("render_#{error_code}") do |_msg|
      @errors = common_response_template.merge({
          error: {
            errors: {
              code: error_code,
              detail: _msg,
              title: error_code
            }
          }
      })
      render "errors/#{error_code}", format: :json
    end
  end

  def common_response_template
    {status: 0, success: true}
  end
end
