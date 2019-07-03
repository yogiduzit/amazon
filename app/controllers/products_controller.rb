class ProductsController < ApplicationController

  def new
    @product = Product.new
  end

  def index

    @products = Product.all
  end

  def create
    product = params.require(:product).permit(:title, :description, :price)
    if product["price"].to_f != 0.0
      product["price"] = product["price"].to_f
    end
    
    @product = Product.new product

    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def show
    @product = Product.find(params["id"])
  end

end
