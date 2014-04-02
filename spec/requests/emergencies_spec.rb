require 'spec_helper'

describe "Emergencies" do
  describe "GET /emergencies" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get emergencies_path
      response.status.should be(200)
    end
  end
end
