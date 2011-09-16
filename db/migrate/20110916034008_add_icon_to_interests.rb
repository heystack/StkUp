class AddIconToInterests < ActiveRecord::Migration
  def self.up
    add_column :interests, :icon, :string
  end

  def self.down
    remove_column :interests, :icon
  end
end
