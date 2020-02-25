
FactoryBot.define do
  factory :user do
    nickname { 'abe' }
    email { 'test1@example.com' }
    password { 'password' }
    password_confirmation {"password"}
  end
end

