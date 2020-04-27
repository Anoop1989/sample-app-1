class InvalidServiceProviderError < StandardError
  def message
    "Invalid Service Provider"
  end
end

class InvalidPayloadError < StandardError
  def message
    "Invalid payload"
  end
end

class BillNotFoundError < StandardError
  def message
    "Invalid bill"
  end
end

class BillsController < ApplicationController
  skip_before_action :verify_authenticity_token, if: :json_request?

  def fetch
    begin
      valid_service?
      payer
    rescue InvalidServiceProviderError, InvalidPayloadError => err
      render_401 err.message and return
    rescue => err
      render_500 err.message and return
    end
  end

  def fetch_receipt
    begin
      valid_service?
      @receipt = payer_bill.generate_receipt service_provider, auth_token
    rescue BillNotFoundError, InvalidServiceProviderError, InvalidPayloadError => err
      render_401 err.message and return
    rescue => err
      render_401 err.message and return
    end
  end

  private
  def payer
    raise InvalidPayloadError if auth_token.nil?
    customer_atribs = auth_token[:customerIdentifiers].inject({}) do |hash, r|
      hash[r[:attributeName].underscore] = r[:attributeValue]
      hash
    end
    customer_atribs.reject!{|k,v| !k.to_s.in? Payer::FETCH_ATTRIBUTES}
    @payer = Payer.find_by(customer_atribs)
  end

  def service_provider
    @service_provider ||= ExternalServiceProvider.find_by(auth_id: request.headers['X-Product-Instance-ID'])
  end

  def http_token
    @http_token ||= if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ').last
    end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token, service_provider&.auth_secret)
  end

  def valid_service?
    raise InvalidServiceProviderError if service_provider.nil?
  end

  def payer_bill
    begin
      bill ||= Bill.find(auth_token['billerBillID'])
    rescue => err
      raise BillNotFoundError
    end
  end
end
