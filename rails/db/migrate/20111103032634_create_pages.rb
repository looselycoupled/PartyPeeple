class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :identifier
      t.string :name
      t.string :category
      t.string :type

      t.timestamps
    end

    create_table :pages_people, :id => false  do |t|
      t.integer :person_id
      t.integer :page_id
    end
    
  end

  def self.down
    drop_table :pages
    drop_table :pages_people
  end
end
