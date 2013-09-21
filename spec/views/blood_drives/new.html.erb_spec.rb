require 'spec_helper'

describe "blood_drives/new" do
  before(:each) do
    assign(:blood_drive, stub_model(BloodDrive,
      :location => "MyString",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new blood_drive form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", blood_drives_path, "post" do
      assert_select "input#blood_drive_location[name=?]", "blood_drive[location]"
      assert_select "input#blood_drive_description[name=?]", "blood_drive[description]"
    end
  end
end
