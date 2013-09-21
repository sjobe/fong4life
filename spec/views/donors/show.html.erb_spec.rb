require 'spec_helper'

describe "donors/show" do
  before(:each) do
    @donor = assign(:donor, stub_model(Donor,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/First Name/)
    rendered.should match(/Last Name/)
    rendered.should match(/Date Of Birth/)
    rendered.should match(/Sex/)
    rendered.should match(/Address/)
    rendered.should match(/Primary Phone Number/)
    rendered.should match(/Secondary Phone Number/)
    rendered.should match(/Blood Group/)
    rendered.should match(/Email Address/)
    rendered.should match(/Donor Card/)
  end
end
