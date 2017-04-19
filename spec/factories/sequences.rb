FactoryGirl.define do
  sequence :email do |n|
    "bob#{n}@bobross.com"
  end

  sequence :name do |n|
    "User#{n}"
  end
end
