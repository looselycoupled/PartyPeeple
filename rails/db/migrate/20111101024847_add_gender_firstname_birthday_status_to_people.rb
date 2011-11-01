class AddGenderFirstnameBirthdayStatusToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :first_name, :string
    add_column :people, :gender, :string
    add_column :people, :birthday, :string
    add_column :people, :relationship_status, :string
  end

  def self.down
    remove_column :people, :first_name
    remove_column :people, :gender
    remove_column :people, :birthday
    remove_column :people, :relationship_status
  end
end
