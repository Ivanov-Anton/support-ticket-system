# frozen_string_literal: true

RSpec.describe 'Customer Request' do
  subject { click_button 'Create' }

  context 'when fill in all fields' do
    before do
      Capybara.current_driver = :rack_test
      visit '/'
      fill_in 'Subject', with: 'Do not work the SMS Trunk'
      fill_in 'Name', with: 'Fake name'
      fill_in 'Email', with: 'john.doe@example.com'
      fill_in 'Content', with: 'too long content text'
    end

    it 'the fields should be filled properly' do
      expect(page).to have_field 'Subject', with: 'Do not work the SMS Trunk'
      expect(page).to have_field 'Name', with: 'Fake name', type: :text
      expect(page).to have_field 'Email', with: 'john.doe@example.com', type: :email
      expect(page).to have_field 'Content', with: 'too long content text'

      expect(page).to have_button 'Create'
    end
  end

  context 'when submit empty form' do
    before do
      Capybara.current_driver = :rack_test
      visit '/'
    end

    it 'should render form and display validation errors' do
      subject

      expect(page).to have_content 'There is 3 errors occurred'
      expect(page).to have_field 'Subject', with: ''
      expect(page).to have_field 'Name', with: '', type: :text
      expect(page).to have_field 'Email', with: '', type: :email
      expect(page).to have_field 'Content', with: ''
    end
  end

  context 'when fill in all fields and submit form' do
    let(:flash_message) { 'Your request was successfully created, and support team will review it within 1 minute.' }
    let(:csv_content) { CSV.foreach(Ticket::ImportFromCsv::CONST::CSV_FILE_NAME).map { |i| i } }

    before do
      Capybara.current_driver = :rack_test
      FileUtils.rm_f(Ticket::ImportFromCsv::CONST::CSV_FILE_NAME)
      visit '/'
      fill_in 'Subject', with: 'Do not work the SMS Trunk'
      fill_in 'Name', with: 'Fake name'
      fill_in 'Email', with: 'john.doe@example.com'
      fill_in 'Content', with: 'too long content text'
    end

    after { FileUtils.rm_f(Ticket::ImportFromCsv::CONST::CSV_FILE_NAME) }

    it 'should render successfully flash message and produce CSV file' do
      subject

      expect(page).to have_selector class: 'flash', exact_text: flash_message
      expect(csv_content).to match [
        ['Fake name', 'john.doe@example.com', 'Do not work the SMS Trunk', 'too long content text', be_present]
      ]
    end
  end
end
