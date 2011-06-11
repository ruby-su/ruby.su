class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end

    create_table :roles_users, :id => false do |t|
      t.integer :role_id
      t.integer :user_id
    end

    add_index :roles_users, :user_id
  end

  def self.down
    drop_table :roles
  end
end
