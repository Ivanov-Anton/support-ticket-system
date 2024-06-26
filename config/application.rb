# frozen_string_literal: true

require_relative 'boot'
require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'

Bundler.require(*Rails.groups)

module SupportTicketSystem
  # Responsibility of coordinating the whole boot process
  class Application < Rails::Application
    config.load_defaults 7.1
    config.active_record.schema_format = :sql

    # config.assets.debug = true
    # config.assets.compress = false
    # config.assets.quiet = true
    # config.assets.raise_runtime_errors = true
  end
end
