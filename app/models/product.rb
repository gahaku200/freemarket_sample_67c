class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :ship_from
  belongs_to_active_hash :delivery_days

  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: true


  validates :name, presence: true
  validates :description, presence: true
  validates :status_id, presence: true
  validates :delivery_charge_id, presence: true
  validates :ship_from_id, presence: true
  validates :delivery_days_id, presence: true
  validates :price, presence: true,
                    numericality: {
                      greater_than_or_equal_to: 300,
                      less_than_or_equal_to: 9999999}
                      
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
end
