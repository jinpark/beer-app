class Savedbeer < ActiveRecord::Base
  attr_accessible :beer_id, :user_id
  default_scope :include => :beerinfo

  belongs_to :user
  belongs_to :beerinfo, foreign_key: :beer_id, primary_key: :beer_id

  validates :beer_id, uniqueness: {scope: :user_id, message: "You have already saved this beer"}
  validates :beer_id, :user_id, presence: true
  
  def beer_style
    self.beerinfo.beer_style
  end

  def brewery_id
    self.beerinfo.brewery_id
  end

  def beer_name
    self.beerinfo.beer_name
  end

  def beer_abv
    self.beerinfo.beer_abv
  end

  def brewery_name
    self.beerinfo.brewery_name
  end
end