# frozen_string_literal: true

class CustomerRequestsController < ApplicationController # :nodoc:
  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(permitted_params)

    if @ticket.save
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
end
