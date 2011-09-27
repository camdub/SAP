class AddEventIdToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :event_id, :integer
  end
end
