# frozen_string_literal: true

require 'csv'

class Ticket < ActiveRecord::Base
  ##
  # Implementation of importing Customer Request
  # submitted from users from internet and save them
  # into DB.
  class ImportFromCsv
    include ActiveModel::Attributes

    Error = Class.new(StandardError)

    module CONST # :nodoc:
      CSV_FILE_NAME = "customer_requests_#{Rails.env}.csv"
      freeze
    end

    attribute :csv_file_name, default: CONST::CSV_FILE_NAME
    attribute :amount_of_affected_rows, default: 0

    ##
    # Raises an exception if CSV file not found
    # # Raises Ticket::ImportFromCsv::Error (CSV file not found)
    def export!
      raise_if_invalid!

      import_customer_request
      true
    end

    def delete_csv_file
      FileUtils.rm_f(Ticket::ImportFromCsv::CONST::CSV_FILE_NAME)
    end

    private

    def import_customer_request
      result = Ticket.insert_all(
        CSV.foreach(csv_file_name).map do |row|
          { name: row.first, email: row.second, subject: row.third, content: row.fourth, created_at: row.fifth }
        end
      )
      self.amount_of_affected_rows = result.count
    end

    def raise_if_invalid!
      raise Error, 'CSV file not found' unless File.exist?(csv_file_name)
    end
  end
end
