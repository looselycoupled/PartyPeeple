class AddsPoliticalReligionToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :political, :string
    add_column :people, :religion, :string
  end

  def self.down
    remove_column :people, :political
    remove_column :people, :religion
  end
end
