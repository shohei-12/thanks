FactoryBot.define do
  factory :post1, class: Post do
    association :user, factory: :test1
    sequence(:title) { |i| "test#{i}" }
    sequence(:content) { |i| "test#{i}です。" }
  end
end
