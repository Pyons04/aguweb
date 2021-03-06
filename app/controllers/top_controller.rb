class TopController < ApplicationController
  def index
    @reviews=Review.order(created_at: :desc).limit(4)
    @units=Unit.all.limit(100).page(params[:page]).per(10)
  end

  def show
 params[:day]="" if params[:day]=="指定しない"
 params[:jigen]="" if params[:jigen]=="指定しない"
 params[:kaikou]="" if params[:kaikou]=="学部を指定しない"


    @units=Unit.all
    @units=@units.where('kaikou LIKE(?)',"%#{params[:kaikou]}%").page(params[:page]).per(5) if params[:kaikou].present?
    @units=@units.where('kamoku LIKE(?)',"%#{params[:keyword_kamoku]}%").page(params[:page]).per(5) if params[:keyword_kamoku].present?
    @units=@units.where('kyouin LIKE(?)',"%#{params[:keyword_kyouin]}%").page(params[:page]).per(5) if params[:keyword_kyouin].present?

      if params[:day].present?&&params[:jigen].present?
         @units=@units.where('jigen LIKE(?)',"%#{params[:day]}%").where('jigen LIKE(?)',"%#{params[:jigen]}%").page(params[:page]).per(5)
      elsif params[:day].present?
         @units=@units.where('jigen LIKE(?)',"%#{params[:day]}%").page(params[:page]).per(5)
      elsif params[:jigen].present?
         @units=@units.where('jigen LIKE(?)',"%#{params[:jigen]}%").page(params[:page]).per(5)
      else
           @units=@units.page(params[:page]).per(5)
      end
  end
end
