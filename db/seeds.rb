# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create users
users = User.create!([
  {
    name: 'Bob',
    email: 'bob@example.com',
    password: 'givemeatoken'
  }
])

# Create ads
Ad.create!([
  {
    title: 'Ad title 1',
    description: 'Ad description 1',
    city: 'City 1',
    user: users[0]
  },
  {
    title: 'Ad title 2',
    description: 'Ad description 2',
    city: 'City 1',
    user: users[0]
  },
  {
    title: 'Ad title 3',
    description: 'Ad description 3',
    city: 'City 2',
    user: users[0]
  }
])
