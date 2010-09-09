class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.string :text, :limit => 140, :null => false
      t.boolean :published, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
