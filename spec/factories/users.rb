require 'faker'

FactoryBot.define do
  factory :user do
    id { Faker::Number.within(range: 1..500) }
    name { Faker::Name.unique.middle_name }
    email { Faker::Internet.unique.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
