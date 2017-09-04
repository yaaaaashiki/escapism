RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end


def login_user_post(user = nil, route = nil, http_method = :post)
  user ||= @user
  route ||= sessions_url
  username_attr = user.sorcery_config.username_attribute_names.first
  email = user.send(username_attr)
  page.driver.send(http_method, route, { :"session" => {:"#{username_attr}" => email, :password => "password"}} )
end
  
  


