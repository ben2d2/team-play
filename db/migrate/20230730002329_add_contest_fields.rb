class AddContestFields < ActiveRecord::Migration[5.2]
  def change
    add_column :contests, :no_of_practice_attempts, :integer
    add_column :contests, :no_of_contest_attempts, :integer
    add_column :contests, :max_points_per_attempt, :integer
  end
end
