class AddBeerinfosTable < ActiveRecord::Migration
  def up
    create_table "beerinfos", :force => true do |t|
      t.integer  "beer_id"
      t.string   "beer_name"
      t.string   "beer_style"
      t.float    "beer_abv"
      t.string   "brewery_name"
      t.integer  "brewery_id"

      t.timestamps
    end
  end

  def down
    drop_table :beerinfos
  end
end
