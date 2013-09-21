require "spec_helper"

describe BloodDrivesController do
  describe "routing" do

    it "routes to #index" do
      get("/blood_drives").should route_to("blood_drives#index")
    end

    it "routes to #new" do
      get("/blood_drives/new").should route_to("blood_drives#new")
    end

    it "routes to #show" do
      get("/blood_drives/1").should route_to("blood_drives#show", :id => "1")
    end

    it "routes to #edit" do
      get("/blood_drives/1/edit").should route_to("blood_drives#edit", :id => "1")
    end

    it "routes to #create" do
      post("/blood_drives").should route_to("blood_drives#create")
    end

    it "routes to #update" do
      put("/blood_drives/1").should route_to("blood_drives#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/blood_drives/1").should route_to("blood_drives#destroy", :id => "1")
    end

  end
end
