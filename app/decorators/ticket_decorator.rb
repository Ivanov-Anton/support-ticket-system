# frozen_string_literal: true

##
# The main decorator fot Ticket model
class TicketDecorator < ApplicationDecorator
  def status_name
    Ticket::CONST::STATUSES.fetch(model.status_id)
  end

  def next_status_id
    case model.status_id
    when Ticket::CONST::NEW_STATUS_ID
      Ticket::CONST::NEW_PENDING_ID
    when Ticket::CONST::NEW_PENDING_ID
      Ticket::CONST::NEW_RESOLVED_ID
    when Ticket::CONST::NEW_RESOLVED_ID
      Ticket::CONST::NEW_STATUS_ID
    end
  end

  def next_status_name
    case model.status_id
    when Ticket::CONST::NEW_STATUS_ID
      Ticket::CONST::NEW_PENDING_NAME
    when Ticket::CONST::NEW_PENDING_ID
      Ticket::CONST::NEW_RESOLVED_NAME
    when Ticket::CONST::NEW_RESOLVED_ID
      Ticket::CONST::NEW_STATUS_NAME
    end
  end
end
