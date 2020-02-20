class MypageController < ApplicationController


  def index
    @products = Product.mypage_sorted
  end

  def exhibited
    @products = Product.image.order('created_at DESC')
  end

  def card
  end

  def logout
  end

  
end
