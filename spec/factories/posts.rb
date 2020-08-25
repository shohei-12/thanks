FactoryBot.define do
  factory :post1, class: Post do
    association :user, factory: :test1
    association :category, factory: :category1
    sequence(:title) { |i| "test#{i}" }
    sequence(:content) { |i| "test#{i}です。" }
    check { 1 }
    status { 1 }
  end
end
