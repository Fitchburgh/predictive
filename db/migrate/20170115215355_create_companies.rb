class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :company_number
      t.string :company_type
      t.string :incorporation_date
      t.string :registered_address_in_full
      t.string :current_status
      t.string :jurisdiction_code
      t.boolean :favorited, default: false
      t.string :notes

      t.timestamps
    end
  end
end
