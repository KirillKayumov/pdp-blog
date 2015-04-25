FactoryGirl.define do
  factory :comment do
    text { Faker::Lorem.paragraph }
    user
    article
  end
end
