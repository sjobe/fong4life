require 'spec_helper'

describe "donors/index" do
  before(:each) do
    assign(:donors, [
      stub_model(Donor,
        :first_name => "First Name",
        :last_name => "Last Name",
        :date_of_birth => "Date Of Birth",
        :sex => "Sex",
        :address => "Address",
        :primary_phone_number => "Primary Phone Number",
        :secondary_phone_number => "Secondary Phone Number",
        :blood_group => "Blood Group",
        :email_address => "Email Address",
        :donor_card_id => "Donor Card"
      ),
      stub_model(Donor,
        :first_name => "First Name",
        :last_name => "Last Name",
        :date_of_birth => "Date Of Birth",
        :sex => "Sex",
        :address => "Address",
        :primary_phone_number => "Primary Phone Number",
        :secondary_phone_number => "Secondary Phone Number",
        :blood_group => "Blood Group",
        :email_address => "Email Address",
        :donor_card_id => "Donor Card"
      )
    ])
  end

  it "renders a list of donors" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Date Of Birth".to_s, :count => 2
    assert_select "tr>td", :text => "Sex".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Primary Phone Number".to_s, :count => 2
    assert_select "tr>td", :text => "Secondary Phone Number".to_s, :count => 2
    assert_select "tr>td", :text => "Blood Group".to_s, :count => 2
    assert_select "tr>td", :text => "Email Address".to_s, :count => 2
    assert_select "tr>td", :text => "Donor Card".to_s, :count => 2
  end
end
