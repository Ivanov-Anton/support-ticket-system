# frozen_string_literal: true

class SessionsController < ApplicationController # :nodoc:
  def new
    if User.find_by(id: cookies.encrypted[:current_user])
      flash[:notice] = 'Session already created!'
      redirect_to admin_path
    end

    @session = User.new
  end

  def create
    @session = User.find_or_initialize_by(email: session_params.fetch(:email))

    if @session&.authenticate(session_params.fetch(:password))
      setup_cookies
      redirect_to admin_path, notice: 'Session was successfully created.'
    else
      @session.errors.add(:base, 'invalid email or password')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @session = User.new

    cookies.delete :current_user
    flash.now[:notice] = 'Current user have been successfully logged out'
    render :new, status: :ok
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end

  def setup_cookies
    cookies.encrypted[:current_user] = {
      value: @session.id,
      expires: 1.hour,
      secure: true,
      httponly: true,
      same_site: :strict
    }
  end
end
