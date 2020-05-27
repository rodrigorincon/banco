FactoryBot.define do
  factory :account do

  	trait :account1 do
	    association(:user, :user1)
	    money Faker::Number.decimal(r_digits: 2)
	    agency Faker::Number.number(digits: 5)
	    bank_account Faker::Number.number(digits: 5)
	end

	trait :account2 do
	    association(:user, :user2)
	    money Faker::Number.decimal(r_digits: 2)
	    agency Faker::Number.number(digits: 5)
	    bank_account Faker::Number.number(digits: 5)
	end
  end
end
