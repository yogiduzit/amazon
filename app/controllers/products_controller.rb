class ProductsController < ApplicationController

  before_action :authenticate_user!, except: [:show, :index]
  before_action :authorize!, only: [:update, :edit, :delete]
    
  def new
    @product = Product.new
  end

  def index
    @products = Product.all
  end

  def create
    
    
    @product = Product.new product_params
    @product.user = current_user

    if @product["price"].to_f != 0.0
      @product["price"] = @product["price"].to_f
    end

    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def show
    @product = Product.find(params["id"])
    @review = Review.new
    @tags = @product.tags

    if can?(:crud, @product)
      @reviews = @product.reviews.order(created_at: :desc)
    else
      @reviews = @product.reviews.where(hidden: false)
    end
    

  end

  def delete
    @product = Product.find(params["id"])
    @product.destroy
    redirect_to products_path
  end

  def edit
    @product = Product.find(params["id"])
    render :new
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
  
  def authorize!
    @product = Product.find(params["id"])
    redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @product)
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, {tag_ids: []})
  end

end
