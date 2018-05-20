if Rails.env == 'development'
  stylelint_path = Rails.root.join("node_modules/.bin/stylelint").to_s
  stylesheets_path = Rails.root.join("app/assets/stylesheets/**/*.scss").to_s
  lint_result = %x(#{stylelint_path} #{stylesheets_path})

  if lint_result.blank? == false
    puts 'StyleLint error:'
    print lint_result
    exit
  end
end
