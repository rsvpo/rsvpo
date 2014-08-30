require 'spec_helper'

describe "Merchant pages" do

  subject { page }

  describe "merchant signup page" do
    before { visit new_merchant_registration_path }

    it { should have_content('註冊') }
  end
  
  describe "merchant signup" do

    before { visit new_merchant_registration_path }

    describe "with invalid information" do
      it "should not create a merchant" do
        expect { click_button '立即註冊' }.not_to change(Merchant, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "merchant_name",         with: "Example Merchant"
        fill_in "merchant_email",        with: "merchant@example.com"
        fill_in "merchant_password",     with: "Password"
        fill_in "merchant_password_confirmation", with: "Password"
      end

      it "should create a merchant" do
        expect { click_button '立即註冊' }.to change(Merchant, :count).by(1)
      end

    end
  end
end