class ReviewsController < ApplicationController

  def show
    @reviews=Unit.find(params[:id]).reviews
  end

  def create
    Review.create(content:params[:content],test:params[:test],user_id:current_user.id)
    redirect_to controller: 'reviews', action: 'show'
  end

  def destroy
  end

end
