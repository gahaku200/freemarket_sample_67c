class Address < ApplicationRecord
  belongs_to :user, optional: true
  validates :address_first_name, :address_last_name, :address_first_name_kana, :address_last_name_kana,
            :zipcode, :address ,presence: true
end