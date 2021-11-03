FactoryBot.define do
  factory :property_owner do
    email { generate(:email) }
    password { "123123123123" }
  end
end