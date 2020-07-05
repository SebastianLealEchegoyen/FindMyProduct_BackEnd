# FindMyProduct API
# Copyright (C) 2020  00198216
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, version 3 of the License.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program. If not, see <https://www.gnu.org/licenses/>.

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
User.create([{username: 'Sebas',password: 'lucina',email: 'Sebas@gmail.com',phone: '12334567', photo:'link'},
    {username: 'Hugo',password: 'carbono',email: 'Cugo@gmail.com',phone: '12334568', photo:'link'},
    {username: 'Maxisun', password: "lolis", email: 'max@gmail.com', phone: '12334567', photo:'link'},
    {username: 'Neto', password: "lia", email: 'lia@gmail.com', phone: '12334567', photo:'link'}])

#List.delete_all
#List.create({name:'TestList2',quantity:5})

#Product.delete_all
#Product.create({name:'Maxipizza',category:'kg',quantity:4,photo:'link',list_id:1})