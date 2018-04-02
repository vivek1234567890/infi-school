module StudentsHelper
	def defaulers(attendance_hash,student)
	  @highest_wf_words = []	
	  absent_count = attendance_hash.select {|k, v| v == "A"}.keys.each {|k| @highest_wf_words << [k]}.count
      present_count = attendance_hash.select {|k, v| v == "P"}.keys.each {|k| @highest_wf_words << [k]}.count
      weekoff_count = attendance_hash.select {|k, v| v == "W"}.keys.each {|k| @highest_wf_words << [k]}.count
      holiday_count = attendance_hash.select {|k, v| v == "H"}.keys.each {|k| @highest_wf_words << [k]}.count
      total_day = attendance_hash.count
      countable_days = total_day - ( weekoff_count + holiday_count )
      percentage_weight = ( present_count * 100 ) / ( countable_days )
      standard = student.standard
      percentage_weight >= standard.min_attendance_mark ? {defaulter: "No", weightage: percentage_weight} : {defaulter: "Yes", weightage: percentage_weight}  

	end	
end
