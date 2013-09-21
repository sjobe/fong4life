require 'spec_helper'

describe "donors/new" do
  before(:each) do
    assign(:donor, stub_model(Donor,
      :first_name => "MyString",
      :last_name => "MyString",
      :date_of_birth => "MyString",
      :sex => "MyString",
      :address => "MyString",
      :primary_phone_number => "MyString",
      :secondary_phone_number => "MyString",
      :blood_group => "MyString",
      :email_address => "MyString",
      :donor_card_id => "MyString"
    ).as_new_record)
  end

  it "renders new donor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", donors_path, "post" do
      assert_select "input#donor_first_name[name=?]", "donor[first_name]"
      assert_select "input#donor_last_name[name=?]", "donor[last_name]"
      assert_select "input#donor_date_of_birth[name=?]", "donor[date_of_birth]"
      assert_select "input#donor_sex[name=?]", "donor[sex]"
      assert_select "input#donor_address[name=?]", "donor[address]"
      assert_select "input#donor_primary_phone_number[name=?]", "donor[primary_phone_number]"
      assert_select "input#donor_secondary_phone_number[name=?]", "donor[secondary_phone_number]"
      assert_select "input#donor_blood_group[name=?]", "donor[blood_group]"
      assert_select "input#donor_email_address[name=?]", "donor[email_address]"
      assert_select "input#donor_donor_card_id[name=?]", "donor[donor_card_id]"
    end
  end
end
