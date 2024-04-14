# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id         :bigint(8)        not null, primary key
#  content    :text             not null
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ticket_id  :bigint(8)        not null
#
# Indexes
#
#  index_comments_on_ticket_id  (ticket_id)
#
# Foreign Keys
#
#  fk_rails_...  (ticket_id => tickets.id)
#
RSpec.describe Comment do
  describe '#save!' do
    subject { described_class.new(record_attrs).save! }

    let!(:ticket) { Ticket.create(email: 'customer@gmail.com', name: 'n', subject: 's') }
    let(:record_attrs) { { content: 'content', email: 'test@gmail.com', ticket: } }

    it 'should create record' do
      expect { subject }.to change(described_class, :count).by(1)
    end
  end
end
