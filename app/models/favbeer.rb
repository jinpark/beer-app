class Favbeer < ActiveRecord::Base
  attr_accessible :beer_id, :user_id
  default_scope :include => :beerinfo

  belongs_to :user
  belongs_to :beerinfo, foreign_key: :beer_id, primary_key: :beer_id

  validates :beer_id, uniqueness: {scope: :user_id, message: "You have already favorited this beer"}
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

  def self.beerabvs_array(user)
    beerabvs_hash = Hash.new(0)
    user.favbeers.each do |favbeer|
      case
        when  favbeer.beerinfo.beer_abv.between?(0,3)
          beerabvs_hash["0% - 3%"] += 1
        when  favbeer.beerinfo.beer_abv.between?(3.1,4)
          beerabvs_hash["3% - 4%"] += 1
        when  favbeer.beerinfo.beer_abv.between?(4.1,5)
          beerabvs_hash["4% - 5%"] += 1
        when  favbeer.beerinfo.beer_abv.between?(5.1,6)
          beerabvs_hash["5% - 6%"] += 1
        when  favbeer.beerinfo.beer_abv.between?(6.1,9)
          beerabvs_hash["6% - 9%"] += 1
        when  favbeer.beerinfo.beer_abv > 9
          beerabvs_hash["9%+"] += 1
      end
    end
    beerabvs_hash.sort
  end

  def self.beerstyles_hash(user)
    beerstyles_hash = Hash.new(0)
    user.favbeers.each do |favbeer|
      beerstyles_hash[favbeer.beerinfo.beer_style] += 1
    end
    beerstyles_hash
  end

  def self.commonality(user1, user2)
    if user1.favbeers.empty? || user2.favbeers.empty?
      common =  []
    else
      common = user1.favbeers.pluck(:beer_id) & user2.favbeers.pluck(:beer_id)
    end
    common
  end

end