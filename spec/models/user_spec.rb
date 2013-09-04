require "../spec_helper"

describe User do
  before :each do
    @user = FactoryGirl.create("users_with_asso")
    # @user = FactoryGirl.create("user")
  end
  describe "user" do
    it "checks for user" do
      @user.should be_an_instance_of User
    end

    it "checks for favbeer association" do
      @user.favbeers.first.should be_an_instance_of Favbeer
    end

    it "checks for savedbeer association" do
      @user.savedbeers.first.should be_an_instance_of Savedbeer
    end

  end

end
