class RenameUserOrganizations < ActiveRecord::Migration[5.2]
  def change
    rename_table :user_organization, :user_organizations
  end
end
