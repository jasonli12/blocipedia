# Create standard users

5.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password,
  )
  User.last.confirm
end

users = User.all

15.times do
  Wiki.create!(
    title: Faker::Friends.unique.quote,
    body: Faker::Company.bs,
    private: false,
    user: users.sample
  )
end

wikis = Wiki.all

# Create an admin user
admin = User.create!(
  email: 'admin@example.com',
  password: 'helloworld',
)

admin.confirm
admin.update_attribute(:role, 'admin')

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
