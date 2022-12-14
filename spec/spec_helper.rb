ENV['RAILS_ENV'] ||= 'test'

require_relative '../config/environment'
require 'rspec/rails'
require 'webmock/rspec'

RSpec.configure do |config|
  config.filter_rails_from_backtrace!

  config.infer_spec_type_from_file_location!
end
