# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cat.destroy_all
COLOR = %w(black white orange brown)
SEX = %w(M F)
99.times do
  Cat.create(name: Faker::Name.unique.name, color: COLOR.sample, birth_date: '19/4/2017', sex: SEX.sample)
end
