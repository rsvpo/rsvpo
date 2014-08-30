require 'spec_helper'

describe "Activity" do
  let(:booking) { FactoryGirl.create(:booking) }
  let(:slot) { booking.slot }
  let(:activity) { slot.activity }
  let(:merchant) { activity.merchant }

  before do
    visit new_merchant_session_path
    fill_in "merchant_email",    with: merchant.email.upcase
    fill_in "merchant_password", with: merchant.password
    click_button "立即登入"
  end

  describe "New activity page" do
    subject { page }
    before { visit new_activity_path }
    
    it { should have_content('飲食') }
    it { should have_content('Address') }
    
    it { should have_css('body.activities_new') }
    
    describe "New activity" do
      before do
        fill_in "activity_title",    with: "New activity"
        select('飲食', :from => 'activity_category_id')
        check('Address')
        fill_in "activity_about", with: "Whatever this is I really dont care"
        fill_in "activity_price", with: 10
        fill_in "activity_bookmsg", with: "Whatever this is I really dont care"
        fill_in "activity_duration", with: 1
        click_button "確認活動"
      end
      
      it { should_not have_content('加入活動') }
      it { should have_content("New activity") }
      
      describe "Edit activity" do
        subject { page }
        before { visit edit_activity_path(activity) }
        
        before do
          fill_in "activity_title",    with: "Edited activity"
          select('飲食', :from => 'activity_category_id')
          check('Address')
          fill_in "activity_about", with: "Whatever this is I really dont care"
          fill_in "activity_price", with: 10
          fill_in "activity_bookmsg", with: "Whatever this is I really dont care"
          fill_in "activity_duration", with: 1
          click_button "確認活動"
        end
        
        it { should have_css("body.myactivities_index") }
        
      end
      
      describe "Rule page" do
        before { visit generate_rule_path(merchant.activities.first.id) }
        it { should have_css('body.rules_new') }
        it { should have_content('Address') }
        it { should have_content("加入時段到New activity") }
        
        describe "New Rule" do
          before do
            fill_in "rule_description",    with: "A random rules desciption"
            select('Address', :from => 'rule_address_id')
            fill_in "rule_from_date", with: "2014-05-10"
            fill_in "rule_to_date", with: "2014-05-10"
            fill_in "rule_from_time", with: "12:00 AM"
            fill_in "rule_to_time", with: "12:30 AM"
            fill_in "rule_inventory", with: "10"
            click_button "確認時段"
          end
          it { should_not have_css('body.rules_new') }
        end
      end
    end
  end
end