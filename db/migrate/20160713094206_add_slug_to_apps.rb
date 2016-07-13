class AddSlugToApps < ActiveRecord::Migration[5.0]
  def change
    add_column :apps, :slug, :string
  end
end
