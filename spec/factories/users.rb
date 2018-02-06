# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email 'foo@ba}r.com'
    password 'foobar'
  end
end
