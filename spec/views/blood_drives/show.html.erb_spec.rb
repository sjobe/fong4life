require 'spec_helper'

describe "blood_drives/show" do
  before(:each) do
    @blood_drive = assign(:blood_drive, stub_model(BloodDrive,
      :location => "Location",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Location/)
    rendered.should match(/Description/)
  end
end
