class MypageController < ApplicationController



  def index
    @products = Product.where(seller_id: current_user.id).mypage_sorted
  end

  def exhibited
    @products = Product.where(seller_id: current_user.id).new_arrival
    
  end

  def purchase
    @products = Product.where(buyer_id: current_user.id).new_arrival
  end

  def card
  end

  def logout
  end
  
end
