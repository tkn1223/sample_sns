require 'rails_helper'
require 'nokogiri'

RSpec.describe "Some test", type: :request do
  before do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET /" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(200)

      html = Nokogiri::HTML(response.body)
      title = html.at('title').text
      expect(title).to eq("#{@base_title}")
    end
  end

  describe "GET /help" do
    it "returns http success" do
      get help_path
      expect(response).to have_http_status(200)

      html = Nokogiri::HTML(response.body)
      title = html.at('title').text
      expect(title).to eq("Help | #{@base_title}")
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get about_path
      expect(response).to have_http_status(200)

      html = Nokogiri::HTML(response.body)
      title = html.at('title').text
      expect(title).to eq("About | #{@base_title}")
    end
  end

  describe "GET /contact" do
    it "returns http success" do
      get contact_path
      expect(response).to have_http_status(200)

      html = Nokogiri::HTML(response.body)
      title = html.at('title').text
      expect(title).to eq("Contact | #{@base_title}")
    end
  end
end
