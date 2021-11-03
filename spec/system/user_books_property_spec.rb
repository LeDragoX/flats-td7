require 'rails_helper'

describe "user books property" do
    it "successfully" do
        # ARRANGE
        property_type = PropertyType.create!(name: 'Casa')
        property_owner = PropertyOwner.create!(email: 'john@doe.com', password: '123456789')
        property = Property.create!({ title: 'Casa com quintal em Copacabana',
                                      description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                                      rooms: 3, bathrooms: 3, daily_rate: 100, pets: true,
                                      property_type: property_type, property_owner: property_owner
                                    })
        user = User.create!(email: 'keanu@reeves.com', password: '123456789')

        # ACT
        login_as user, scope: :user
        visit root_path
        click_on property.title
        fill_in 'Data de Início', with: 5.days.from_now.to_date
        fill_in 'Data de Término', with: 10.days.from_now.to_date
        fill_in 'Quantidade de pessoas', with: 3
        click_on 'Enviar Reserva'

        # ASSERT
        expect(page).to have_content(I18n.localize 5.days.from_now.to_date)
        expect(page).to have_content(I18n.l 10.days.from_now.to_date)
        expect(page).to have_content(/3/)
        expect(page).to have_content('R$ 500,00') # Agendamento por NOITE 06-07, 07-08..., quantidade de pessoas não pesam
        expect(page).to have_content('Pedido de reserva enviado com sucesso')
    end
end
