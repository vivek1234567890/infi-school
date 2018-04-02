# infi-school

This application is basically school management system.
1) bundle install

2) run rake db:create 

3) run rake db:migrate

4) run rake db:seed

5) scheduke.rb have two cron schedules 
   
   5.1 create_attendance_records - for creating new monthly attendance records of students on 1st day of new month.

   5.2 get_defaulters - This mark students as defaulter for previous month on 1st day of new month.

6) Mark Attendance - Mark attendance for students on daily basis.

7) Generate Report- For tracking students as defaulter or not with whole days statuses for a month.





