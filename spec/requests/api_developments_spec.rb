require 'rails_helper'

RSpec.describe "ApiDevelopments", type: :request do
  def parsed_body
    JSON.parse(response.body)
  end
  describe "RDBMS-backed" do
    before(:each) { City.delete_all }
    after(:each) { City.delete_all }

    it "create RDBMS-backed model" do
      city = City.create(name: "test")
      expect(City.find(city.id).name).to eq("test")
    end

    it "expose RDBMS-backed API resource" do 
      city = City.create(name: "test")
      expect(cities_path).to eq("/api/cities")
      get city_path(city.id)
      expect(response).to have_http_status(:ok)
      expect(parsed_body["name"]).to eq("test")
    end
  end

  describe "MongoDB-backed" do
    it "create MongoDB-backed model" do
    end
    it "expose MongoDB-backed API resource" do
    end
  end
end
