class FavbeersController < ApplicationController

  def create
    @favbeer = Favbeer.new(params[:favbeer])
    if @favbeer.save
      flash[:notice] = "You favorited a beer!"
      redirect_to "root"
    else
      flash[:notice] = "Failed to favorite your beer"
    end
  end
end
