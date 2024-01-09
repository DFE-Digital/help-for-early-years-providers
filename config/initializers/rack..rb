# TODO: Remove once capybara is updated
# https://github.com/teamcapybara/capybara/issues/2705
if Rails.env.test?
  require 'rackup'
  module Rack
    Handler = ::Rackup::Handler
  end
end
