require 'rails_helper'

describe "Visitor filter properties by Type" do
    it "using links on home page" do
        # ARRANGE
        PropertyType.create!(name: 'Apartamento')
        PropertyType.create!(name: 'Casa')
        PropertyType.create!(name: 'Sítio')

        # ACT
        visit root_path

        # ASSERT
        expect(page).to have_link('Apartamento')
        expect(page).to have_link('Casa')
        expect(page).to have_link('Sítio')
    end
    
    it 'sucessfully' do
        # ARRANGE
        apartamento = PropertyType.create!(name: 'Apartamento')
        casa = PropertyType.create!(name: 'Casa')

        Property.create!({ title: 'Cobertura em Manaus',
                           description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                           rooms: 5, bathrooms: 5, daily_rate: 150, pets: false,
                           property_type: apartamento
                        })
        Property.create!({ title: 'Casa com quintal em Copacabana',
                           description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                           rooms: 3, bathrooms: 3, daily_rate: 300, pets: true,
                           property_type: casa
                        })
    
        # ACT
        visit root_path
        click_on 'Casa'

        # ASSERT
        expect(page).to have_css('h1', text: 'Imóveis do tipo Casa') 
        expect(page).to have_link('Casa com quintal em Copacabana') 
        expect(page).not_to have_content('Cobertura em Manaus') 
    end
end
