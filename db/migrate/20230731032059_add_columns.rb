class AddColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :contests, :organization_id, :integer

    add_column :events, :schedule_complete, :boolean
  end
end
