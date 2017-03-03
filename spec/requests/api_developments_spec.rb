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
    before(:each) { State.delete_all }
    after(:each) { State.delete_all }

    it "create MongoDB-backed model" do
      state = State.create(name: "test")
      expect(State.find(state.id).name).to eq("test")
    end
    it "expose MongoDB-backed API resource"  do 
      state = State.create(name: "test")
      expect(states_path).to eq("/api/states")
      get state_path(state.id)
      expect(response).to have_http_status(:ok)
      expect(parsed_body["name"]).to eq("test")
      expect(parsed_body).to include("created_at")
      expect(parsed_body).to include("id"=>state.id.to_s)
    end
  end
end
