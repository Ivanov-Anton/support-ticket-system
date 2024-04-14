# frozen_string_literal: true

class AdminCommentsController < ApplicationController # :nodoc:
  def create
    @comment = Comment.new(permitted_params)

    if @comment.save
      flash[:notice] = 'Your successfully created comment!'
    else
      flash[:error] = @comment.errors.full_messages.to_sentence
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy!
    redirect_to admin_customer_request_path(@comment.ticket)
  end

  private

  def permitted_params
    params.require(:comment).permit(:content, :email, :ticket_id)
  end
end
