class Create < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.integer :contact_id
      t.string  :phone_type
      t.string  :phone_number
    end
  end
end
