class ApplicationController < ActionController::Base
  protect_from_forgery

  def find_recommendations(beer_id)
    beer_recs = []
    beer_recs1 = []
    beer_recs2 = []
    col1 = Recommendation.find_all_by_beer1_id(beer_id)
    col2 = Recommendation.find_all_by_beer2_id(beer_id)

    col1.each do |rec|
      beer_recs1 << [rec.beer2_id, rec.correlation]
    end
    
    col2.each do |rec|
      beer_recs2 << [rec.beer1_id, rec.correlation]
    end

    beer_recs = beer_recs1 + beer_recs2

    beer_recs.sort! { |a,b| b[1] <=> a[1] }


    return [beer_id, beer_recs[0..5]]
  end

  def find_beer_info(beer_id)
    beer = Beerinfo.find_by_beer_id(beer_id)
    return [beer.brewery_name, beer.beer_name, beer.beer_style, beer.brewery_id]
  end

  def find_beer_info_array(recommendation_array)
    beer_ids = []
    recommendation_array.sort_by!{ |x| x[0]}
    recommendation_array.each do |rec|
      beer_ids << rec[0]
    end
    beerinfos = Beerinfo.find_all_by_beer_id(beer_ids)
    beerinfos.each_with_index do |beer, i|
      recommendation_array[i][0] = [beer.brewery_name, beer.beer_name, beer.beer_style, beer.beer_id, beer.brewery_id]
    end
    recommendation_array.sort_by!{ |x| x[1]}.reverse!
    return recommendation_array
  end


  def find_bars_with_beer_name(beer_name, location)

    apiurl = Addressable::URI.new(
   :scheme => "https",
   :host => "www.taplister.com",
   :path => "api/v3/bar",
   :query_values => {
    username: "jin",
    api_key: ENV["TAPLISTER_API_KEY"],
    near: location,
    beer_query: beer_name,
    radius: "10",
    format: "json"
    }
    ).to_s

    response = RestClient.get(apiurl)
    JSON.parse(response)["objects"]
  end











end
