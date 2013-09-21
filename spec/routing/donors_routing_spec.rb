require "spec_helper"

describe DonorsController do
  describe "routing" do

    it "routes to #index" do
      get("/donors").should route_to("donors#index")
    end

    it "routes to #new" do
      get("/donors/new").should route_to("donors#new")
    end

    it "routes to #show" do
      get("/donors/1").should route_to("donors#show", :id => "1")
    end

    it "routes to #edit" do
      get("/donors/1/edit").should route_to("donors#edit", :id => "1")
    end

    it "routes to #create" do
      post("/donors").should route_to("donors#create")
    end

    it "routes to #update" do
      put("/donors/1").should route_to("donors#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/donors/1").should route_to("donors#destroy", :id => "1")
    end

  end
end
