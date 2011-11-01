class AddIndexToPeople < ActiveRecord::Migration
  def self.up
    add_index :people, :identifier, :name => 'people_identifier_index'
  end

  def self.down
    remove_index :people, :name => 'people_identifier_index'
  end
end
