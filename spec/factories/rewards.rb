FactoryBot.define do
  factory :reward do
    name { "MyReward" }
    after(:build) do |reward|
      reward.image.attach(
        io: File.open("#{Rails.root}/app/assets/images/132984.jpg"),
        filename: '132984.jpg'
      )
    end
  end
end
