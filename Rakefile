# frozen_string_literal: true

require File.expand_path('config/application', __dir__)

def print_text(text, color: Bundler::Thor::Shell::Color::WHITE)
  puts "#{color}#{text}#{Bundler::Thor::Shell::Color::CLEAR}"
end

Rails.application.load_tasks

desc 'Creates default user that can manager all customer requests (admin@example.com) with admin password'
task create_default_user: :environment do
  if User.find_by(email: 'admin@example.com')
    print_text 'User already exist'
  else
    user = User.create(email: 'admin@example.com', password: 'admin')
    print_text 'Default User was successfully created!' if user.persisted?
  end
  print_text 'Done!'
end
