require 'spec_helper'

describe "Interaction pages" do
  
  subject { page }

  let(:booking) { FactoryGirl.create(:booking) }
  let(:slot) { booking.slot }
  let(:user) { booking.user }
  let(:activity) { slot.activity }
  let(:merchant) { activity.merchant }

  before do
    visit new_user_session_path
    fill_in "user_email",    with: user.email.upcase
    fill_in "user_password", with: user.password
    click_button "立即登入"
  end
  
  it { should have_css('body.search_index') }
  it { should have_css('.thumbs') }
  
  describe "it should have booked activity page" do
    before { visit upcoming_path }
    it { should have_css('div.calendar-wrapper') }
  end
  
  describe "it can visit booked activity" do
    before { visit activity_path(activity) }
    it { should have_css('body.activities_show') }
    it { should have_content(activity.title) }
  end
  
  describe "it can visit merchant" do
    before { visit merchant_path(merchant) }
    it { should have_css('body.merchants_show') }
    it { should have_content(merchant.name) }
  end
  
  describe "it should have liked activity page" do
    before { visit favourite_path }
    it { should have_css('body.favourite_index') }
  end
  
  describe "it should have following merchant page" do
    before { visit following_path }
    it { should have_css('body.following_index') }
  end
  
  describe "it should have inbox page" do
    before { visit inbox_path }
    it { should have_css('body.inbox_index') }
  end
  
  describe "it should have new booking page when there is inventory" do
    before { visit new_booking_path(slot: slot.id) }
    it { should have_css('body.bookings_new') }
    it { should have_content(merchant.name) }
    
    describe "book with valid information" do
      it "should create a booking" do
        expect { click_button '立即RSVP' }.to change(Booking, :count)
      end
    end
  end
   
  describe "book with valid information more than inventory" do
    before { visit new_booking_path(slot: slot.id) }
    before { click_button '立即RSVP' }
    before { visit new_booking_path(slot: slot.id) }
    it { should_not have_css('body.bookings_new') }
  end
end