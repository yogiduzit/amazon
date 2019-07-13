class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @fav_products = current_user.favourite_products
  end

  def create
    fav = create_fav
    if fav.save
      redirect_to product_path(fav.product)
    else
      redirect_to product_path(fav.sproduct), alert: fav.errors.full_messages.join(', ')
    end
  end

  def destroy
    fav = Favourite.find_by(id: params["id"])

    if fav.destroy
      redirect_to product_path(fav.product)
    else
      redirect_to product_path(fav.product), alert: fav.errors.full_messages.join(', ')
    end
  end

  private
  def create_fav
    fav = Favourite.new(user_id: current_user.id, product_id: params["product_id"])
    return fav
  end
end
