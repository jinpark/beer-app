class DropBeerinfoTable < ActiveRecord::Migration
  def up
    drop_table :beerinfos
  end

  def down
    create_table "beerinfos", :force => true do |t|
      t.integer  "beer_id"
      t.string   "beer_name"
      t.datetime "created_at",   :null => false
      t.datetime "updated_at",   :null => false
      t.string   "beer_style"
      t.float    "beer_abv"
      t.string   "brewery_name"
    end
  end
end
