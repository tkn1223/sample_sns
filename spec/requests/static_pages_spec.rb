require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /home" do
    it "returns http success" do
      get static_pages_home_path
      expect(response).to have_http_status(200)
    end
  end
end


RSpec.describe "StaticPages", type: :request do
  describe "GET /help" do
    it "returns http success" do
      get static_pages_help_path
      expect(response).to have_http_status(200)
    end
  end
end

RSpec.describe "StaticPages", type: :request do
  describe "GET /about" do
    it "returns http success" do
      get static_pages_about_path
      expect(response).to have_http_status(200)
    end
  end
end
