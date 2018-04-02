class AttendanceRecord < ActiveRecord::Base
	belongs_to :student
	serialize :attendance_hash, Hash
end
