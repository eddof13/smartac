class AddFirmwareVersionToDevice < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :firmware_version, :string
  end
end
