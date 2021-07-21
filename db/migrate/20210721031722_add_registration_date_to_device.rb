class AddRegistrationDateToDevice < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :registration_date, :datetime
  end
end
