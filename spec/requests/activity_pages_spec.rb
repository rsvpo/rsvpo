require 'spec_helper'

describe "Activity" do
  
  subject { page }
  before { visit new_merchant_session_path }

  let(:merchant) { FactoryGirl.create(:merchant) }
      before do
        fill_in "merchant_email",    with: merchant.email.upcase
        fill_in "merchant_password", with: merchant.password
        click_button "Sign in"
      end
  
  it { should have_content("ABC Limited") }
  
  describe "New activity page" do
    before { visit new_activity_path }
    
    it { should have_content('Title') }
    it { should have_content('About') }
    it { should have_content('Bookmsg') }
    it { should have_content('Price') }
    it { should have_content('Duration') }
    
    describe "New activity" do
      before do
        fill_in "activity_title",    with: "New activity"
        fill_in "activity_about", with: "Whatever this is I really dont care"
        fill_in "activity_price", with: 10
        fill_in "activity_bookmsg", with: "Whatever this is I really dont care"
        fill_in "activity_duration", with: 1
        click_button "submit"
      end
      
      it { should_not have_content('New activity') }
      
      describe "Rule page" do
        before { visit new_rule_path }
        it { should have_css('body.rules_new') }
        
        describe "New Rule" do
          before do
            fill_in "rule_description",    with: "A random rules desciption"
            fill_in "rule_from_date", with: "2014-05-10"
            fill_in "rule_to_date", with: "2014-05-10"
            fill_in "rule_from_time", with: "12:00 AM"
            fill_in "rule_to_time", with: "12:30 AM"
            click_button "Save"
          end
          it { should_not have_css('body.rules_new') }
        end
      end
    end
  end
end