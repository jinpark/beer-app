class Recommendation < ActiveRecord::Base
  attr_accessible :beer1_id, :beer2_id, :correlation

end
