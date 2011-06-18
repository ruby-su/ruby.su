class MakeIndexOnEmailNotUniq < ActiveRecord::Migration
  def self.up
    # Индекс по полю email уникальный. При регистрации 
    # через социальные сервисы, такие как Twitter у нас
    # нет email'а
    remove_index :users, :email
    add_index :users, :email
  end

  def self.down
  end
end
