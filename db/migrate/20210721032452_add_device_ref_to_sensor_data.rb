class AddDeviceRefToSensorData < ActiveRecord::Migration[6.0]
  def change
    add_reference :sensor_data, :device, null: false, foreign_key: true
  end
end
