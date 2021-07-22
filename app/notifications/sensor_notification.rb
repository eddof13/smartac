class SensorNotification < Noticed::Base
  deliver_by :database

  param :message
end
