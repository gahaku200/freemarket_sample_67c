class BuysController < ApplicationController
  require 'payjp'        #Payjpの読み込み
  before_action :set_card, :set_product

  def index
    @address = Address.find_by(user_id: current_user.id)
    @product_images = @product.images.limit(3)
    redirect_to root_path if @product.buyer != nil || @product.seller_id == current_user.id
    if @card.present?
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def pay
    if @product.buyer_id.present?
    redirect_to root_path, notice: "申し訳ありません。先ほど商品が売り切れたようです・・・。" 
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      Payjp::Charge.create(
        amount: @product.price,          #支払金額を引っ張ってくる
        customer: @card.customer_id,  #顧客ID
        currency: 'jpy',              #日本円
      )
      if @product.update(buyer_id: current_user.id)
        redirect_to action: 'done'
      else
        flash.now[:alert] = '購入に失敗しました。'
        render :buy
      end
    end
  end


  def done
  end

  private

  def set_card
    @card = Card.where(user_id: current_user).first
  end
  def set_product
    @product = Product.find(params[:product_id])
  end
end
