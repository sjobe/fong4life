require 'spec_helper'

describe "Donors" do
  describe "GET /donors" do
    it "works! (now write some real specs)" do
      get donors_path
      response.status.should be(302)
    end
  end
end
