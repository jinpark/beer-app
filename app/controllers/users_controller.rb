class UsersController < ApplicationController

  before_filter :authenticate_user!

  def index
    @user = current_user
    @saved_beers = current_user.savedbeers
    @favorited_beers = current_user.favbeers
    @all_rec_beers = []
    # current_user.favbeers.each do |beer|
    #   recs = find_recommendations(beer.beer_id)
    #   start_beer = find_beer_info(recs[0])
    #   rec_beers = find_beer_info_array(recs[1])
    #   @all_rec_beers << [start_beer, rec_beers]
    # end
    @allbeers = Beerinfo.order("brewery_name")
    if params[:beer_name]
      beer_name = params[:beer_name]
      location = current_user.location
      @bars = find_bars_with_beer_name(beer_name, location)
      p "LOOK HERE FOR BARS"
      p @bars
    else
      @bars =[]
    end
    @beerstyles_hash = Hash.new(0)
    @beerabvs_hash = Hash.new(0)
    @favorited_beers.each do |favbeer|
      @beerstyles_hash[favbeer.beerinfo.beer_style] += 1
      case
        when  favbeer.beerinfo.beer_abv.between?(0,3)
          @beerabvs_hash["0% - 3%"] += 1
        when  favbeer.beerinfo.beer_abv.between?(3.1,4)
          @beerabvs_hash["3% - 4%"] += 1
        when  favbeer.beerinfo.beer_abv.between?(4.1,5)
          @beerabvs_hash["4% - 5%"] += 1
        when  favbeer.beerinfo.beer_abv.between?(5.1,6)
          @beerabvs_hash["5% - 6%"] += 1
        when  favbeer.beerinfo.beer_abv.between?(6.1,9)
          @beerabvs_hash["6% - 9%"] += 1
        when  favbeer.beerinfo.beer_abv > 9
          @beerabvs_hash["9%+"] += 1
      end
    end
    @beerabvs_hash = @beerabvs_hash.sort
  end

  def rate
    @user = current_user
    @beers = Beerinfo.order("brewery_name")
    
  end

  # def createfavbeer 
  #   @user.build

  # end




end