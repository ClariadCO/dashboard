class AddStoreDataToApps < ActiveRecord::Migration[5.0]
  def change
    add_column :apps, :itunes_data, :string
    add_column :apps, :googlestore_data, :string
  end
end
