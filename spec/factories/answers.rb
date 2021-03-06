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

    trait :with_links do
      after(:build) do |answer|
        create :link, linkable: answer
      end
    end

    trait :with_vote do
      after(:build) do |answer|
        create :vote, votable: answer
      end
    end

    trait :invalid do
      body { nil }
    end
  end
end
