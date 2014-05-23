require 'spec_helper'

describe "User authentication" do

  subject { page }

  describe "signin page" do
    before { visit new_user_session_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_content('Sign in') }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "user_email",    with: user.email.upcase
        fill_in "user_password", with: user.password
        click_button "Sign in"
      end

      it { should have_content(user.name) }
      it { should_not have_content("Home") }
      it { should have_link('Sign out',    href: destroy_user_session_path) }
      it { should_not have_link('Sign in', href: new_user_session_path) }
    end
  end
  
  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_registration_path }
          it { should have_content('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch user_registration_path(user) }
          specify { expect(response.code.should == "401") }
        end
      end
    end
  end
end