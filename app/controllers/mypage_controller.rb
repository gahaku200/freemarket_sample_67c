class MypageController < ApplicationController


  def index
    @products = Product.mypage_sorted
  end

  def card
  end

  def logout
  end

  def product_show
  end

  
end
