class BloodDrivesController < ApplicationController
  before_action :set_blood_drive, only: [:show, :edit, :update, :destroy]

  # GET /blood_drives
  # GET /blood_drives.json
  def index
    @blood_drives = BloodDrive.all
  end

  # GET /blood_drives/1
  # GET /blood_drives/1.json
  def show
    @donor = Donor.new
  end

  # GET /blood_drives/new
  def new
    @blood_drive = BloodDrive.new
  end

  # GET /blood_drives/1/edit
  def edit
  end

  # POST /blood_drives
  # POST /blood_drives.json
  def create
    @blood_drive = BloodDrive.new(blood_drive_params)

    respond_to do |format|
      if @blood_drive.save
        format.html { redirect_to @blood_drive, notice: 'Blood drive was successfully created.' }
        format.json { render action: 'show', status: :created, location: @blood_drive }
      else
        format.html { render action: 'new' }
        format.json { render json: @blood_drive.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blood_drives/1
  # PATCH/PUT /blood_drives/1.json
  def update
    respond_to do |format|
      if @blood_drive.update(blood_drive_params)
        format.html { redirect_to @blood_drive, notice: 'Blood drive was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @blood_drive.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blood_drives/1
  # DELETE /blood_drives/1.json
  def destroy
    @blood_drive.destroy
    respond_to do |format|
      format.html { redirect_to blood_drives_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blood_drive
      @blood_drive = BloodDrive.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blood_drive_params
      params.require(:blood_drive).permit(:location, :date, :description)
    end
end
