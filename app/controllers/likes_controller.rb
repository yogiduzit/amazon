class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    like = create_like

    if !can?(:like, like) 
      flash[:error] = "Liking your own message"
      return redirect_to product_path(like.review.product)
    end

    if like.save
      redirect_to product_path(like.review.product)
    else
      redirect_to product_path(like,review.product), alert: like.errors.full_messages.join(", ")
    end
  end

  def destroy
    like = Like.find_by(id: params["id"])
    if like.destroy
      redirect_to product_path(like.review.product)
    else
      redirect_to product_path(like.review.product), alert: like.errors.full_messages.join(", ")
    end
  end

  private
  def create_like
    like = Like.new(user_id: current_user.id, review_id: params[:review_id])
    return like
  end
end
