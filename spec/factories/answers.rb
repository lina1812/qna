FactoryBot.define do
  factory :answer do
    body { 'MyText' }
    association :author, factory: :user
    association :question, factory: :question
    trait :invalid do
      body { nil }
    end
  end
end
