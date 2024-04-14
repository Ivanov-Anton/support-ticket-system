# frozen_string_literal: true

require File.expand_path('config/application', __dir__)
require_relative 'app/models/ticket/import_from_csv'

def print_text(text, color: Bundler::Thor::Shell::Color::WHITE)
  puts "#{color}#{text}#{Bundler::Thor::Shell::Color::CLEAR}"
end

Rails.application.load_tasks

desc "Import all Customer requests rows from #{Ticket::ImportFromCsv::CONST::CSV_FILE_NAME} file and save them into DB"
task import_customer_requests_from_csv: :environment do
  print_text "Importing Customer Requests from CSV (#{Ticket::ImportFromCsv::CONST::CSV_FILE_NAME}) File into DB"
  import = Ticket::ImportFromCsv.new
  import.csv_file_name = Ticket::ImportFromCsv::CONST::CSV_FILE_NAME
  import.export!
  print_text(
    "  The import operation was successfully performed and inserted #{import.amount_of_affected_rows} records!",
    color: Bundler::Thor::Shell::Color::GREEN
  )
  print_text '  Delete CSV file...'
  import.delete_csv_file
rescue Ticket::ImportFromCsv::Error => e
  print_text(
    "  #{e.message}",
    color: Bundler::Thor::Shell::Color::RED
  )
ensure
  print_text 'Done.'
end
