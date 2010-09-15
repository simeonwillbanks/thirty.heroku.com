class AddTweetStatusId < ActiveRecord::Migration
  def self.up
    add_column :tweets, :status_id, :bigint
  end

  def self.down
    remove_column :tweets, :status_id
  end
end
