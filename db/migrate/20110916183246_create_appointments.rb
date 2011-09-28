class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      
      t.integer    :user_id
      t.text       :notes
      t.string     :status
      t.references :event

      t.timestamps
    end
  end
end
