class CreateUsStates < ActiveRecord::Migration
  def self.up
    create_table :us_states do |t|
      t.string :name    
      t.integer :flu_report_id
      t.integer :cases
      t.integer :confirmed
      t.integer :negative
      t.integer :suspected
      t.integer :fatal

      t.timestamps
    end
  end

  def self.down
    drop_table :us_states
  end
end
