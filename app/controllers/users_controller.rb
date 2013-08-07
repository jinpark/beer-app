class UsersController < ApplicationController

  before_filter :authenticate_user!

  def index
    @user = current_user
    @saved_beers = current_user.savedbeers
    @all_rec_beers = []
    current_user.savedbeers.each do |beer|
      recs = find_recommendations(beer.beer_id)
      start_beer = find_beer_info(recs[0])
      rec_beers = find_beer_info_array(recs[1])
      @all_rec_beers << [start_beer, rec_beers]
    end
  end

  def rate
    @user = current_user
    @beers = Beerinfo.order("brewery_name")
    
  end

  # def createfavbeer 
  #   @user.build

  # end




end