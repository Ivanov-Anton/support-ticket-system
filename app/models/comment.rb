# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id         :bigint(8)        not null, primary key
#  content    :text             not null
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ticket_id  :bigint(8)        not null
#
# Indexes
#
#  index_comments_on_ticket_id  (ticket_id)
#
# Foreign Keys
#
#  fk_rails_...  (ticket_id => tickets.id)
#
class Comment < ActiveRecord::Base
  belongs_to :ticket

  module CONST # :nodoc:
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    freeze
  end

  validates :content, :email, :ticket, presence: true
  validates :email, format: { with: CONST::VALID_EMAIL_REGEX, allow_blank: true }
end
