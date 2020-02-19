class Products::SearchesController < ApplicationController

  def index
    @products = Product.search(params[:search]).limit(132)
    @search = params[:search]
  end

end
