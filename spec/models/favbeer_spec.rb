require "../spec_helper"

describe Favbeer do
  before :each do
    @user = FactoryGirl.create("users_with_asso")
    @user1 = FactoryGirl.create("users_with_asso")
  end

  describe "favbeers" do
    it "checks for favbeer" do
      @user.favbeers.first.should be_an_instance_of Favbeer
    end

    it "checks for beerinfo association" do
      @user.favbeers.first.beerinfo.should be_an_instance_of Beerinfo
    end

    it "checks for favbeer custom beerinfo methods" do
      @user.favbeers.first.beer_name.should == "Turbodog"
      @user.favbeers.first.beer_style.should ==  "English Brown Ale"
      @user.favbeers.first.beer_abv.should ==  5.6
      @user.favbeers.first.brewery_name.should ==  "Abita Brewing Co."
      @user.favbeers.first.brewery_id.should == 3
    end

    it "checks beerabvs_array" do
      Favbeer.beerabvs_array(@user).should == [["5% - 6%", 1]]
    end

    it "checks beerstyles_hash" do
      Favbeer.beerstyles_hash(@user).should == {"English Brown Ale" => 1}
    end

    # it "checks commonality" do
    #   # Favbeer.commonality(@user, @user).should == [6]
    #   # @user.favbeers.pluck(:beer_id).should == @user1.favbeers.pluck(:beer_id)
    #   @user.favbeers.pluck(:beer_id).should == 6
    #   @user1.favbeers.pluck(:beer_id).should == 6
    # end

  end

end
