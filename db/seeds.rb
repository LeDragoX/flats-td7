# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

apt = PropertyType.create!(name: 'Apartamento')
house = PropertyType.create!(name: 'Casa')
sitio = PropertyType.create!(name: 'Sítio')

john = PropertyOwner.create!(email: 'john@doe.com', password: '123456789')
keanu = PropertyOwner.create!(email: 'keanu@reeves.com', password: '123456789')
test = PropertyOwner.create!({ email: 'test@flats.com', password: '123456' })

Property.create!({ title: 'Casa com quintal em Morumbi',
                   description: 'Excelente casa, com direito a área Gourmet e uma bela vista',
                   rooms: 5, bathrooms: 3, daily_rate: 400, pets: true,
                   property_type: house, property_owner: john
                })
Property.create!({ title: 'Casa com piscina em Porto Alegre',
                   description: 'Ótima casa, com todos acessórios e internet rápida',
                   rooms: 2, bathrooms: 1, daily_rate: 100, pets: true,
                   property_type: house, property_owner: keanu
                })

Property.create!({ title: 'Casa com quintal em Copacabana',
                   description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                   rooms: 3, bathrooms: 3, daily_rate: 300, pets: true,
                   property_type: house, property_owner: test
                })

Property.create!({ title: 'Cobertura em Manaus',
                   description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                   rooms: 5, bathrooms: 5, daily_rate: 600, pets: false,
                   property_type: apt, property_owner: test
                })

