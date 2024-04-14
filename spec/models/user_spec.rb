# frozen_string_literal: true

RSpec.describe User do
  describe 'uniqueness of email column validation' do
    let!(:user) { User.build(email: 'example@gmail.com', password: '123') }

    before { User.create(email: 'example@gmail.com', password: '123') }

    it 'should be invalid and return validation error' do
      expect(user).to be_invalid
      expect(user.errors.messages).to eq email: ['has already been taken']
    end
  end

  describe 'unique index index_users_on_email' do
    subject { user.save(validate: false) }

    before { User.create(email: 'example@gmail.com', password: '123') }
    let!(:user) { User.build(email: 'example@gmail.com', password: '123') }

    it 'should raise error' do
      expect { subject }.to raise_error ActiveRecord::RecordNotUnique
    end
  end
end
