# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :subject
      t.string :name
      t.string :email
      t.text :content
      t.integer :status_id, limit: 2

      t.timestamps
    end
  end
end
