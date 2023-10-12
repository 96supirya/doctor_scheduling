FactoryBot.define do
  factory :availability do
    start_time { Time.now }
    end_time { Time.now + 1.hour }
    association :doctor
  end
end
