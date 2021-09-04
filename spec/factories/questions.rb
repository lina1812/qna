FactoryBot.define do
  factory :question do
    title { 'MyString' }
    body { 'MyText' }
    best_answer { nil }
    association :author, factory: :user

    trait :with_files do
      after(:build) do |question|
        question.files.attach(
          io: File.open("#{Rails.root}/spec/rails_helper.rb"),
          filename: 'rails_helper.rb'
        )
      end
    end
    
    trait :with_links do
      after(:build) do |question|
        create :link, linkable: question
      end
    end

    trait :invalid do
      title { nil }
    end
  end
end
