class TopController < ApplicationController
  def index
    @units=Unit.all
  end
end
