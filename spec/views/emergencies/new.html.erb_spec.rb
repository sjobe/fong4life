require 'spec_helper'

describe "emergencies/new" do
  before(:each) do
    assign(:emergency, stub_model(Emergency,
      :details => "MyString",
      :sms_message_text => "MyString"
    ).as_new_record)
  end

  it "renders new emergency form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", emergencies_path, "post" do
      assert_select "input#emergency_details[name=?]", "emergency[details]"
      assert_select "input#emergency_sms_message_text[name=?]", "emergency[sms_message_text]"
    end
  end
end
