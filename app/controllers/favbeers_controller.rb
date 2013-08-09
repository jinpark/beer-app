class FavbeersController < ApplicationController

  def create
    @favbeer = Favbeer.new(params[:favbeers])
    @favbeer.user_id = current_user.id
    if @favbeer.save
      flash[:notice] = "You favorited #{find_beer_info(@favbeer.beer_id)[1]}!"
      redirect_to root_url
    else
      flash[:alert] = "Failed to favorite your beer"
      redirect_to root_url
    end
  end

  def destroy
    @favbeer = Favbeer.find(params[:id])
    if @favbeer.destroy
      flash[:notice] = "You unfavorited #{find_beer_info(@favbeer.beer_id)[1]}"
      redirect_to root_url
    else
      flash[:alert] = "Failed to unfavorite your beer"
      redirect_to root_url
    end
  end
  
end
