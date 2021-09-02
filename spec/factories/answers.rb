FactoryBot.define do
  factory :answer do
    body { 'MyText' }
    association :author, factory: :user
    association :question, factory: :question
    
    trait :with_files do
      after(:build) do |answer|
        answer.files.attach(
          io: File.open("#{Rails.root}/spec/rails_helper.rb"),
          filename: 'rails_helper.rb'
        )
      end
    end
    trait :invalid do
      body { nil }
    end
  end
end
