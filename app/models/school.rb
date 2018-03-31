class School < ActiveRecord::Base
  
  has_many :standards, dependent: :destroy
  has_many :students, dependent: :destroy  
  
  validates_length_of :name, :within => 1..20
  validates_uniqueness_of :name, :message => "already exists"
  validates_presence_of :name

  def create_attendance_records
  	today_date = Date.today
  	if today_date.at_beginning_of_month == today_date
  	  first_date = Date.today.at_beginning_of_month
	  last_date = Date.today.at_beginning_of_month.end_of_month
	  array_of_date = (first_date..last_date)	
	  attendance_hash = {}
      array_of_date.map{|s| attendance_hash[s] = ""}
  	  School.find_each(batch_size: 10) do |school|
  	  	students = get_all_students(school)
  	  	students.find_each(batch_size: 10) do |student|
  	  	  attendance_records = student.attendance_records.new(month_start_date: today_date, standard_id: student.standard_id, attendance_hash: attendance_hash)
  	  	  attendance_records.save(:validate=>false)
  	  	end
  	  end  	
  	end
  end

  def self.get_defaulters
  	today_date = Date.today
  	if today_date.at_beginning_of_month == today_date
  	  last_month_date = today_date.last_month.at_beginning_of_month
	  School.find_each(batch_size: 10) do |school|
	  	next if school.students.empty?
	  	next if school.standards.empty?
	  	students = get_all_students(school)
	  	students.find_each(batch_size: 10) do |student|
	  	  last_month_att_record = student.attendance_records.where(date: last_month_date)
	  	  next if last_month_att_record.empty?

	  	end
	  end
  	end
  end

  def get_all_students(school)
  	school.students
  end

end
