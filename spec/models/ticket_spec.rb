# frozen_string_literal: true

# == Schema Information
#
# Table name: tickets
#
#  id         :bigint(8)        not null, primary key
#  content    :text
#  email      :string
#  name       :string
#  subject    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status_id  :integer(2)       default(1)
#

RSpec.describe Ticket do
  describe 'validation' do
    let(:ticket) { Ticket.new(ticket_attrs) }

    describe 'email' do
      subject do
        ticket.valid?
        ticket.errors.messages
      end

      let(:ticket_attrs) { {} }

      context 'when email is "invalid"' do
        let(:ticket_attrs) { { email: 'invalid' } }

        it 'should return validation error' do
          expect(subject[:email]).to contain_exactly('is invalid')
        end
      end

      context 'when email is "john@doe.com"' do
        let(:ticket_attrs) { { email: 'john@doe.com' } }

        it 'should NOT return validation error' do
          expect(subject[:email]).to be_empty
        end
      end
    end
  end

  describe 'destroy!' do
    subject { ticket.destroy! }

    let!(:ticket) { Ticket.create!(email: 'customer@gmail.com', name: 'n', subject: 's') }
    let!(:comment) { Comment.create!(email: ticket.email, content: 'c', ticket:) }

    it 'should destroy! Ticket and all dependent records' do
      expect { subject }.to change(described_class, :count)
        .by(-1)
        .and change(Comment, :count).by(-1)
    end
  end
end
