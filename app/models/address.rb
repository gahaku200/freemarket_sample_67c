class Address < ApplicationRecord
  belongs_to :user, optional: true
  validates :address_first_name, format:{ with:/\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/ }, presence: true
  validates :address_last_name, format:{  with:/\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/ }, presence: true
  validates :address_first_name_kana, format:{ with:/\A[ぁ-んー－]+\z/ }, presence: true
  validates :address_last_name_kana, format:{ with:/\A[ぁ-んー－]+\z/ }, presence: true
  validates :zipcode, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :municipality, presence: true
  validates :address, presence: true
end