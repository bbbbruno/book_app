# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
[
  ['bbbbruno69', 'bbbbruno@gmail.com', 'simsimsim', 'simsimsim'],
  ['ichigo', 'ichigo@gmail.com', 'ichigo', 'ichigo'],
  ['macmac', 'macmac@gmail.com', 'macmac', 'macmac'],
  ['strongzero', 'strong@gmail.com', 'strong', 'strong']
].each do |username, email, password, password_confirmation|
  User.create!(
    username: username,
    email: email,
    password: password,
    password_confirmation: password_confirmation,
    confirmed_at: Time.now,
    uid: User.create_unique_string,
  )
end

User.find_by(username: 'strongzero').profile.update(
  name: 'ストロングマン',
  zipcode: '000-0000',
  address: '寒い寒い北陸のどこか',
  self_introduction: <<~TEXT
  やあ！僕の名前はストロングマン！
  今は北陸の寒い街で活動中だよ！
  寒すぎて今にも凍え死にそうだけどね！
  ハハ！！
  でも、ストロングゼロさえ飲めばへっちゃらさ！
  さあ！君も一緒に飲んでみないかい？？
  TEXT
)

user = User.first
[
  ['四月は君の嘘', 'ピアニストの少年とバイオリニストの少女による音楽と青春の話', ''],
  ['some title', 'some memo', ''],
  ['ちはやふる', '熱血競技かるた漫画', '末次由紀'],
  ['RubyとRailsの学習ガイド', 'Rails関連技術地図とそれらの学習資料の紹介', '五十嵐邦明']
].each do |title, memo, author|
  user.books.create!(
    title: title,
    memo: memo,
    author: author,
  )
end

2.upto(4) do |i|
  user = User.find(i)
  32.times do
    title = Faker::Lorem.sentence(word_count: 1)
    memo = Faker::Lorem.sentence(word_count: 5)
    author = Faker::Name.name
    user.books.create!(
      title: title,
      memo: memo,
      author: author,
    )
  end
end

users = User.all
user = users.first
following = users[1..3]
followers = users[2, 3]
following.each { |followed| user.follow!(followed) }
followers.each { |follower| follower.follow!(user) }
