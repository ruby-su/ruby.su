class AddUidAndProviderToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :uid, :string
    add_column :users, :provider, :string

    add_index :users, [ :uid, :provider ]
  end

  def self.down
    remove_column :users, :provider
    remove_column :users, :uid
  end
end
