class AddOrgIdToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :organization_id, :integer
  end
end
