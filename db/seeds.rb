# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#User.delete_all
#User.create([{username: 'Sebas',password: 'lucina',email: 'Sebas@gmail.com',phone: '12334567', photo:'link'},
   # {username: 'Hugo',password: 'carbono',email: 'Cugo@gmail.com',phone: '12334568', photo:'link'}])

# List.delete_all
List.create({name:'TestList2',quantity:5})

#Product.delete_all
#Product.create({name:'Maxipizza',category:'kg',quantity:4,photo:'link',list_id:1})