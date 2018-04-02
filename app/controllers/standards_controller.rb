class StandardsController < ApplicationController
  before_action :set_standard, only: [:show, :edit, :update, :destroy]
  before_action :set_school, only: [:new, :edit, :show,:create,:update,:destroy]

  # GET /standards
  # GET /standards.json
  def index
    @standards = Standard.all
  end

  # GET /standards/1
  # GET /standards/1.json
  def show
  end

  # GET /standards/new
  def new
    @standard = @school.standards.build
  end

  # GET /standards/1/edit
  def edit
  end

  # POST /standards
  # POST /standards.json
  def create
    @standard = @school.standards.new(standard_params)

    respond_to do |format|
      if @standard.save
        format.html { redirect_to manage_school_school_path(@school), notice: 'Standard was successfully created.' }
        format.json { render :show, status: :created, location: @standard }
      else
        format.html { render :new }
        format.json { render json: @standard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /standards/1
  # PATCH/PUT /standards/1.json
  def update
    respond_to do |format|
      if @standard.update(standard_params)
        format.html { redirect_to manage_school_school_path(@school), notice: 'Standard was successfully updated.' }
        format.json { render :show, status: :ok, location: @standard }
      else
        format.html { render :edit }
        format.json { render json: @standard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /standards/1
  # DELETE /standards/1.json
  def destroy
    @standard.destroy
    respond_to do |format|
      format.html { redirect_to manage_school_school_path(@school), notice: 'Standard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_standard
      @standard = Standard.find(params[:id])
    end

    def set_school
      @school = School.find(params[:school_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def standard_params
      params.require(:standard).permit(:school_id, :class_name, :min_attendance_mark,:school_id)
    end
end
