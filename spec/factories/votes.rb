FactoryBot.define do
  factory :vote do
    association :author, factory: :user
    association :votable, factory: :question
    value { 1 }
  end
end
