class AddAppTypeToApps < ActiveRecord::Migration[5.0]
  def change
    add_column :apps, :app_type, :string
  end
end
