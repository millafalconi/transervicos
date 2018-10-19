FactoryBot.define do
  factory :address do
    city { FactoryBot.create(:city) }
    state { FactoryBot.create(:state) }
    street { Faker::Address.street_name }
    number { Faker::Address.building_number }
    complement { Faker::Address.secondary_address }
    neighborhood { Faker::Address.street_name }
  end
end
