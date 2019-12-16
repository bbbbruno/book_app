# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
[
  ['四月は君の嘘', 'ピアニストの少年とバイオリニストの少女による音楽と青春の話', ''],
  ['some title', 'some memo', ''],
  ['ちはやふる', '熱血競技かるた漫画', '末次由紀'],
  ['RubyとRailsの学習ガイド', 'Rails関連技術地図とそれらの学習資料の紹介', '五十嵐邦明']
].each do |title, memo, author|
  Book.create!(
    title: title,
    memo: memo,
    author: author,
  )
end

96.times do |n|
  title = Faker::Lorem.sentence(word_count: 1)
  memo = Faker::Lorem.sentence(word_count: 5)
  author = Faker::Name.name
  Book.create!(
    title: title,
    memo: memo,
    author: author,
  )
end
