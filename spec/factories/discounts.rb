FactoryBot.define do
  factory :discount do
    item_id { association(:item).id }
    applicable_item_id { nil }
    discount_rate { 30 }
    cap_amount { 10.00 }
  end
end
