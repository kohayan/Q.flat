FactoryBot.define do
  factory :user do
    nick_name { "test" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { "testuser" }
  end
end