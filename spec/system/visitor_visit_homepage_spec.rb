require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'Flats')
    expect(page).to have_css('h3', text: 'Boas vindas ao sistema de locação de '\
                                         'apartamentos')
  end

  it "and view properties" do
    # Arrange => Prepare data
    Property.create({ title: 'Casa com quintal em Copacabana',
                      description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                      rooms: 3
      })

    Property.create({ title: 'Cobertura em Manaus',
                      description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                      rooms: 5
      })
    
    # Act => Execute the feature
    visit root_path

    # Assert => Ensure something happened or NOT
    # 2 imoveis ~> casa em Copacabana, apartamento em Manaus
    expect(page).to have_content("Casa com quintal em Copacabana")
    expect(page).to have_content("Excelente casa, recém reformada com 2 vagas de garagem")
    expect(page).to have_content("Quartos: 3")
    expect(page).to have_content("Cobertura em Manaus")
    expect(page).to have_content("Cobertura de 300m2, churrasqueira e sauna privativa")
    expect(page).to have_content("Quartos: 5")

  end

  it 'and theres no property available' do
    #Act => Agir (executar a funcionalidade)
    visit root_path
    expect(page).to have_content("Nenhum imóvel disponível")
  end

  it 'and view property details' do
    #Arrange => Preparar (os dados)
    Property.create({ title: 'Casa com quintal em Copacabana', 
                      description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                      rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 500
                    })

    visit root_path
    click_on 'Casa com quintal em Copacabana'

    expect(page).to have_content("Casa com quintal em Copacabana")
    expect(page).to have_content("Excelente casa, recém reformada com 2 vagas de garagem")
    expect(page).to have_content("Quartos: 3")
    expect(page).to have_content("Banheiros: 2")
    expect(page).to have_content("Aceita Pets: Sim")
    expect(page).to have_content("Estacionamento: Sim")
    expect(page).to have_content("Diária: R$ 500,00")

  end
end
