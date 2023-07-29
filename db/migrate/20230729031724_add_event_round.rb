class AddEventRound < ActiveRecord::Migration[5.2]
  def change
    create_table :event_round do |t|
      t.string :event_id
      t.string :type
      t.integer :order

      t.timestamps
    end
  end
end
