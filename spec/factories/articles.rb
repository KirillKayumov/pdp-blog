FactoryGirl.define do
  factory :article do
    title { Faker::Lorem.sentence }
    text { Faker::Lorem.paragraph }
    user
  end
end
