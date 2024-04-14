# frozen_string_literal: true

RSpec.describe 'Session create' do
  subject { click_button 'Sign in' }

  let!(:session) { User.create!(email: 'example@gmail.com', password: '123') }

  context 'when submit form without password' do
    before do
      Capybara.current_driver = :rack_test
      visit new_session_path
    end

    it 'should render validation error' do
      subject
      expect(page).to have_content 'invalid email or password'
    end
  end
end
