class AddDigitalCapitalToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :digital_capital, :integer
  end

  def self.down
    remove_column :people, :digital_capital
  end
end
