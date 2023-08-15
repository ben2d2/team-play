class AddContestTypeToContest < ActiveRecord::Migration[5.2]
  def change
    add_column :contests, :contest_type, :string
  end
end
