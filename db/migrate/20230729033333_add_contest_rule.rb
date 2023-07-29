class AddContestRule < ActiveRecord::Migration[5.2]
  def change
    create_table :contest_rule do |t|
      t.string :description
      t.integer :order
      t.string :contest_id

      t.timestamps
    end
  end
end
