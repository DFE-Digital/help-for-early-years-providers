source "https://rubygems.org"

ruby "3.3.0"

gem "bootsnap", require: false
gem "cssbundling-rails"
gem "good_migrations"
gem "jsbundling-rails"
gem "pg", "~> 1.1"
gem "propshaft"
gem "puma", ">= 5.0"
gem "rack-canonical-host"
gem "rails", "~> 7.1.2"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  gem "debug", platforms: %i[mri windows]
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "launchy"
  gem "rspec-rails"
end

group :development do
  gem "annotate"
  gem "brakeman", require: false
  gem "bundler-audit", require: false
  gem "erb_lint", require: false
  gem "pgcli-rails"
  gem "rack-mini-profiler"
  gem "rubocop", require: false
  gem "rubocop-capybara", require: false
  gem "rubocop-factory_bot", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", ">= 2.22.0", require: false
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "capybara-lockstep"
  gem "selenium-webdriver"
end
