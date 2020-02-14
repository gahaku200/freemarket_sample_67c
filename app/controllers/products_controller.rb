class ProductsController < ApplicationController

  require 'payjp'

  before_action :move_to_index, except: [:index, :select_registrations, :show]

  def index
    @images =Image.all
    @products = Product.product
    @products_ladies = Product.ladies
    @products_mens = Product.mens
    @products_test = Product.tests
  end

  def select_registrations
  end

  def new
    @parents = Category.all.order("id ASC").limit(13)
    @product = Product.new
    @product.images.new
  end

   # Ajax通信で送られてきたデータをparamsで受け取り､childrenで子を取得
  def category_children
    @category_children = Category.find(params[:productcategory]).children 
  end

  def category_grandchildren
    @category_grandchildren = Category.find(params[:productcategory]).children
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @product_images = @product.images.limit(3)
  end

  def pay
    if @card.blank?
      redirect_to controller: "cards", action: "new"
      flash[:alert] = '購入にはクレジットカード登録が必要です'
    else
     # 購入した際の情報を元に引っ張ってくる
     @product = Product.find(params[:product_id])
     card = Card.where(user_id: current_user.id).first
     # テーブル紐付けてるのでログインユーザーのクレジットカードを引っ張ってくる
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      Payjp::Charge.create(
      amount: @product.price, #支払金額
      customer: card.customer_id, #顧客ID
      currency: 'jpy', #日本円
      )
     # ↑商品の金額をamountへ、cardの顧客idをcustomerへ、currencyをjpyへ入れる
      if @product.update(buyer_id: current_user.id)
        flash[:notice] = '購入しました。' 
        redirect_to controller: "cards", action: 'completed'
      else
        flash[:alert] = '購入に失敗しました。'
        redirect_to action: 'buy'
      end
    end
  end

  def done
    @product = Product.find(params[:product_id])
  end

  def buy
    @product = Product.find(params[:product_id])
    @user = User.find(current_user.id)
    @address = Address.find_by(user_id: current_user.id)
    @product_images = @product.images.limit(3)
    @card = Card.find_by(user_id: current_user.id)
    redirect_to root_path if @product.buyer != nil || @product.seller_id == current_user.id
    if @card.present?
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    customer = Payjp::Customer.retrieve(@card.customer_id)
    @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :status_id,  :delivery_charge_id, :ship_from_id, :delivery_days_id, :price,  :category_id,:brand_id,  images_attributes: [:image, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  
end