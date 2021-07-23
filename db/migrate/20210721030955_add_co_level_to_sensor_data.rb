class AddCoLevelToSensorData < ActiveRecord::Migration[6.0]
  def change
    add_column :sensor_data, :co_level, :float
  end
end
