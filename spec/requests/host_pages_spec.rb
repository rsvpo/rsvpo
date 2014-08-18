require 'spec_helper'

describe "Host pages" do
  
  before { visit new_merchant_registration_path }
  before do
        fill_in "merchant_name",         with: "Trail"
        fill_in "merchant_email",        with: "trail@example.com"
        fill_in "merchant_password",     with: "Password"
        fill_in "merchant_password_confirmation", with: "Password"
      end
  before { click_button '立即註冊' }
  
  subject { page }
  
  describe "Host index page" do

    before { visit hosts_path }

    it { should have_css("body.hosts_index") }
    
    describe "New host page" do
      
      before { visit new_host_path }
      it { should have_css("body.hosts_new") }
      
      describe "with invalid information" do
        it "should not create a hostt" do
          expect { click_button '確認主持' }.not_to change(Host, :count)
        end
      end

      describe "with valid information" do
        before do
          fill_in "host_title",         with: "Example"
          fill_in "host_job",        with: "Example"
          fill_in "host_description",     with: "Random text"
        end

        it "should create a host" do
          expect { click_button '確認主持' }.to change(Host, :count).by(1)
        end
      end
    end
  end
end