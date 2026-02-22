FactoryBot.define do
  factory :rental do
    book { nil }
    renter_name { "MyString" }
    rented_at { "2026-02-22 08:10:16" }
    returned_at { "2026-02-22 08:10:16" }
  end
end
