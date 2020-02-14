class BuysController < ApplicationController
  require 'payjp'        #Payjpの読み込み
  before_action :set_card, :set_product

  def index
    @user = User.find(current_user.id)
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
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    Payjp::Charge.create(
      :amount => @product.price,          #支払金額を引っ張ってくる
      :customer => @card.customer_id,  #顧客ID
      :currency => 'jpy',              #日本円
    )
    if @product.update(buyer_id: current_user.id)
      redirect_to action: 'done', notice: "購入しました。"
    else
      redirect_to action: 'buy', notice: "購入に失敗しました。"
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
