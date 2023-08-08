class RenameColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :event_rounds, :type, :round_type
  end
end
