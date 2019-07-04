class ProductsController < ApplicationController

  def new
    @product = Product.new
  end

  def index
    @products = Product.all
  end

  def create
    product = product_params
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
