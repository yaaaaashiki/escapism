RSpec.configure do |config|

#  config.include Sorcery::TestHelpers::Rails
#
#  config.include Sorcery::TestHelpers::Rails::Controller, type: :controller
#  config.include Sorcery::TestHelpers::Rails::Integration, type: :feature
#
#  config.include AuthenticationForFeatureRequest, type: :feature

  config.include FactoryGirl::Syntax::Methods

#  config.before :all do
#    FactoryGirl.reload
#  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end

module Sorcery
  module TestHelpers
    module Rails
      def login_user_post(user, password)
        page.driver.post(user_sessions_url, { username: user, password: password}) 
      end
    end
  end
end
