require 'spec_helper'

describe "address pages" do
  
  before { visit new_merchant_registration_path }
  before do
        fill_in "merchant_name",         with: "Trail2"
        fill_in "merchant_email",        with: "trail2@example.com"
        fill_in "merchant_password",     with: "Password"
        fill_in "merchant_password_confirmation", with: "Password"
      end
  before { click_button '立即註冊' }
  
  subject { page }
  
  describe "address index page" do

    before { visit addresses_path }

    it { should have_css("body.addresses_index") }
    
    describe "New address page" do
      
      before { visit new_address_path }
      it { should have_css("body.addresses_new") }
      
      describe "with invalid information" do
        it "should not create a address" do
          expect { click_button '確認地址' }.not_to change(Address, :count)
        end
      end

      describe "with valid information" do
        before do
          fill_in "address_address",         with: "Example"
          fill_in "address_phone",        with: "Example"
          fill_in "address_locality",     with: "Random text"
          fill_in "address_province",     with: "Random text"
          fill_in "address_country",     with: "Random text"
          fill_in "address_lat",     with: 9.99
          fill_in "address_lng",     with: 9.99
        end

        it "should create a address" do
          expect { click_button '確認地址' }.to change(Address, :count).by(1)
        end
      end
    end
  end
end