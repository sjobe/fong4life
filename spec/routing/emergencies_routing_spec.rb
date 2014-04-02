require "spec_helper"

describe EmergenciesController do
  describe "routing" do

    it "routes to #index" do
      get("/emergencies").should route_to("emergencies#index")
    end

    it "routes to #new" do
      get("/emergencies/new").should route_to("emergencies#new")
    end

    it "routes to #show" do
      get("/emergencies/1").should route_to("emergencies#show", :id => "1")
    end

    it "routes to #edit" do
      get("/emergencies/1/edit").should route_to("emergencies#edit", :id => "1")
    end

    it "routes to #create" do
      post("/emergencies").should route_to("emergencies#create")
    end

    it "routes to #update" do
      put("/emergencies/1").should route_to("emergencies#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/emergencies/1").should route_to("emergencies#destroy", :id => "1")
    end

  end
end
