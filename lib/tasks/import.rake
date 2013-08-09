require 'csv'

desc "Import beerinfo from csv file"
task :import => [:environment] do

  file = "/Users/jinpark/Documents/beer/data/beerinfos1.csv"

  CSV.foreach(file, :headers => true) do |row|
    Beerinfo.create beer_id: row[0], beer_name: row[1], beer_style: row[2], beer_abv: row[3], brewery_name: row[4], brewery_id: row[5]
  end

  file = "/Users/jinpark/Documents/beer/data/beerrecs.csv"

  CSV.foreach(file, :headers => true) do |row|
    Recommendation.create beer1_id: row[0], beer2_id: row[1], correlation: row[2]
  end


end