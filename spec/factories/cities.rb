FactoryBot.define do
  factory :city do
    state { FactoryBot.create(:state) }
    name { Faker::Address.city }
  end
end
