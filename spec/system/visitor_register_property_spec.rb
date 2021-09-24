require 'rails_helper'

describe 'Visitor register property' do
   it 'Successfully' do
    #Arrange

    #Act
    visit root_path
    click_on 'Cadastrar Imóvel'

    fill_in 'Título', with: 'Casa em Florianópolis'
    fill_in 'Descrição', with: 'Ótima casa perto da UFSC'
    fill_in 'Quartos', with: '3'
    fill_in 'Banheiros', with: '2'
    fill_in 'Diária', with: 200
    check 'Aceita Pets'
    check 'Vaga de Estacionamento'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content("Casa em Florianópolis")
    expect(page).to have_content("Ótima casa perto da UFSC")
    expect(page).to have_content("Quartos: 3")
    expect(page).to have_content("Banheiros: 2")
    expect(page).to have_content("Aceita Pets: Sim")
    expect(page).to have_content("Estacionamento: Sim")
    expect(page).to have_content("Diária: R$ 200,00")
   end 

   it "must fill all fields" do
      #Arrange

      #Act
      visit root_path
      click_on 'Cadastrar Imóvel'      
      click_on 'Enviar'

      # Assert
      expect(page).to have_content('não pode ficar em branco') 

      # expect(page).to have_content('Título não pode ficar em branco') 
      # expect(page).to have_content('Descrição não pode ficar em branco') 
      # expect(page).to have_content('Quartos não pode ficar em branco') 
      # expect(page).to have_content('Banheiros não pode ficar em branco') 
      # expect(page).to have_content('Diária não pode ficar em branco')

      # TODO: verificar que rooms, daily_rate e bathrooms são numéricos
      # TODO: verificar que rooms, daily_rate e bathrooms são maiores que zero
      
      expect(Property.count).to eq(0) 

   end
   
end