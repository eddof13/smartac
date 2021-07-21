class AddSerialNumberToDevice < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :serial_number, :string
  end
end
