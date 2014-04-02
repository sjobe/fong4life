require 'spec_helper'

describe "emergencies/edit" do
  before(:each) do
    @emergency = assign(:emergency, stub_model(Emergency,
      :details => "MyString",
      :sms_message_text => "MyString"
    ))
  end

  it "renders the edit emergency form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", emergency_path(@emergency), "post" do
      assert_select "input#emergency_details[name=?]", "emergency[details]"
      assert_select "input#emergency_sms_message_text[name=?]", "emergency[sms_message_text]"
    end
  end
end
