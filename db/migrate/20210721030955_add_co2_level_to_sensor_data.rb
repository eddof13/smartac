class AddCo2LevelToSensorData < ActiveRecord::Migration[6.0]
  def change
    add_column :sensor_data, :co2_level, :float
  end
end
