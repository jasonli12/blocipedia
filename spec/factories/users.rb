FactoryGirl.define do
  factory :user do
    pw = RandomData.random_word
    sequence(:email) {|n| "user#{n}@blocipedia.com"}
    password pw
    password_confirmation pw
  end
end
