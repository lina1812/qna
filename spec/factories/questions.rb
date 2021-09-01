FactoryBot.define do
  factory :question do
    title { 'MyString' }
    body { 'MyText' }
    best_answer { nil }
    association :author, factory: :user

    trait :invalid do
      title { nil }
    end
  end
end
