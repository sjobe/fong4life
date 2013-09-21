require 'spec_helper'

describe "blood_drives/index" do
  before(:each) do
    assign(:blood_drives, [
      stub_model(BloodDrive,
        :location => "Location",
        :description => "Description"
      ),
      stub_model(BloodDrive,
        :location => "Location",
        :description => "Description"
      )
    ])
  end

  it "renders a list of blood_drives" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
