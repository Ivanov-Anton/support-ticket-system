# frozen_string_literal: true

class AdminCustomerRequestsController < ApplicationController # :nodoc:
  before_action :authenticate!

  def index
    @tickets = Ticket.all
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy!

    flash[:notice] = 'Customer request was successfully destroyed.'
    redirect_to admin_path
  end

  # PATCH /admin_customer_requests/1
  def update
    @ticket = Ticket.find(params[:id])

    if @ticket.update(permitted_params)
      redirect_to admin_customer_request_path(@ticket), notice: 'Customer request was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def authenticate!
    User.find_by!(id: cookies.encrypted[:current_user])
  rescue ActiveRecord::RecordNotFound => _e
    flash[:error] = 'Access denied!'
    redirect_to new_session_path
  end

  def permitted_params
    params.require(:customer_request).permit(:status_id)
  end
end
