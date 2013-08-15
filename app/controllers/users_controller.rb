class UsersController < ApplicationController

  before_filter :authenticate_user!

  def index
    @allbeers = Beerinfo.order("brewery_name")
    @beerstyles_hash = Favbeer.beerstyles_hash(current_user)
    @beerabvs_array = Favbeer.beerabvs_array(current_user)
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
    @allbeers = Beerinfo.order("brewery_name")
    @beerstyles_hash = Favbeer.beerstyles_hash(@user)
    @beerabvs_array = Favbeer.beerabvs_array(@user)
    @commonality = Favbeer.commonality(current_user, @user)
    @friend =  Friendship.scoped_by_user_id_and_friend_id(current_user.id, params[:id])
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
    @beerstyles_hash = Favbeer.beerstyles_hash(current_user)
    @beerabvs_array = Favbeer.beerabvs_array(current_user)
    if request.xhr?
      render partial: 'beer_stats', locals: {beerstyles_hash: @beerstyles_hash, beerabvs_array: @beerabvs_array} 
    else
      redirect_to root_url
    end
  end

end