require "./spec_helper"

describe Savedbeer do
  before :each do
    @savedbeer = FactoryGirl.create("savedbeer")
  end

  describe "savedbeer" do
    it "checks for savedbeer" do
      @savedbeer.should be_an_instance_of Savedbeer
    end
  end

end
