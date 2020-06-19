FactoryBot.define do
  factory :user do
    nick_name { "test" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { "testuser" }
  end

  factory :other_user, class: User do
    nick_name { "other_test" }
    sequence(:email) { |n| "OTHER#{n}@example.com" }
    password { "otheruser" }
  end
end