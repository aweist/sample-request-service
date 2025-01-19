class CreateSampleRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :sample_requests do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email_address, null: false
      t.string :street_address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :postal_code, null: false
      t.string :org
      t.string :org_name
      t.integer :org_size
      t.datetime :approved_at
      t.integer :approved_by

      t.timestamps
    end
  end
end
