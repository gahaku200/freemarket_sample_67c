class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence:true
  validates :first_name, format:{ with:/\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/ }, presence:true
  validates :last_name, format:{ with:/\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/ }, presence:true
  validates :first_name_kana, format:{ with:/\A[ぁ-んー－]+\z/ }, presence:true
  validates :last_name_kana, format:{ with:/\A[ぁ-んー－]+\z/ }, presence:true
  validates :birthday_year, presence:true
  validates :birthday_month, presence:true
  validates :birthday_day, presence:true
  validates :email, format:{ with:/[\w.\-]+@[\w\-]+\.[\w.\-]+/ }, presence:true

  has_one :address
  
end