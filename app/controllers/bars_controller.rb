class BarsController < ApplicationController

  def findbar
  beer_name = params[:bar][:beer_name]
  location = current_user.location
  bars = find_bars_with_beer_name(beer_name, location)
    render json: bars
  end
end
