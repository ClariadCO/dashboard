class AddDownloadLinkToApps < ActiveRecord::Migration[5.0]
  def change
    add_column :apps, :download_link, :string
  end
end
