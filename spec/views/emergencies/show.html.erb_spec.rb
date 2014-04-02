require 'spec_helper'

describe "emergencies/show" do
  before(:each) do
    @emergency = assign(:emergency, stub_model(Emergency,
      :details => "Details",
      :sms_message_text => "Sms Message Text"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Details/)
    rendered.should match(/Sms Message Text/)
  end
end
