# frozen_string_literal: true

# == Schema Information
#
# Table name: tickets
#
#  id         :bigint           not null, primary key
#  content    :text
#  email      :string
#  name       :string
#  subject    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status_id  :integer
#
class Ticket < ActiveRecord::Base
end
