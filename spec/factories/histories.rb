FactoryBot.define do
  factory :history do
    association :source_account
    association :dest_account
    action [History::ACTION_WITHDRAW, History::ACTION_DEPOSIT, History::ACTION_TRANSFER].sample
    value Faker::Number.decimal(r_digits: 2)
  end
end
