class Beerinfo < ActiveRecord::Base
  attr_accessible :beer_id, :beer_name, :beer_style, :beer_abv, :brewery_name, :brewery_id

  has_one :savedbeer
end
