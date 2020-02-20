class MypageController < ApplicationController


  def index
    @products = Product.mypage_sorted
  end

  def show
    @products = Product.search(params[:search]).limit(132)
  end

  def card
  end

  def logout
  end

  
end
