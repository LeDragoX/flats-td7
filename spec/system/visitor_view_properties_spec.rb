require 'rails_helper'

describe 'Visitor visit homepage' do
  it "and view properties" do
    # Arrange => Prepare data
    keanu = PropertyOwner.create!(email: 'keanu@reeves.com', password: '123456789')

    pt_1 = PropertyType.create!(name: 'Casa') # ! Melhor explodir no teste do que em produção
    Property.create!({ title: 'Casa com quintal em Copacabana',
                       description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                       rooms: 3, bathrooms: 3, daily_rate: 300, pets: true,
                       property_type: pt_1, property_owner: keanu
                    })

    pt_2 = PropertyType.create!(name: 'Apartamento') # ! Melhor explodir no teste do que em produção
    Property.create!({ title: 'Cobertura em Manaus',
                       description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                       rooms: 5, bathrooms: 5, daily_rate: 150, pets: false,
                       property_type: pt_2, property_owner: keanu
                    })
    
    # Act => Execute the feature
    visit root_path

    # Assert => Ensure something happened or NOT
    expect(page).to have_content("Casa com quintal em Copacabana")
    expect(page).to have_content("Excelente casa, recém reformada com 2 vagas de garagem")
    expect(page).to have_content("Quartos: 3")

    expect(page).to have_content("Cobertura em Manaus")
    expect(page).to have_content("Cobertura de 300m2, churrasqueira e sauna privativa")
    expect(page).to have_content("Quartos: 5")

  end

  it 'and theres no property available' do
    # ACT => Agir (executar a funcionalidade)
    visit root_path
    expect(page).to have_content("Nenhum imóvel disponível")
  end

  it 'and view property details' do
    # ARRANGE => Preparar (os dados)
    keanu = PropertyOwner.create!(email: 'keanu@reeves.com', password: '123456789')

    pt_1 = PropertyType.create!(name: 'Casa') # ! Melhor explodir no teste do que em produção
    PropertyType.create!(name: 'Casa') # ! Melhor explodir no teste do que em produção
    Property.create!({ title: 'Casa com quintal em Copacabana', 
                       description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                       rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 500,
                       property_type: pt_1, property_owner: keanu
                    })

    # ACT
    visit root_path
    click_on 'Casa com quintal em Copacabana'

    # ASSERT
    expect(page).to have_content("Casa com quintal em Copacabana")
    expect(page).to have_content("Excelente casa, recém reformada com 2 vagas de garagem")
    expect(page).to have_content("Quartos: 3")
    expect(page).to have_content("Banheiros: 2")
    expect(page).to have_content("Aceita Pets: Sim")
    expect(page).to have_content("Estacionamento: Sim")
    expect(page).to have_content("Diária: R$ 500,00")
    expect(page).to have_content("Tipo: Casa")

  end

  it 'and view property details and return to home page' do
    # ARRANGE
    keanu = PropertyOwner.create!(email: 'keanu@reeves.com', password: '123456789')

    pt_1 = PropertyType.create!(name: 'Casa') # ! Melhor explodir no teste do que em produção
    Property.create!({ title: 'Casa com quintal em Copacabana', 
                       description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                       rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 500,
                       property_type: pt_1, property_owner: keanu
                    })

    pt_2 = PropertyType.create!(name: 'Apartamento') # ! Melhor explodir no teste do que em produção
    Property.create!({ title: 'Cobertura em Manaus', 
                       description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                       rooms: 5, parking_slot: false, bathrooms: 5, daily_rate: 150, pets: false,
                       property_type: pt_1, property_owner: keanu
                    })

    # ACT
    visit root_path
    click_on 'Casa com quintal em Copacabana'
    click_on 'Voltar'

    # ASSERT
    expect(current_path).to eq root_path
    expect(page).to have_content('Casa com quintal em Copacabana')
    expect(page).to have_content('Cobertura em Manaus')
  end
end
