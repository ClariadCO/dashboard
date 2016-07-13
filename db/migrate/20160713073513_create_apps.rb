class CreateApps < ActiveRecord::Migration[5.0]
  def change
    create_table :apps do |t|
      t.string :name
      t.string :description
      t.string :short_description
      t.string :uid
      t.string :app_store
      t.string :google_store

      t.timestamps
    end
  end
end
