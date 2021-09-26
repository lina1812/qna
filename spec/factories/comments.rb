FactoryBot.define do
  factory :comment do
    association :author, factory: :user
    body { 'MyText' }
    commentable { nil }
  end
end
