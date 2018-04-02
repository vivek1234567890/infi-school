class CreateAttendanceRecords < ActiveRecord::Migration
  def change
    create_table :attendance_records do |t|
      t.date :month_start_date
      t.integer :standard_id
      t.text :attendance_hash
      t.integer :student_id
      t.string :defaulter
      t.string :weightage

      t.timestamps null: false
    end
  end
end
