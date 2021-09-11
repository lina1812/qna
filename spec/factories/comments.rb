FactoryBot.define do
  factory :comment do
    author { nil }
    body { 'MyText' }
    commentable { nil }
  end
end
