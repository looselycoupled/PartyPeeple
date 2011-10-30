class AddsPreferenceToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :preference, :string
  end

  def self.down
    remove_column :people, :preference
  end
end
