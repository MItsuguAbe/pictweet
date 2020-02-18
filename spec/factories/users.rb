FactoryBot.define do
    factory :user do
      nickname { 'テストユーザー' }
      email { 'test1@example.com' }
      password { 'password' }
    end
end
  