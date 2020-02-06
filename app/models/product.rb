class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :ship_from
  belongs_to_active_hash :delivery_days

  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: true
end
