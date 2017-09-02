class TopController < ApplicationController
  def index
    @units=Unit.all.limit(100).page(params[:page]).per(10)
  end

  def show
    @units=Unit.all
    @units=@units.where('kamoku LIKE(?)',"%#{params[:keyword_kamoku]}%").limit(100).page(params[:page]).per(5) if params[:keyword_kamoku].present?
    @units=@units.where('kyouin LIKE(?)',"%#{params[:keyword_kyouin]}%").limit(100).page(params[:page]).per(5) if params[:keyword_kyouin].present?

      if params[:day].present?&&params[:jigen].present?
         @units=@units.where('jigen LIKE(?)',"%#{params[:day]}%").where('jigen LIKE(?)',"%#{params[:jigen]}%").limit(100).page(params[:page]).per(5)
      elsif params[:day].present?
         @units=@units.where('jigen LIKE(?)',"%#{params[:day]}%").limit(100).page(params[:page]).per(5)
      elsif params[:jigen].present?
         @units=@units.where('jigen LIKE(?)',"%#{params[:jigen]}%").limit(100).page(params[:page]).per(5)
        else
          @units=Unit.all.limit(100).page(params[:page]).per(5)
      end
  end
end
