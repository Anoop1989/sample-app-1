
class PayerNotFound < StandardError
  def message
    "payer not found"
  end
end

class PayersController < ApplicationController
  skip_before_action :verify_authenticity_token, if: :json_request?
  before_action :authenticate_service_provider!

  def create
    @payer = Payer.create(full_name: "payer#{Payer.count + 1}", address: "address_#{Payer.count + 1}", mobile_number: rand(9000000000..9999999999))
  end

  def index
    @payers = Payer.all
  end

  def generate_bill
    begin
      @bill = Bill.create(payer: _payer, bill_amount: rand(500), bill_status: 'pending', bill_date:  Time.now.utc)
    rescue PayerNotFound => err
      render_404 err.message and return
    rescue => err
      render_500 err.message and return
    end

    render json: {bill_status: 'generated', id: @bill.id, amount: @bill.bill_amount }, status: 200
  end

  private

  def bill_params
    params.permit(:id)
  end

  def _payer
    @payer = Payer.find(bill_params[:id]) rescue (raise PayerNotFound)
  end
end
