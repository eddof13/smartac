class SensorValidator < ActiveModel::Validator
    def validate(record)
        if ['needs_service', 'needs_new_filter', 'gas_leak'].include?(record.health_status)
            SensorNotification.with(message: "Device #{record.device.serial_number} reporting #{record.health_status}").deliver(User.all)
        end

        if record.co2_level > 9.0
            SensorNotification.with(message: "Device #{record.device.serial_number} reporting CO2 level over 9 PPM").deliver(User.all)
        end
    end
  end