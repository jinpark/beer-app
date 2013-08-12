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
  
  def rate
    @user = current_user
    @beers = Beerinfo.order("brewery_name")
  end

  # def create_favbeer 
  #   params[:favbeer][:beer_ids].each do |beer_id_fav|
  #     @favbeer = Favbeer.new
  #     @favbeer.beer_id = beer_id_fav
  #     @favbeer.user_id = current_user.id
  #     @favbeer.save
  #   end
  # end

end
