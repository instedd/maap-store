FactoryBot.define do
  factory :tag do
    name { FFaker::Tweet.tags }
  end
end
