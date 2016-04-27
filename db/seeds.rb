# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.first_or_create(
    email: 'admin@example.com',
    password: 'password',
    password_confirmation: 'password')

Hotel.first_or_create(name: 'Hotel 1', address: 'Address 1', star_rating: 5.0, accomodation_type: 'Hotel')