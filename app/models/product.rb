class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :ship_from
  belongs_to_active_hash :delivery_days
  belongs_to :category
  belongs_to :brand, optional: true
  has_many :comments

  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: true


  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
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


  validates :images, length: { minimum: 1, maximum: 10}

  scope :image, -> { includes(:images) }
  scope :buyer, -> { where(buyer_id: nil) }
  scope :lady, -> { where(category_id: 45..148) }
  scope :men, -> { where(category_id: 149..237) }
  scope :brand_test, -> { where(brand_id: 1) }
  scope :sorted, -> { order('created_at DESC').limit(3).to_a }
  scope :product, -> { image.buyer.sorted }
  scope :ladies, -> { image.lady.sorted }
  scope :mens, -> { image.men.sorted }
  scope :tests, -> { image.brand_test.sorted }
end
