class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :address_first_name, null: false
      t.string :address_last_name, null: false
      t.string :address_first_name_kana, null: false
      t.string :address_last_name_kana, null: false

      t.integer :zipcode
      t.text :address
      t.references :user
      t.timestamps
    end
  end
end