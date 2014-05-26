#encoding: utf-8 
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    usercount = 10

    creste_user(usercount)
    create_merchant(usercount)
    create_categories
    create_activities
    create_comments
  end
end

def creste_user(x)
  (0..x).each do |n|
      user = "user#{n+1}"
      email = "user#{n+1}@example.com"
      password  = "password"
      customer = User.new(name: user,
                   email: email,
                   password: password,
                   password_confirmation: password)
#       customer.skip_confirmation!
      customer.save!
  end
end

def create_merchant(x)
  (0..x).each do |n|
    merchant = "merchant#{n+1}"
      email = "merchant#{n+1}@example.com"
      password  = "password"
      merchant = Merchant.new(name: merchant,
                   email: email,
                   password: password,
                   password_confirmation: password)
#       merchant.skip_confirmation!
      merchant.save
  end
end

def create_activities
  d = Date.today
  t = Time.now

  merchants = Merchant.all
  merchants.each do |merchant|
    rand(1..5).times do |n|
      category = Category.all.sample
      activity = merchant.activities.build(
        title: "Activity" + rand(100000).to_s,
        about: "Whatever this is I really dont care",
        bookmsg: "Whatever this is I really dont care",
        price: (50*rand(1..10)),
        duration: (10*rand(1..10)),
        category_id: category.id
        )
      activity.save
    end
  end
end

def create_comments
  activities = Activity.all
  activities.each do |commentable|
    rand(1..15).times do |n|
      user = User.all.sample
      comment = commentable.comments.create
      comment.title = user.id
      comment.comment = "This is the first comment."
      comment.save
    end
  end
end

def create_categories
  cat_list = [{ :en => 'Eat & Drink', :HK => '飲食'},
              { :en => 'Relaxing', :HK => '休閑'},
              { :en => 'Action', :HK => '動態'},
              { :en => 'Creative', :HK => '創意'},
              { :en => 'Entertaining', :HK => '娛樂' },
              { :en => 'Educational', :HK => '學習' }]

  cat_list.each do |n|
    cat = Category.create!(name: n[:en])
  end
end