class Student < ActiveRecord::Base
  belongs_to :school
  has_one :standard
  validates_length_of :name, :within => 1..20
  validates_presence_of :name
end
