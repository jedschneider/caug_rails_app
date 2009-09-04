class CreateFluReports < ActiveRecord::Migration
  def self.up
    create_table :flu_reports do |t|
      t.date :report_date
      t.integer :confirmed
      t.integer :total_cases
      t.integer :suspected
      t.integer :fatal
      t.timestamps
    end
  end

  def self.down
    drop_table :flu_reports
  end
end
