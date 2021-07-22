class User < ApplicationRecord
  include Clearance::User

  has_many :notifications, as: :recipient
end
