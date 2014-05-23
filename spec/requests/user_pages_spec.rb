require 'spec_helper'

describe "Home page" do

  it "should have the content 'Sample App'" do
    visit root_path
    expect(page).to have_content('Home')
  end

  it "should have the base title" do
    visit root_path
    expect(page).to have_title("Rsvp")
  end
end

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit new_user_registration_path }

    it { should have_content('Sign up') }
  end
  
  describe "signup" do

    before { visit new_user_registration_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button 'Sign up' }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "user_name",         with: "Example User"
        fill_in "user_email",        with: "user@example.com"
        fill_in "user_password",     with: "Password"
        fill_in "user_password_confirmation", with: "Password"
      end

      it "should create a user" do
        expect { click_button 'Sign up' }.to change(User, :count).by(1)
      end
    end
  end
end