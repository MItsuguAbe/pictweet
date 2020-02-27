FactoryBot.define do
  factory :user do
    nickname              {"abe"}
    password              {"password"}
    password_confirmation {"password"}
    sequence(:email) {Faker::Internet.email}
  end
end