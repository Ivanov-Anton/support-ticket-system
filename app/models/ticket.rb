# frozen_string_literal: true

# == Schema Information
#
# Table name: tickets
#
#  id         :bigint(8)        not null, primary key
#  content    :text
#  email      :string
#  name       :string
#  subject    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status_id  :integer(2)       default(1)
#
class Ticket < ActiveRecord::Base
  module CONST # :nodoc:
    NEW_STATUS_ID = 1
    NEW_PENDING_ID = 2
    NEW_RESOLVED_ID = 3

    NEW_STATUS_NAME = 'NEW'
    NEW_PENDING_NAME = 'PENDING'
    NEW_RESOLVED_NAME = 'RESOLVED'

    STATUS_IDS = [
      NEW_STATUS_ID,
      NEW_PENDING_ID,
      NEW_RESOLVED_ID
    ].freeze

    STATUSES = {
      NEW_STATUS_ID => NEW_STATUS_NAME,
      NEW_PENDING_ID => NEW_PENDING_NAME,
      NEW_RESOLVED_ID => NEW_RESOLVED_NAME
    }.freeze

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    freeze
  end

  has_many :comments, dependent: :destroy
  validates :name, :email, :subject, presence: true
  validates :status_id, inclusion: { in: Ticket::CONST::STATUS_IDS }
  validates :email, format: { with: CONST::VALID_EMAIL_REGEX, allow_blank: true }
end
