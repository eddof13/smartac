class AddTemperatureToSensorData < ActiveRecord::Migration[6.0]
  def change
    add_column :sensor_data, :temperature, :float
  end
end
