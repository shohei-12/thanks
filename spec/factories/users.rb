FactoryBot.define do
  factory :test1, class: User do
    name { 'test1' }
    email { 'test1@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :guest, class: User do
    name { 'guest' }
    email { 'guest@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
