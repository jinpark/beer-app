FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "username#{n}" }
    sequence(:email) {|n| "email#{n}@factory.com" }
    password "password"
    password_confirmation "password"
    location "10007"
  end

  factory :favbeer do 
    beer_id 6
    user_id 1
    association :user
  end

  factory :savedbeer do 
    beer_id 6
    user_id 1
    association :user
  end

  factory :beerinfo do
    beer_id 6
    beer_name "Turbodog"
    beer_style "English Brown Ale"
    beer_abv 5.6
    brewery_name "Abita Brewing Co."
    brewery_id 3
    association :favbeer
  end

  factory :favbeer_beerinfo, parent: :favbeer do
    beerinfo { FactoryGirl.create(:beerinfo) }
  end

  factory :savedbeer_beerinfo, parent: :savedbeer do
    beerinfo { FactoryGirl.create(:beerinfo) }
  end

  factory :users_with_asso, parent: :user do 
    savedbeers { [ FactoryGirl.create(:savedbeer_beerinfo) ] }
    favbeers {[ FactoryGirl.create(:favbeer_beerinfo) ]}
  end


end