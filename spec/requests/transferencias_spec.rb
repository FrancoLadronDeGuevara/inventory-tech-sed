require 'rails_helper'

RSpec.describe "Transferencias", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/transferencias/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/transferencias/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/transferencias/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/transferencias/create"
      expect(response).to have_http_status(:success)
    end
  end

end
