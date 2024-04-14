# frozen_string_literal: true

class AddDefaultUser < ActiveRecord::Migration[7.1]
  def change
    if User.find_by(email: 'admin@example.com')
      nil
    else
      User.create!(email: 'admin@example.com', password: 'admin')
    end
  end
end
