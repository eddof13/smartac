class AddCollectionDateToSensorData < ActiveRecord::Migration[6.0]
  def change
    add_column :sensor_data, :collection_date, :datetime
  end
end
