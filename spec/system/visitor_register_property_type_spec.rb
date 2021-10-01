require 'rails_helper'

describe 'Visitor register property type' do
    it 'successfully' do
        # ARRANGE
        property_type = PropertyType.create!(name: 'Casa') # ! Melhor explodir no teste do que em produção
        property_owner = PropertyOwner.create!(email: 'john@doe.com', password: '123456789')

        # ACT
        login_as(property_owner, scope: :property_owner)
        visit root_path
        click_on 'Cadastrar Tipo de Imóvel'
        fill_in 'Nome',	with: property_type.name
        click_on 'Enviar'

        # ASSERT
        expect(page).to have_content(property_type.name)
    end
end