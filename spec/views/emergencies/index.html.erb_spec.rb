require 'spec_helper'

describe "emergencies/index" do
  before(:each) do
    assign(:emergencies, [
      stub_model(Emergency,
        :details => "Details",
        :sms_message_text => "Sms Message Text"
      ),
      stub_model(Emergency,
        :details => "Details",
        :sms_message_text => "Sms Message Text"
      )
    ])
  end

  it "renders a list of emergencies" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Details".to_s, :count => 2
    assert_select "tr>td", :text => "Sms Message Text".to_s, :count => 2
  end
end
