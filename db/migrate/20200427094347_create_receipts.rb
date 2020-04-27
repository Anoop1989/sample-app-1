class CreateReceipts < ActiveRecord::Migration[5.0]
  def change
    create_table :receipts do |t|
      t.float :amount_paid
      t.string :amount_paid_currency_code
      t.integer :bill_id
      t.string :platform_bill_id
      t.integer :external_service_provider_id
      t.string :service_provider_transaction_id
      t.jsonb :additional_info
      t.string :unique_payment_ref_id
      t.datetime :generated_at

      t.timestamps
    end
  end
end
