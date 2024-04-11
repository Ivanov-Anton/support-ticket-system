# frozen_string_literal: true

##
# The main decorator fot Ticket model
class TicketDecorator < ApplicationDecorator
  def status_name
    Ticket::CONST::STATUSES.fetch(model.status_id)
  end
end
