# guest user
User.create!(
  name: 'ゲストユーザー',
  email: 'guest@example.com',
  password: 'password',
  password_confirmation: 'password'
)

# user
50.times do |n|
  User.create!(
    name: Gimei.unique.name.kanji,
    email: "example#{n + 1}@example.com",
    password: 'password',
    password_confirmation: 'password'
  )
end

# category
categories = %w[お父さん・お母さん お兄ちゃん・お姉ちゃん 弟・妹 おじいちゃん・おばあちゃん 旦那さん・奥さん 息子・娘 孫 彼氏・彼女 友達 その他]

categories.each do |category|
  Category.create!(
    name: category
  )
end

# post
30.times do |n|
  Post.create!(
    title: "テスト#{n + 1}",
    content: "テスト#{n + 1}です。",
    user_id: 1,
    category_id: 1
  )
end

# comment
30.times do |n|
  Comment.create!(
    content: "テストコメント#{n + 1}です。",
    user_id: rand(1..51),
    post_id: 30
  )
end
