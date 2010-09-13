class LoadAdminUserData < ActiveRecord::Migration
  def self.up
    User.create(:name => 'admin', :password => 's3c3rt', 
                :password_confirmation => 's3c3rt', :is_admin => true,
                :email => '30sumptin@gmail.com')
  end

  def self.down
    u = User.find_by_name('admin')
    u.destroy
  end
end
