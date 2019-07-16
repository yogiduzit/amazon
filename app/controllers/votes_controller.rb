class VotesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    vote = create_vote
    if vote.save
      redirect_to product_path(vote.review.product)
    else
      render 'products/show'
    end
  end

  def update
    type = params["type"]
    vote = Vote.find_by(id: params[:id])

    if vote.vote_type != type
      vote.update(vote_type: type)
      redirect_to product_path(vote.review.product)
    else
      redirect_to product_path(vote.review.product)
    end
  end

  private
  def create_vote
    vote = Vote.new(vote_type: params[:type], review_id: params[:review_id], user: current_user)
  end
end
