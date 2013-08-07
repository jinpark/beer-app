class ChangeFavBeerTableName < ActiveRecord::Migration
  def up
    rename_table :fav_beers, :favbeers

  end

  def down
    rename_table :favbeers, :fav_beers
  end
end
