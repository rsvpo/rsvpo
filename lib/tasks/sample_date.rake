#encoding: utf-8 
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    usercount = 10

    creste_user(usercount)
    create_merchant(usercount)
    create_categories
    create_addresses
    create_activities
    add_addresses_to_activities
    add_slots
    create_comments
    customers_view_activities
    message_semd_to_each_other
    book_activities
    follow_merchants
    like_activities
#     share_activities
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

def add_addresses_to_activities
  activities = Activity.all
  activities.each do |activity| 
    addresses = activity.merchant.addresses
    addresses.each_with_index do |address, index|
      if (index > 1)
        if [true,false][rand(2)]
          address.activities_addresses.create!(activity_id: activity.id)
        end
      else
        address.activities_addresses.create!(activity_id: activity.id)
      end
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

def customers_view_activities
  activities = Activity.all
  users = User.all
  activities.each do |activity|
    rand(1..3).times do |n|
      users.each do |user|
        view = user.views.create!(activity_id: activity.id)
      end
    end
  end
end

def create_addresses
  merchants = Merchant.all
  merchants.each do |merchant|
    rand(1..5).times do |n|
      address = merchant.addresses.build(
        address: "Address" + rand(100000).to_s,
        locality: ["美孚", "長沙灣", "元朗", "馬鞍山", "中環"].sample,
        province: ["九龍", "新界", "香港島", "離島"].sample,
        country: "香港",
        phone: rand.to_s[2..9],
        lat: ["22.3366356", "22.3367376", "22.4592244", "22.4030699", "22.2799907", "22.279461", "22.32420329542697", "22.334756854525974", "22.295026573816187", "22.257828741848275", "22.38746158681037"].sample,
        lng: ["114.14021950000006", "114.15285319999998", "114.0309608", "114.24499370000001", "114.15879829999994", "114.18093859999999", "114.21084667409673", "114.17663330000005", "114.244773577832", "113.9411388264648", "113.96028094550775"].sample
        )
      address.save
    end
  end
end

def message_semd_to_each_other
  merchants = Merchant.all
  merchants.each do |merchant|
    rand(1..20).times do |n|
      user = User.all.sample
      receive = user.messages.build(merchant_id: merchant.id, content: "I am fine, thank you!", mu: false)
      receive.save
      sent = merchant.messages.build(user_id: user.id, content: "Hey how is it going?", mu: true)
      sent.save
    end
  end
end

# def share_activities
#   activities = Activity.all
#   users = User.all
#   activities.each do |activity|
#     rand(1..3).times do |n|
#       users.each do |user|
#         share = user.shares.create!(receiver: "receiver#{n+1}@example.com", message: "Hey, what do you think of this", activity_id: activity.id)
#       end
#     end
#   end
# end

def add_slots
  activities = Activity.all
  d = Date.today
  t = Time.now
  des = "Description" + rand(100000).to_s
  todate = d + rand(30..60).days
  fromtime = t.change(:sec => 0, :min => 0, :hour => 0)
  totime = fromtime + 60.minutes
  activities.each do |activity|
    address = activity.addresses.sample
    rule =  Rule.create!( description: des,
                          inventory: rand(2..10),
                          address_id: address.id,
                          is_all_day: false,
                          from_date: d,
                          from_time: fromtime,
                          to_date: d,
                          to_time: totime,
                          repeats: 'weekly',
                          repeats_every_n_days: nil,
                          repeats_every_n_weeks: 1,
                          repeats_weekly_each_days_of_the_week_mask: 65,
                          repeats_every_n_months: nil,
                          repeats_monthly: 'each',
                          repeats_every_n_years: nil,
                          repeats_yearly_on: false,
                          repeat_ends: 'never',
                          repeat_ends_on: todate,
                          time_zone: 'Eastern Time (US & Canada)',
                          activity_id: activity.id)
  end
end

def book_activities
  slots = Slot.all
  users = User.all
  slots.each do |slot|
    if rand(5) == 3
      if [true,false][rand(2)]
        rand(1..3).times do |n|
          users.each do |user|
            booking = user.bookings.create!(email: "bookerer#{n+1}@example.com",
              name: "Whoever",
              phone: "33807389",
              optional: "This is optional text", 
              slot_id: slot.id)
          end
        end
      end
    end
  end
end

def like_activities
  activities = Activity.all
  users = User.all
  activities.each do |activity|
    if rand(5) == 3
      if [true,false][rand(2)]
        users.each do |user|
          like = user.likes.create!(activity_id: activity.id)
        end
      end
    end
  end
end

def follow_merchants
  merchants = Merchant.all
  users = User.all
  merchants.each do |merchant|
    if rand(5) == 3
      if [true,false][rand(2)]
        users.each do |user|
          follow = user.follows.create!(merchant_id: merchant.id)
        end
      end
    end
  end
end