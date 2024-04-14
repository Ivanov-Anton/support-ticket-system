# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true
  validates :email, uniqueness: true
end
