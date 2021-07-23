class SensorValidator < ActiveModel::Validator
    def validate(record)
        if ['needs_service', 'needs_new_filter', 'gas_leak'].include?(record.health_status)
            SensorNotification.with(message: "Device #{record.device.serial_number} reporting #{record.health_status}").deliver(User.all)
        end

        if record.co_level > 9.0
            SensorNotification.with(message: "Device #{record.device.serial_number} reporting Carbon Monoxide level over 9 PPM").deliver(User.all)
        end
    end
  end

class SensorDatum < ApplicationRecord
    belongs_to :device

    validates_with SensorValidator
end
