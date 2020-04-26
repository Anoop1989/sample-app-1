class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

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
