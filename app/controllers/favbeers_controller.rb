class FavbeersController < ApplicationController

  def create
    @favbeer = Favbeer.new(params[:favbeers])
    @favbeer.user_id = current_user.id
    if @favbeer.save
      if request.xhr?
        # Render a partial as response when using ajax requests.
        render partial: "users/favorited_beer_info_and_buttons", locals: {favorited_beer: @favbeer, saved_beer_beer_ids: current_user.savedbeers.pluck("beer_id")}
      else
        # Redirect as usual for plain html requests.
        flash[:notice] = "You favorited #{find_beer_info(@favbeer.beer_id)[1]}!"
        redirect_to root_url
      end
    else
      if request.xhr?
        render partial: "shared/error"
      else
        flash[:alert] = "Failed to favorite"
        redirect_to root_url
      end
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
