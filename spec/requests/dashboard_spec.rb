require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  before do
    allow_any_instance_of(DashboardController).to receive(:authenticated?).and_return(true)
  end
  describe "GET /index" do
    it "retorna http success" do
      get "/dashboard"
      expect(response).to have_http_status(:success)
    end
  end
end
