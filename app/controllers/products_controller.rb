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
    begin
      @product = Product.find(params[:id])
      @product_images = @product.images.limit(3)
    rescue
      redirect_to root_path, alert:'商品詳細ページの表示に失敗しました。'
    end
  end

  def destroy
    begin
      @product = Product.find(params[:id])
      @product.destroy
      redirect_to mypage_path, notice:'出品情報を削除しました。'  
    rescue
      redirect_to root_path, alert:'出品情報の削除に失敗しました。'
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