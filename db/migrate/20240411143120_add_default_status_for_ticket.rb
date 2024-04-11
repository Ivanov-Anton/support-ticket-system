# frozen_string_literal: true

class AddDefaultStatusForTicket < ActiveRecord::Migration[7.1]
  def change
    change_column_default :tickets, :status_id, from: nil, to: 1
  end
end
