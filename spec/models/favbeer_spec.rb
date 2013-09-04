require "../spec_helper"

describe Favbeer do
  before :each do
    @user = FactoryGirl.create("users_with_asso")
  end
  describe "favbeers" do
    it "checks for favbeer" do
      @user.favbeers.first.should be_an_instance_of Favbeer
    end

    it "checks for beerinfo association" do
      @user.favbeers.first.beerinfo.should be_an_instance_of Beerinfo
    end

    it "checks for beerinfo attributes" do
      @user.favbeers.first.beerinfo.beer_name.should == "Turbodog"
      @user.favbeers.first.beerinfo.beer_style.should ==  "English Brown Ale"
      @user.favbeers.first.beerinfo.beer_abv.should ==  5.6
      @user.favbeers.first.beerinfo.brewery_name.should ==  "Abita Brewing Co."
      @user.favbeers.first.beerinfo.brewery_id.should == 3
    end

    it "checks for favbeer custom methods" do
      @user.favbeers.first.beer_name.should == "Turbodog"
      @user.favbeers.first.beer_style.should ==  "English Brown Ale"
      @user.favbeers.first.beer_abv.should ==  5.6
      @user.favbeers.first.brewery_name.should ==  "Abita Brewing Co."
      @user.favbeers.first.brewery_id.should == 3
    end

  end

end
