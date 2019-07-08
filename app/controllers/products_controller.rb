class ProductsController < ApplicationController

  before_action :authenticate_user!
    
  def new
    @product = Product.new
  end

  def index
    @products = Product.all
  end

  def create
    if product["price"].to_f != 0.0
      product["price"] = product["price"].to_f
    end
    
    @product = Product.new product_params
    @product.user = current_user
    
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def show
    @product = Product.find(params["id"])
    @review = Review.new

    @reviews = @product.reviews.order(created_at: :desc)

  end

  def delete
    @product = Product.find(params["id"])
    @product.destroy
    redirect_to products_path
  end

  def edit
    @product = Product.find(params["id"])
  end

  def update
    product = product_params
    @product = Product.find(params["id"])

    if @product.update product
      redirect_to product_path(@product)
    else
      render :edit
    end
  end
  
  private

  def product_params
    params.require(:product).permit(:title, :description, :price)
  end

end
