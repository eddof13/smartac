class AddHumidityPercentageToSensorData < ActiveRecord::Migration[6.0]
  def change
    add_column :sensor_data, :humidity_percentage, :float
  end
end
