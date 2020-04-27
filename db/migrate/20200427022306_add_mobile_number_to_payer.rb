class AddMobileNumberToPayer < ActiveRecord::Migration[5.0]
  def change
    add_column :payers, :mobile_number, :string
  end
end
