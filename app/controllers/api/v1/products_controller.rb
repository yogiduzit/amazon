# File created using rails g controller api/v1/products --no-assets --no-helper
class Api::V1::ProductsController < Api::ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_product, only: [:show, :destroy, :update, :edit]
  
  def index
    products = Product.order(created_at: :desc)
    render(json: products, each_serializer: ProductSerializer)
  end

  def show
    
  end

  def create
    @product = Product.new product_params
    @product.user = current_user

    if @product.save
      render(json: {id: @product.id}, status: 200)
    else
      render(json: {status: 401}, status: 401)
    end 
  end

  def update
    if @product.update(product_params)
      render(json: {id: @product.id}, status: 200)
    else
      render(json: {status: 400}, status: 400)
    end
  end

  private 
  def product_params
    params.require(:product).permit(:title, :description, :price, {tag_ids: []})
  end
  def find_product
    @product = Product.find(params[:id])
  end
end
