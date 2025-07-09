# spec/rails_helper.rb

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rspec'

# support以下を読み込む
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.fixture_paths = [Rails.root.join('spec/fixtures')]
  config.use_transactional_fixtures = true
  config.filter_rails_from_backtrace!

  # FactoryBot を使いやすくする
  config.include FactoryBot::Syntax::Methods
  # test_helpers.rbを継承
  config.include TestHelpers, type: :request
  config.include TestHelpers, type: :controller
  # systemテストの継承（永続化cookiesの動作確認など）
  config.include ShowMeTheCookies, type: :system

  # system spec 用ドライバ設定
  config.before(:each, type: :system) do |example|
    # JavaScript が不要なら rack_test（高速）、必要なら Selenium + Chrome ヘッドレス
    driven_by example.metadata[:js] ? :selenium_chrome_headless : :rack_test
  end
end
