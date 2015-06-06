# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Package.create(name: "rails")
Package.create(name: "activerecord")
Version.create(number: "1.0.0", package_id: "1")
@user = User.create(email: "test@test.com", password: "test1234", password_confirmation: "test1234")
Ownership.create(package_id: "1", user_id: @user.id)
