class UsersController < ApplicationController

  before_filter :authenticate_user!

  def index
    # current_user.favbeers.each do |beer|
    #   recs = find_recommendations(beer.beer_id)
    #   start_beer = find_beer_info(recs[0])
    #   rec_beers = find_beer_info_array(recs[1])
    #   @all_rec_beers << [start_beer, rec_beers]
    # end
    @allbeers = Beerinfo.order("brewery_name")
    # if params[:beer_name]
    #   beer_name = params[:beer_name]
    #   location = current_user.location
    #   @bars = find_bars_with_beer_name(beer_name, location)
    # else
    #   @bars =[]
    # end
    @beerstyles_hash = Hash.new(0)
    @beerabvs_hash = Hash.new(0)
    current_user.favbeers.each do |favbeer|
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
    @saved_beer_beer_ids = @saved_beers.pluck("beer_id")
    @fav_beer_beer_ids = @favorited_beers.pluck("beer_id")
  end


  def create_favbeer 
    params[:favbeers][:beer_ids].each do |beer_id_fav|
      @favbeer = Favbeer.new
      @favbeer.beer_id = beer_id_fav
      @favbeer.user_id = current_user.id
      @favbeer.save
    end
    redirect_to root_url
  end

  def show
    @user = User.find(params[:id])
    @favorited_beers = @user.favbeers
    @allbeers = Beerinfo.order("brewery_name")
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
    @yourfavbeer = Favbeer.find_all_by_user_id(current_user.id)
    if !@yourfavbeer.empty? && !@favorited_beers.empty?
      @commonality =  @yourfavbeer.pluck(:beer_id) & @favorited_beers.pluck(:beer_id)
    else
      @commonality = []
    end
    @friend =  Friendship.find_all_by_user_id_and_friend_id(current_user.id, params[:id])
    if @friend.empty?
      @friend = false
    end
    @saved_beer_beer_ids = current_user.savedbeers.pluck("beer_id")
    @fav_beer_beer_ids = current_user.favbeers.pluck("beer_id")
  end

  def map
    if request.xhr?
      # Render a partial as response when using ajax requests.
      render partial: "map", locals: {user_location: current_user.location, ruby_bars: find_bars_with_beer_name(params[:beer_name], current_user.location), beer_id: params[:beer_id]}
    else
      # Redirect as usual for plain html requests.
      redirect_to root_url
    end
  end

  def stats
    @beerstyles_hash = Hash.new(0)
    @beerabvs_hash = Hash.new(0)
    @favorited_beers = current_user.favbeers
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

    if request.xhr?
      render partial: 'beer_stats', locals: {beerstyles_hash: @beerstyles_hash, beerabvs_hash: @beerabvs_hash} 
    else
      redirect_to root_url
    end
  end

end