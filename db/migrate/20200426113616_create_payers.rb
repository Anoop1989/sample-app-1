class CreatePayers < ActiveRecord::Migration[5.0]
  def change
    create_table :payers do |t|
      t.string :full_name, null: false
      t.text :address, null: false

      t.timestamps
    end
  end
end
