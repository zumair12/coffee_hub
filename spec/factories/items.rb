FactoryBot.define do
  factory :item do
    name { 'Example Item' }
    price { 20 }
    tax_rate { 15 }
  end
end
