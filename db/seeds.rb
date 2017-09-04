require "csv"
units_csv = CSV.readlines("db/units.csv", encoding: 'Shift_JIS:UTF-8')
units_csv.shift
units_csv.each do |row|
  Unit.create(kyouin:row[1],kamoku:row[2],jigen:row[3],year:row[4],kaikou:row[5])
end


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
