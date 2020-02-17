class RenameUserIdColumnToProducts < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :user_id, :seller_id
  end
end
