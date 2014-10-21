gem 'ember-rails'
gem 'ember-source'
gem 'emblem-rails'

gem 'ffaker'
gem 'puma'

gsub_file 'Gemfile', /gem 'turbolinks'\n/,''
gsub_file 'app/assets/javascripts/application.js', '//= require turbolinks', ''
gsub_file 'app/views/layouts/application.html.erb',
		"<%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>",
		"<%= stylesheet_link_tag 'application' %>"

gsub_file 'app/views/layouts/application.html.erb',
		"<%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>",
		"<%= javascript_include_tag 'application' %>"

file '.ruby-gemset', "#{app_name}"
file '.ruby-version', '2.1.2'
file '.editorconfig', <<-EDITORCONFIG
root = true

# Unix-style newlines with a newline ending every file
[*]
end_of_line = lf
insert_final_newline = true
indent_style = space
indent_size = 2

# 4 space indentation
[*.py]
indent_style = space
indent_size = 4

[*.js]
indent_style = space
indent_size = 4

[*.rb]
indent_style = space
indent_size = 2

[*.haml]
indent_style = space
indent_size = 2

[*.scss]
indent_style = space
indent_size = 4

[*.txt]
indent_style = space
indent_size = 2

# Indentation override for all JS under lib directory
[lib/**.js]
indent_style = space
indent_size = 2
EDITORCONFIG

run 'bundle install'

inject_into_file 'config/environments/development.rb',
after: 'Rails.application.configure do' do<<-RUBY

	config.ember.variant = :development
RUBY
end

inject_into_file 'config/environments/test.rb',
after: 'Rails.application.configure do' do <<-RUBY

	config.ember.variant = :development
RUBY
end

inject_into_file 'config/environments/production.rb',
after: 'Rails.application.configure do' do<<-RUBY

	config.ember.variant = :production
RUBY
end


run 'rails g ember:bootstrap -n App --javascript-engine js'
# Uncomment the below for coffeescript
# run 'rails g ember:bootstrap -n App --javascript-engine coffee'


run 'rails g ember:install --ember'
# run 'rails g ember:install --tag=v1.5.0 --ember'

run 'rails g ember:install --ember-data'
# run 'rails g ember:install --tag=v1.0.0-beta.7 --ember-data'
