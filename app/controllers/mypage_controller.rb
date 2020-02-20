class MypageController < ApplicationController


  def index
    @products = Product.product
  end

  def card
  end

  def logout
  end

  def product_show
  end

  
end
