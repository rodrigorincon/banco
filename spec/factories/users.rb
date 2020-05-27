FactoryBot.define do
  factory :user do
    
    trait :user1 do
	    name Faker::Name.name
		email Faker::Internet.email
    	password Faker::Lorem.characters(number: 15)
    end

    trait :user2 do
	    name Faker::Name.name
		email Faker::Internet.email
    	password Faker::Lorem.characters(number: 15)
    end
  end

end
