require "spec_helper"

describe DenunciasController do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/denuncias").not_to be_routable
    end

    it "routes to #new" do
      get("/denuncias/new").should route_to("denuncias#new")
    end

    it "routes to #show" do
      get("/denuncias/1").should route_to("denuncias#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get: "/denuncias/1/edit").not_to be_routable
    end

    it "routes to #create" do
      post("/denuncias").should route_to("denuncias#create")
    end

    it "routes to #update" do
      expect(put: "/denuncias/1").not_to be_routable
    end

    it "routes to #destroy" do
      expect(delete: "/denuncias/1").not_to be_routable
    end

  end
end
