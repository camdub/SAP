class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      
      t.string      :name
      t.string      :event_type
      t.datetime    :start_datetime
      t.datetime    :end_datetime
      t.integer     :participant_max, :default => 1
      t.references  :user # user that created this event
      t.references  :appointment, :default => nil

      t.timestamps
    end
  end
end
