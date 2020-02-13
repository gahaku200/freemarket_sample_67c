class AddColumnToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :buyer_id, :integer
    add_reference :products, :user, foreign_key: true

  end
end
