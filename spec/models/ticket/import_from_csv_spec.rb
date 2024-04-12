# frozen_string_literal: true

require_relative '../../../app/models/ticket/import_from_csv'

RSpec.describe Ticket::ImportFromCsv do
  describe '#export' do
    subject { instance.export! }

    let(:instance) { described_class.new }
    let!(:ticket) { Ticket.build(name: 'John', email: 'john@email.com', subject: 'issue', created_at: Time.now) }
    let!(:second_ticket) do
      Ticket.build(name: 'Derek', email: 'derek@email.com', subject: 'there is error', created_at: Time.now)
    end

    before do
      FileUtils.rm_f(Ticket::ImportFromCsv::CONST::CSV_FILE_NAME)
      File.open(Ticket::ImportFromCsv::CONST::CSV_FILE_NAME, 'w') do |file|
        file.puts(
          [
            ticket.name,
            ticket.email,
            ticket.subject,
            ticket.content,
            ticket.created_at.strftime('%Y-%m-%d %H:%M')
          ].join(',')
        )
        file.puts(
          [
            second_ticket.name,
            second_ticket.email,
            second_ticket.subject,
            second_ticket.content,
            second_ticket.created_at.strftime('%Y-%m-%d %H:%M')
          ].join(',')
        )
      end
    end

    it 'should create two records' do
      expect { subject }.to change(Ticket, :count).from(0).to(2)
      expect(Ticket.first).to have_attributes(name: 'John', email: 'john@email.com')
      expect(Ticket.second).to have_attributes(name: 'Derek', email: 'derek@email.com')
    end

    it 'should delete CSV file' do
      instance.delete_csv_file
      expect(File.exist?(Ticket::ImportFromCsv::CONST::CSV_FILE_NAME)).to eq false
    end

    after do
      FileUtils.rm_f(Ticket::ImportFromCsv::CONST::CSV_FILE_NAME)
    end
  end
end
