class CreateExternalServiceProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :external_service_providers do |t|
      t.string :name,             null: false
      t.string :auth_id
      t.string :auth_secret
      t.string :status
      t.datetime :activated_at

      t.timestamps
    end
  end
end
