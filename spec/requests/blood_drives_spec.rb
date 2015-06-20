require 'spec_helper'

describe "BloodDrives" do
  describe "GET /blood_drives" do
    it "works! (now write some real specs)" do
      get blood_drives_path
      response.status.should be(302)
    end
  end
end
