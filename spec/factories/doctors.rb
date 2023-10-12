FactoryBot.define do
  factory :doctor do
    name { 'Dr. John Doe' }
    specialty { 'Cardiology' }
    working_hours { { start: '9:00 AM', end: '5:00 PM' } }
  end
end
