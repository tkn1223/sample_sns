require 'rails_helper'
require 'nokogiri'

RSpec.describe "Some test", type: :request do
  before do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET /home" do
    it "returns http success" do
      get static_pages_home_path
      expect(response).to have_http_status(200)
      
      html = Nokogiri::HTML(response.body)
      title = html.at('title').text
      expect(title).to eq("Home | #{@base_title}")
    end
  end


  describe "GET /help" do
    it "returns http success" do
      get static_pages_help_path
      expect(response).to have_http_status(200)

      html = Nokogiri::HTML(response.body)
      title = html.at('title').text
      expect(title).to eq("Help | #{@base_title}")
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get static_pages_about_path
      expect(response).to have_http_status(200)

      html = Nokogiri::HTML(response.body)
      title = html.at('title').text
      expect(title).to eq("About | #{@base_title}")
    end
  end

  describe "GET /contact" do
    it "returns http success" do
      get static_pages_contact_path
      expect(response).to have_http_status(200)

      html = Nokogiri::HTML(response.body)
      title = html.at('title').text
      expect(title).to eq("Contact | #{@base_title}")
    end
  end
end
