50.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  content = "Hogehoge"
  password = "password"
  User.create!(name: name,
               email: email,
               content: content,
               password: password,
               password_confirmation: password,
               icon: open("./public/uploads/user/icon_test.jpg")
               )
end
