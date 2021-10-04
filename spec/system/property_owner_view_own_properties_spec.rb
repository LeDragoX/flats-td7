require 'rails_helper'

describe 'Property Owner view own properties' do
    it 'using header menu' do
        # ARRANGE
        property_owner = PropertyOwner.create!(email: 'john@doe.com', password: '123456789')

        # ACT
        login_as(property_owner, scope: :property_owner)
        visit root_path

        # ASSERT
        expect(page).to have_link('Meus Imóveis', href: my_properties_properties_path) 
    end
    
    it 'should view owned properties' do
        # ARRANGE
        john = PropertyOwner.create!(email: 'john@doe.com', password: '123456789')
        keanu = PropertyOwner.create!(email: 'keanu@reeves.com', password: '123456789')

        house = PropertyType.create!(name: 'Casa') # ! Melhor explodir no teste do que em produção
        Property.create!({ title: 'Casa com quintal em Copacabana',
                           description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                           rooms: 3, bathrooms: 3, daily_rate: 300, pets: true,
                           property_type: house, property_owner: john
                        })
        Property.create!({ title: 'Casa com piscina em Porto Alegre',
                           description: 'Ótima casa, com todos acessórios e internet rápida',
                           rooms: 2, bathrooms: 1, daily_rate: 100, pets: true,
                           property_type: house, property_owner: keanu
                        })
                    
        # ACT
        login_as(john, scope: :property_owner)
        visit root_path
        click_on 'Meus Imóveis'

        # ASSERT
        expect(page).to have_content 'Casa com quintal em Copacabana'
        expect(page).to_not have_content 'Casa com piscina em Porto Alegre' 
    end

    it "and has no properties" do
        keanu = PropertyOwner.create!(email: 'keanu@reeves.com', password: '123456789')

        login_as(keanu, scope: :property_owner)
        visit root_path
        click_on 'Meus Imóveis'

        expect(page).to have_content 'Você ainda não cadastrou imóveis' 
        expect(page).to have_link('Cadastre seu primeiro imóvel agora', href: new_property_path) 
    end
end
