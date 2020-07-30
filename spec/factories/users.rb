FactoryBot.define do
  factory :test1, class: User do
    name { 'test1' }
    email { 'test1@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :test2, class: User do
    name { 'test2' }
    email { 'test2@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :guest, class: User do
    name { 'guest' }
    email { 'guest@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
