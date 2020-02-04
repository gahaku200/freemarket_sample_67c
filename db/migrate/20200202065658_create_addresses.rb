class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :address_first_name, null: false
      t.string :address_last_name, null: false
      t.string :address_first_name_kana, null: false
      t.string :address_last_name_kana, null: false

      t.string :zipcode, null: false
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :municipality, null: false
      t.string :address, null: false
      t.string :building_name
      t.integer :phone_num

      t.references :user
      t.timestamps
    end
  end
end