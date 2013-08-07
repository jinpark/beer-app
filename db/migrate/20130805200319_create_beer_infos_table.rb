class CreateBeerInfosTable < ActiveRecord::Migration
  def change
    create_table :beerinfos do |t|
      t.integer :beer_id
      t.string :beer_name

      t.timestamps
    end

  end
end
