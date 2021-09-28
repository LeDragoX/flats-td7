# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

apt = PropertyType.create!(name: 'Apartamento')
casa = PropertyType.create!(name: 'Casa')
sitio = PropertyType.create!(name: 'Sítio')
Property.create!({ title: 'Casa com quintal em Copacabana',
                   description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                   rooms: 3, bathrooms: 3, daily_rate: 300, pets: true,
                   property_type: casa
                })

Property.create!({ title: 'Cobertura em Manaus',
                   description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                   rooms: 5, bathrooms: 5, daily_rate: 150, pets: false,
                   property_type: apt
                })