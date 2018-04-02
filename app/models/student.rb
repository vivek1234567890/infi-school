class Student < ActiveRecord::Base
  belongs_to :school
  belongs_to :standard
  has_many :attendance_records
  validates_length_of :name, :within => 1..20
  validates_presence_of :name
end
