class CreateBills < ActiveRecord::Migration[5.0]
  def change
    create_table :bills do |t|
      t.integer :payer_id, null: false
      t.date :bill_date
      t.float :bill_amount
      t.string :bill_status
      t.float :payment_amount
      t.date :payment_date

      t.timestamps
    end
  end
end
