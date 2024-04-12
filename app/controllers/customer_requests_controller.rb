# frozen_string_literal: true

require 'csv'

class CustomerRequestsController < ApplicationController # :nodoc:
  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(permitted_params)

    if @ticket.valid?
      save_raw_data_to_csv
      flash[:notice] = 'Your request was successfully created, and support team will review it within 1 minute.'
      render :successfully_created, status: :created
    else
      render :new, status: :unprocessable_entity
    end
  end

  def successfully_created; end

  private

  def permitted_params
    params.require(:ticket).permit(:name, :subject, :email, :content)
  end

  def save_raw_data_to_csv
    CSV.open('customer_requests.csv', 'a') do |csv|
      csv << [@ticket.name, @ticket.email, @ticket.subject, @ticket.content, Time.now.utc.strftime('%Y-%m-%d %H:%M')]
    end
  end
end
