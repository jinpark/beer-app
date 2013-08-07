class CreateFavBeers < ActiveRecord::Migration
  def change
    create_table :fav_beers do |t|
      t.integer :beer_id
      t.integer :user_id

      t.timestamps
    end
  end
end
