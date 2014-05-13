require 'spec_helper'

describe 'Emergency' do
  
  before(:each) do
    @emergency = Factory.build(:emergency)
  end
  
  describe "#contact_matches" do
    context "when it works properly" do
      it "should do call donor#contact" do
        @donor.should_receive(:contact)
      end
    end
  end
end