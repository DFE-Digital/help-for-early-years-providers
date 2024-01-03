source "https://rubygems.org"

ruby "3.3.0"

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
  gem "rspec-rails"
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  gem "bundler-audit", require: false
  gem "brakeman", require: false
  gem "annotate"
  gem "web-console"
end

group :test do
  gem "selenium-webdriver"
  gem "capybara"
end
