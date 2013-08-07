class AddIndicesToBeernfosTable < ActiveRecord::Migration
  def change
    add_index :beerinfos, :beer_id
  end
end
