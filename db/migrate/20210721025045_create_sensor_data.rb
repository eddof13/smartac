class CreateSensorData < ActiveRecord::Migration[6.0]
  def change
    create_table :sensor_data do |t|

      t.timestamps
    end
  end
end
