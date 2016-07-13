class AddFeaturedToApps < ActiveRecord::Migration[5.0]
  def change
    add_column :apps, :featured, :boolean, default: false
  end
end
