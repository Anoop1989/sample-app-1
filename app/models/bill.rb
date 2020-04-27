class Bill < ApplicationRecord
  belongs_to :payer
  has_many :receipts

  def generate_receipt service_provider, payment_params
    payment_params = payment_params.with_indifferent_access
    params = {
      bill: self,
      external_service_provider: service_provider,
      platform_bill_id: payment_params['platformBillID'],
      amount_paid: payment_params['paymentDetails']['amountPaid']['value'],
      amount_paid_currency_code: 'INR',
      service_provider_transaction_id: payment_params['paymentDetails']['platformTransactionRefID'],
      additional_info: payment_params['paymentDetails']['additionalInfo'],
      unique_payment_ref_id: payment_params['paymentDetails']['uniquePaymentRefID'],
      generated_at: Time.now.utc
    }

    receipt = self.receipts.new(params)
    receipt.save
    receipt
  end
end
