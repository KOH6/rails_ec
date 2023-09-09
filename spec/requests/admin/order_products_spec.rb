require 'rails_helper'

RSpec.describe "Admin::OrderProducts", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/order_products/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/admin/order_products/show"
      expect(response).to have_http_status(:success)
    end
  end

end
