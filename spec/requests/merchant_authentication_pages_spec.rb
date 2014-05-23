require 'spec_helper'

describe "merchant authentication" do

  subject { page }

  describe "signin page" do
    before { visit new_merchant_session_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_content('Sign in') }
    end

    describe "with valid information" do
      let(:merchant) { FactoryGirl.create(:merchant) }
      before do
        fill_in "merchant_email",    with: merchant.email.upcase
        fill_in "merchant_password", with: merchant.password
        click_button "Sign in"
      end

      it { should have_content(merchant.name) }
      it { should_not have_content("Home") }
      it { should have_link('Sign out',    href: destroy_merchant_session_path) }
      it { should_not have_link('Sign in', href: new_merchant_session_path) }
    end
  end
  
  describe "authorization" do

    describe "for non-signed-in merchants" do
      let(:merchant) { FactoryGirl.create(:merchant) }

      describe "in the merchants controller" do

        describe "visiting the edit page" do
          before { visit edit_merchant_registration_path }
          it { should have_content('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch merchant_registration_path(merchant) }
          specify { expect(response.code.should == "401") }
        end
      end
    end
  end
end