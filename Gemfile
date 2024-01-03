source "https://rubygems.org"

ruby "3.3.0"

gem "rack-canonical-host"
gem "good_migrations"
gem "rails", "~> 7.1.2"
gem "propshaft"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "launchy"
  gem "factory_bot_rails"
  gem "dotenv-rails"
  gem "rspec-rails"
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  gem "rack-mini-profiler"
  gem "pgcli-rails"
  gem "erb_lint", require: false
  gem "bundler-audit", require: false
  gem "brakeman", require: false
  gem "annotate"
  gem "web-console"
end

group :test do
  gem "capybara-lockstep"
  gem "selenium-webdriver"
  gem "capybara"
end
