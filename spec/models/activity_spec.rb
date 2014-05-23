require 'spec_helper'

describe Activity do

  let(:merchant) { FactoryGirl.create(:merchant) }
  before { @activity = merchant.activities.build(title: "Lorem ipsum", about: "Lorem ipsum", price: 10, bookmsg: "Lorem ipsum", duration: 10) }

  subject { @activity }

  it { should respond_to(:title) }
  it { should respond_to(:merchant_id) }
  it { should respond_to(:merchant) }
  it { should respond_to(:rules) }
  its(:merchant) { should eq merchant }

  it { should be_valid }

  describe "when merchant_id is not present" do
    before { @activity.merchant_id = nil }
    it { should_not be_valid }
  end
  
  describe "with blank about" do
    before { @activity.about = " " }
    it { should_not be_valid }
  end
  
  describe "with blank title" do
    before { @activity.title = " " }
    it { should_not be_valid }
  end
  
  describe "with title that is too long" do
    before { @activity.title = "a" * 501 }
    it { should_not be_valid }
  end
end