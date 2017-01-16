class CreateOfficers < ActiveRecord::Migration[5.0]
  def change
    create_table :officers do |t|
      t.references :company, foreign_key: true
      t.string :name
      t.string :position
      t.integer :officer_id
      t.string :start_date
      t.string :end_date
      t.boolean :favorited, default: false
      t.string :notes

      t.timestamps
    end
  end
end
