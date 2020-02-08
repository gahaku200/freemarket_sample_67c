class ProductsController < ApplicationController

  # before_action :move_to_index, except: [:index]

  def index
  end

  def select_registrations
  end

  def test_create
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path, notice: "出品が完了しました"
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :status_id,  :delivery_charge_id, :ship_from_id, :delivery_days_id, :price, :category_id).merge(seller_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end