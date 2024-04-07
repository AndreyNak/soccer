# frozen_string_literal: true

FactoryBot.define do
  factory :player do
    name { Faker::Sports::Football.player }
    age { rand(18..40) }
    team
  end

  factory :team do
    name { Faker::Sports::Football.team }
  end

  factory :match do
    result { Faker::Lorem.paragraph }
  end

  factory :performance
end
