require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get signup_path
      expect(response).to have_http_status(200)

      # html = Nokogiri::HTML(response.body)
      # title = html.at('title').text
      # expect(title).to eq("#{@base_title}")
    end
  end
end
