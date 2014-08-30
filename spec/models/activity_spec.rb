# require 'spec_helper'

# describe Activity do
#   merchant = Merchant.create!(name: "Example User", email: "whatever@example.com",
#         password: "Password", password_confirmation: "Password")
#   @category = Category.create!(name: '飲食')
#   address = Address.create!(address: "Address", phone: "MyString", locality: "MyString", province: "MyString", country: "MyString", lat: "9.99", lng: "9.99")
#   @activity = address.activities.build(title: "Lorem ipsum", about: "Lorem ipsum", price: 10, bookmsg: "Lorem ipsum", duration: 10, category_id: @category.id, merchant_id: merchant.id)
#   @activity.save

#   subject { @activity }

#   it { should respond_to(:title) }
#   it { should respond_to(:merchant_id) }
#   it { should respond_to(:merchant) }
#   it { should respond_to(:rules) }
#   its(:merchant) { should eq merchant }

#   it { should be_valid }

#   describe "when merchant_id is not present" do
#     before { @activity.merchant_id = nil }
#     it { should_not be_valid }
#   end
  
#   describe "with blank about" do
#     before { @activity.about = " " }
#     it { should_not be_valid }
#   end
  
#   describe "with blank title" do
#     before { @activity.title = " " }
#     it { should_not be_valid }
#   end
  
#   describe "with title that is too long" do
#     before { @activity.title = "a" * 501 }
#     it { should_not be_valid }
#   end
# end