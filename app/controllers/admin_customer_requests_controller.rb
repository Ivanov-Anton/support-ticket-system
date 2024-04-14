# frozen_string_literal: true

class AdminCustomerRequestsController < ApplicationController # :nodoc:
  before_action :authenticate!
  before_action :init_ticket_instance, only: %i[show destroy update]

  def index
    @tickets = Ticket.all
  end

  def show; end

  def destroy
    @ticket.destroy!

    flash[:notice] = 'Customer request was successfully destroyed.'
    redirect_to admin_path
  end

  # PATCH /admin_customer_requests/1
  def update
    if @ticket.update(permitted_params)
      redirect_to admin_customer_request_path(@ticket), notice: 'Customer request was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def authenticate!
    User.find_by!(email: cookies.encrypted[:current_user])
  rescue ActiveRecord::RecordNotFound => _e
    flash[:error] = 'Access denied!'
    redirect_to new_session_path
  end

  def permitted_params
    params.require(:customer_request).permit(:status_id)
  end

  # Use callbacks to share common setup between actions.
  def init_ticket_instance
    @ticket = Ticket.find(params[:id])
  end
end
