FactoryBot.define do
  factory :tweet do
    text {'テストを書く'}
    image {''}
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    user
  end
end