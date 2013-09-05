require "../spec_helper"

describe Savedbeer do
  before :each do
    @user = FactoryGirl.create("users_with_asso")
  end

  describe "savedbeers" do
    it "checks for savedbeer" do
      @user.savedbeers.first.should be_an_instance_of Savedbeer
    end

    it "checks for beerinfo association" do
      @user.savedbeers.first.beerinfo.should be_an_instance_of Beerinfo
    end

    it "checks for savedbeers custom beerinfo methods" do
      @user.savedbeers.first.beer_name.should == "Turbodog"
      @user.savedbeers.first.beer_style.should ==  "English Brown Ale"
      @user.savedbeers.first.beer_abv.should ==  5.6
      @user.savedbeers.first.brewery_name.should ==  "Abita Brewing Co."
      @user.savedbeers.first.brewery_id.should == 3
    end

  end

end
