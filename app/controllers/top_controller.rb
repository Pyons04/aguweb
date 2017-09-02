class TopController < ApplicationController
  def index
    @units=Unit.all.page(params[:page]).per(10)
  end

  def show
    @units=Unit.all
    @units=@units.where('kamoku LIKE(?)',"%#{params[:keyword_kamoku]}%") if params[:keyword_kamoku].present?
    @units=@units.where('kyouin LIKE(?)',"%#{params[:keyword_kyouin]}%").page(params[:page]).per(5) if params[:keyword_kyouin].present?
      if params[:day].present?&&params[:jigen].present?
         @units=@units.where('jigen LIKE(?)',"%#{params[:day]}%").where('jigen LIKE(?)',"%#{params[:jigen]}%").page(params[:page]).per(5)
      else
         @units=@units.where('jigen LIKE(?)',"%#{params[:day]}%").page(params[:page]).per(5) if params[:day].present?
         @units=@units.where('jigen LIKE(?)',"%#{params[:jigen]}%").page(params[:page]).per(5) if params[:jigen].present?
      end
  end
end
