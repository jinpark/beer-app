class SavedbeersController < ApplicationController

  def create
    p "SAVED BEERS"
    p params[:savedbeers]
    @savedbeer = Savedbeer.new(params[:savedbeers])
    @savedbeer.user_id = current_user.id
    p "LOOK HERE"
    p @savedbeer
    if @savedbeer.save
      flash[:notice] = "You saved #{find_beer_info(@savedbeer.beer_id)[1]}!"
      redirect_to root_url
    else
      flash[:alert] = "Failed to save"
      redirect_to root_url
    end
  end

  def destroy
    @savedbeer = Savedbeer.find(params[:id])
    if @savedbeer.destroy
      flash[:notice] = "You unsaved #{find_beer_info(@savedbeer.beer_id)[1]}!"
      redirect_to root_url
    else
      flash[:alert] = "Failed to unsave!"
      redirect_to root_url
    end
  end


end
