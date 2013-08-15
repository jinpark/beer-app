class SavedbeersController < ApplicationController

  def create
    @savedbeer = Savedbeer.new(params[:savedbeers])
    @savedbeer.user_id = current_user.id
    if @savedbeer.save
      if request.xhr?
        # Render a partial as response when using ajax requests.
        render partial: "users/saved_beer_info_and_buttons", locals: {saved_beer: @savedbeer, fav_beer_beer_ids: current_user.favbeers.pluck("beer_id")}
      else
        # Redirect as usual for plain html requests.
        flash[:notice] = "You saved #{@savedbeer.beer_name}!"
        redirect_to root_url
      end
    else
      if request.xhr?
        render partial: "shared/error"
      else
        flash[:alert] = "Failed to save"
        redirect_to root_url
      end
    end
  end

  def destroy
    @savedbeer = Savedbeer.find_by_id_and_user_id(params[:id], current_user.id)
    if @savedbeer.destroy
      if request.xhr?
        # Render a partial as response when using ajax requests.
        render partial: "users/unsaved"
      else
        # Redirect as usual for plain html requests.
        flash[:notice] = "You unsaved #{@savedbeer.beer_name}!"
        redirect_to root_url
      end
    else
      if request.xhr?
        render partial: "shared/error"
      else
        flash[:alert] = "Failed to unsave!"
        redirect_to root_url
      end
    end
  end


end
