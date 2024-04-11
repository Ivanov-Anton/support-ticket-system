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
#  status_id  :integer(2)
#
class Ticket < ActiveRecord::Base
end
