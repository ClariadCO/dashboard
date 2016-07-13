class AddAttachmentBackgroundToApps < ActiveRecord::Migration
  def self.up
    change_table :apps do |t|
      t.attachment :background
    end
  end

  def self.down
    remove_attachment :apps, :background
  end
end
