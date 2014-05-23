require 'spec_helper'

describe Merchant do

  let(:merchant) { FactoryGirl.create(:merchant) }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:activities) }
  
  describe "activity associations" do
    
    before do
      @merchant = Merchant.new(name: "Example User", email: "user@example.com",
        password: "Password", password_confirmation: "Password")
    end

    before { @merchant.save }
    let!(:older_activity) do
      FactoryGirl.create(:activity, merchant: @merchant, created_at: 1.day.ago)
    end
    let!(:newer_activity) do
      FactoryGirl.create(:activity, merchant: @merchant, created_at: 1.hour.ago)
    end

    it "should have the right activities in the right order" do
      expect(@merchant.activities.to_a).to eq [newer_activity, older_activity]
    end
  end
end