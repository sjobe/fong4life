class DonorsController < ApplicationController
  before_action :set_donor, only: [:show, :edit, :update, :destroy]

  # GET /donors
  # GET /donors.json
  def index
    @donors = Donor.all
  end

  # GET /donors/1
  # GET /donors/1.json
  def show
  end

  # GET /donors/new
  def new
    @donor = Donor.new
  end

  # GET /donors/1/edit
  def edit
  end

  # POST /donors
  # POST /donors.json
  def create
    @donor = Donor.new(donor_params)
    donor_saved = @donor.save
    donation_saved = false

    if donor_saved && params[:event_id].present? && params[:event_type].present?
      event = BloodDrive.find(params[:event_id]) if params[:event_type] == 'blood_drive'
      event = Emergency.find(params[:event_id]) if params[:event_type] == 'emergency'
      if event
        donation = Donation.new
        donation.donor = @donor
        donation.eventable = event
        donation_saved = donation.save
      end
    end

    respond_to do |format|
      if donor_saved
        if donation_saved
          format.html { redirect_to event, notice: 'Donor was successfully added to your event.' }
        else
          format.html { redirect_to @donor, notice: 'Donor was successfully created' }
        end
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /donors/1
  # PATCH/PUT /donors/1.json
  def update
    respond_to do |format|
      if @donor.update(donor_params)
        format.html { redirect_to @donor, notice: 'Donor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @donor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /donors/1
  # DELETE /donors/1.json
  def destroy
    @donor.destroy
    respond_to do |format|
      format.html { redirect_to donors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donor
      @donor = Donor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donor_params
      params.require(:donor).permit(:first_name, :last_name, :date_of_birth, :sex, :address, :primary_phone_number, :secondary_phone_number, :blood_group, :email_address, :donor_card_id)
    end
end
