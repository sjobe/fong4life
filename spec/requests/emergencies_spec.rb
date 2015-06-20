require 'spec_helper'

describe "Emergencies" do
  describe "GET /emergencies" do
    it "works! (now write some real specs)" do
      get emergencies_path
      response.status.should be(302)
    end
  end
end
