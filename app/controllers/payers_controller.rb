
class PayerNotFound < StandardError
  def message
    "payer not found"
  end
end

class PayersController < ApplicationController
  skip_before_action :verify_authenticity_token, if: :json_request?

  def create
    @payer = Payer.create(full_name: "payer#{Payer.count + 1}", address: "address_#{Payer.count + 1}")
  end

  def index
    @payers = Payer.all
  end

  def generate_bill
    begin
      Bill.create(payer: _payer)
    rescue PayerNotFound => err
      render_404 err.message and return
    rescue => err
      render_500 err.message and return
    end

    render json: {bill_status: 'generated' }, status: 200
  end

  private
  def json_request?
    request.format.json?
  end

  def bill_params
    params.permit(:id)
  end

  def _payer
    @payer = Payer.find(bill_params[:id]) rescue (raise PayerNotFound)
  end
end
