ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'pundit/rspec'

# Run codeclimate-test-reporter only in CI
if ENV['CI']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!

  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers
  config.include FactoryGirl::Syntax::Methods

  config.include Formulaic::Dsl, type: :feature
  config.include DeviseHelpers, type: :feature
  config.include Devise::TestHelpers, type: :controller
  config.include ArticleHelpers, type: :feature
  config.include CommentHelpers, type: :feature
  config.include WaitForAjax, type: :feature

  config.before do
    ActionMailer::Base.deliveries.clear
  end
end
