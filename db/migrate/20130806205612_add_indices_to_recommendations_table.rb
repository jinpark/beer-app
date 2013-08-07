class AddIndicesToRecommendationsTable < ActiveRecord::Migration
  def change
    add_index :recommendations, :beer1_id
    add_index :recommendations, :beer2_id
  end
end
