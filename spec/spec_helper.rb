ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'email_spec'
require 'database_cleaner'
require 'factory_girl_rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.include Sorcery::TestHelpers::Rails
  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers
  config.include Requests::JsonHelpers, :type => :controller
  config.include AuthenticationHelper, :type => :controller
  config.include Rails.application.routes.url_helpers

  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.before :each do
    if Capybara.current_driver == :selenium
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
    end
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
