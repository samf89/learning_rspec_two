puts 'deleting from users'
User.delete_all

puts 'creating admin user'
User.create!( username: 'admin', firstname: 'ad', lastname: 'min', email: 'admin@email.com', password: '123456', password_confirmation: '123456', admin: true )

puts 'creating non admin user'
User.create!( username: 'normal', firstname: 'norm', lastname: 'al', email: 'normal@email.com', password: '123456', password_confirmation: '123456' )
