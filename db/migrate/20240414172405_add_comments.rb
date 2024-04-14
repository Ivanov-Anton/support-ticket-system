# frozen_string_literal: true

class AddComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :email, null: false
      t.text :content, null: false
      t.references :ticket, foreign_key: true, null: false
      t.timestamps
    end
  end
end
