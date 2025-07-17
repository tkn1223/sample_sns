source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.8"

gem "rails",           "7.2.2.1"
gem "bcrypt",          "3.1.18"
gem "bootstrap-sass",  "3.4.1"
gem "faker",           "2.21.0"
gem "will_paginate",           "3.3.1"
gem "bootstrap-will_paginate", "1.0.0"
gem "sassc-rails",     "2.1.2"
gem "sprockets-rails", "3.4.2"
gem "importmap-rails", "1.1.5"
gem "turbo-rails",     "2.0.16"
gem "stimulus-rails",  "1.2.1"
gem "jbuilder",        "2.11.5"
gem "puma",            "~> 6.4"
gem "bootsnap",        "1.16.0", require: false
gem "mysql2",          "~> 0.5"
gem "concurrent-ruby", "1.3.4"

group :development, :test do
  gem "reline",        "0.5.10"
  gem "debug",         "1.7.1", platforms: %i[ mri mingw x64_mingw ]
  # brakeman入れたかったら事前にターミナル上でbundle installが必要
  gem "brakeman",      require: false
  gem "rubocop-rails-omakase", require: false
  gem "rspec-rails",   "~> 8.0.0"
  gem "factory_bot_rails"
end

group :development do
  gem "web-console",         "4.2.0"
  gem "solargraph",          "0.53.4"
  gem "repl_type_completor", "0.1.11"
  gem "guard"
  gem "guard-rspec",         require: false
end

group :test do
  gem "capybara",                 "3.38.0"
  gem "selenium-webdriver",       "4.8.3"
  gem "webdrivers",               "5.2.0"
  gem "rails-controller-testing", "1.0.5"
  gem "minitest",                 "5.18.0"
  gem "minitest-reporters",       "1.6.0"
  gem "show_me_the_cookies"
  # gem "guard",                    "2.18.0"
  # gem "guard-minitest",           "2.4.6"
end

group :production do
  gem "pg", "1.3.5"
end

# Windows ではタイムゾーン情報用の tzinfo-data gem を含める必要があります
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
