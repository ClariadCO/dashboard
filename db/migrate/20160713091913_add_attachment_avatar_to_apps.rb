class AddAttachmentAvatarToApps < ActiveRecord::Migration
  def self.up
    change_table :apps do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :apps, :avatar
  end
end
