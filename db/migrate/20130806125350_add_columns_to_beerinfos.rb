class AddColumnsToBeerinfos < ActiveRecord::Migration
  def change
    add_column :beerinfos, :beer_style, :string
    add_column :beerinfos, :beer_abv, :float
    add_column :beerinfos, :brewery_name, :string
  end
end
