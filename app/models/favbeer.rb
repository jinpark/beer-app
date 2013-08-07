class Favbeer < ActiveRecord::Base
  attr_accessible :beer_id, :user_id

  belongs_to :user
end
