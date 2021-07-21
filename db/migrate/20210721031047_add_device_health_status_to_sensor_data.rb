class AddDeviceHealthStatusToSensorData < ActiveRecord::Migration[6.0]
  def change
    add_column :sensor_data, :health_status, :string, :limit => 150
  end
end
