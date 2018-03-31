class CreateStandards < ActiveRecord::Migration
  def change
    create_table :standards do |t|
      t.integer :school_id
      t.string :class_name
      t.float :min_attendance_mark

      t.timestamps null: false
    end
  end
end
