class AddOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organization do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :image_url

      t.timestamps
    end

    create_table :user_organization do |t|
      t.string :user_id
      t.string :organization_id
      t.boolean :is_admin

      t.timestamps
    end
  end
end
