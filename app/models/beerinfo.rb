class Beerinfo < ActiveRecord::Base
  attr_accessible :beer_id, :beer_name, :beer_style, :beer_abv, :brewery_name

  has_one :savedbeer
end
