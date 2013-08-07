class AddRecommendationsTable < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :beer1_id
      t.integer :beer2_id
      t.float :correlation

      t.timestamps
    end
  end
end
