class Favbeer < ActiveRecord::Base
  attr_accessible :beer_id, :user_id

  belongs_to :user
  belongs_to :beerinfo, foreign_key: :beer_id, primary_key: :beer_id

  validates :beer_id, uniqueness: {scope: :user_id, message: "You have already favorited this beer"}
end
