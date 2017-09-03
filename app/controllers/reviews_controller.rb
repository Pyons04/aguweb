class ReviewsController < ApplicationController

  def show
    @reviews=Unit.find(params[:id]).reviews
    @unit=Unit.find(params[:id])
    @back_url=params[:back_url] if params[:back_url].present?
  end

  def create
    Review.create(content:params[:content],satisfaction:params[:satisfaction],test:params[:test],gpa:params[:gpa],user_id:current_user.id,unit_id:params[:unit_id])
    redirect_to controller: 'reviews', action: 'show', id: params[:unit_id],back_url:params[:back_url]
  end

  def destroy
    review=Review.find(params[:id])
    redirect_to controller: 'reviews', action: 'show', id: Review.find(params[:id]).unit.id
    review.destroy
  end

end
