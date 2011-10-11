class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      
      # these attributes should match those in jquery-fullcalendar
      # or the events will not show up
      t.string      :title
      t.datetime    :start
      t.datetime    :end
      t.boolean     :allDay, :default => false
      
      # these are extra event attributes
      t.string      :event_type
      t.integer     :participant_max, :default => 1
      t.references  :user # user that created this event

      t.timestamps
    end
  end
end
