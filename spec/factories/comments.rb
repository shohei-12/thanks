FactoryBot.define do
  factory :comment1, class: Comment do
    association :user, factory: :test1
    association :post, factory: :post1
    sequence(:content) { |i| "test#{i}です。" }
  end
end
