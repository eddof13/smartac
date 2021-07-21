class AddSharedSecretToDevice < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :shared_secret, :string
  end
end
