class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :set_school, only: [:new, :edit, :show,:create,:update,:destroy,:mark_attendance,:generate_report]
  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = @school.students.build
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = @school.students.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to manage_school_school_path(@school), notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to manage_school_school_path(@school), notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def mark_attendance
    date = params[:date]
    attendance_hash = { "Present"=>"P", "Absent"=>"A", "Weekoff"=>"W", "Holiday"=>"H" }
    @student = @school.students.find(params[:student_id])
    @standard = @school.standards.find(params[:standard_id])
    @attendance_record = @student.attendance_records.where(month_start_date: params[:date].to_date.at_beginning_of_month).last

    if @attendance_record
      @attendance_record.attendance_hash["#{date.to_date}"] = attendance_hash["#{params[:status]}"]
      @attendance_record.save
    else
      first_date = date.to_date.at_beginning_of_month
      last_date = date.to_date.at_beginning_of_month.end_of_month
      array_of_date = (first_date..last_date) 
      attendance_hash = {}
      array_of_date.map{|s| attendance_hash[s.to_s] = ""}
      @attendance_record = @student.attendance_records.new(month_start_date: date.to_date.at_beginning_of_month, standard_id: @student.standard_id, attendance_hash: attendance_hash)
      @attendance_record.save(:validate=>false)
      if @attendance_record
        @attendance_record.attendance_hash["#{date.to_date}"] = attendance_hash["#{params[:status]}"]
        @attendance_record.save
      end
    end
    redirect_to manage_school_school_path(@school), notice: 'Attendance has marked.'
  end

  def generate_report
    @attendance_hash = { "P"=>"Present", "A"=>"Absent", "W"=>"Weekoff", "H"=>"Holiday" }
    @student = @school.students.find(params[:student_id])
    @standard = @school.standards.find(params[:standard_id])
    month = params[:from_month]
    year = params[:from_year]
    get_date = "1-#{month}-#{year}".to_date
    @attendance_record = @student.attendance_records.where(month_start_date: get_date).last
    @attendance_record.present? ? (@is_attendance_record = true) : (@is_attendance_record = false) 
    respond_to do |format|
      format.js
    end
  end

  def process_report_params
    @students = []
    if params[:type].present?
      @standard = Standard.find(params[:type])
      @students = @standard.students
    end  
    respond_to do |format|
      format.html
      format.json { render :json => { :type_data => @students } }
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to manage_school_school_path(@school), notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    def set_school
      @school = School.find(params[:school_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :standard_id, :school_id)
    end
end
