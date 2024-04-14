# frozen_string_literal: true

RSpec.describe 'Admin Customer Requests' do
  context 'when authorized' do
    let!(:session) { User.create!(email: 'example@hey.com', password: '123') }
    let!(:customer_request) { Ticket.create(name: 'test', subject: 'test', email: 'aa@ex.ua') }

    before do
      Capybara.current_driver = :rack_test
      allow_any_instance_of(AdminCustomerRequestsController).to receive(:authenticate!).and_return(session)
      visit admin_path
    end

    it 'should render one Customer request' do
      expect(page).to have_selector class: 'customer_request', count: 1
    end
  end

  context 'when do NOT authorized' do
    before do
      Capybara.current_driver = :rack_test
      visit admin_path
    end

    it 'should render error flash notification' do
      expect(page).to have_selector class: 'flash', exact_text: 'Access denied!'
    end
  end

  describe 'when change status from NEW to PENDING' do
    subject { click_on 'Move to PENDING status' }

    let!(:session) { User.create!(email: 'example@hey.com', password: '123') }
    let!(:customer_request) { Ticket.create(name: 'test', subject: 'test', email: 'aa@ex.ua') }

    before do
      Capybara.current_driver = :rack_test
      allow_any_instance_of(AdminCustomerRequestsController).to receive(:authenticate!).and_return(session)
      visit admin_customer_request_path(customer_request)
    end

    it 'should change status of related Customer request' do
      expect { subject }.to change { customer_request.reload.decorate.status_name }.from('NEW').to('PENDING')
      expect(page).to have_selector class: 'flash', exact_text: 'Customer request was successfully updated.'
    end
  end
end
