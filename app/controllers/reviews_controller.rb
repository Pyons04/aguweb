class ReviewsController < ApplicationController

  def show
    @reviews=Unit.find(params[:id]).reviews
  end

  def create
  end

  def destroy
  end

end
