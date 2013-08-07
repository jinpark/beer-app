class Savedbeer < ActiveRecord::Base
  attr_accessible :beer_id, :user_id

  belongs_to :user
  belongs_to :beerinfo, foreign_key: :beer_id, primary_key: :beer_id
end