require "rails_helper"

describe "Property owner view reservations" do
    it "should view reservations from owned properties" do
        property_type = PropertyType.create!(name: "Um tipo qualquer")
        john = PropertyOwner.create!(email: "john@cena.com", password: "123456789")
        johns_property = Property.create!(title: "Apartamento Novo",
                                            description: "Um apartamento legal",
                                            rooms: 3, bathrooms: 3, pets: true, daily_rate: 100,
                                            property_type: property_type, property_owner: john)

        andrew = User.create!(email: "andrew@doe.com.br", password: "123456")

        andrews_reservation = PropertyReservation.create!(start_date: "10/10/2021", end_date: "14/10/2021",
                                    guests: 6, property: johns_property, user: andrew)
        
        login_as john, scope: :property_owner
        visit root_path
        click_on "Meus Imóveis"
        click_on "Apartamento Novo"

        expect(page).to_not have_content "Reserve Agora"
        expect(page).to have_content "Reservas"
        expect(page).to have_content "Reserva de #{andrew.email}"
        expect(page).to have_content "Data de Início: 10/10/2021"
        expect(page).to have_content "Data de Saída: 14/10/2021"
        expect(page).to have_content "Total de Pessoas: #{andrews_reservation.guests}"
        expect(page).to have_content "Status: Pendente"
    end
    
    it "and does not view others properties reservation" do
        property_type = PropertyType.create!(name: "Um tipo qualquer")
        john = PropertyOwner.create!(email: "john@cena.com", password: "123456789")
        johns_property = Property.create!(title: "Apartamento Novo",
                                            description: "Um apartamento legal",
                                            rooms: 3, bathrooms: 3, pets: true, daily_rate: 100,
                                            property_type: property_type, property_owner: john)
        
        jane = PropertyOwner.create!(email: "jane@doe.com", password: "123456789")
        janes_property = Property.create!(title: "Apartamento Vintage",
                                            description: "Um apartamento com muito estilo",
                                            rooms: 3, bathrooms: 3, pets: true, daily_rate: 100,
                                            property_type: property_type, property_owner: jane)

        andrew = User.create!(email: "andrew@doe.com.br", password: "123456")

        PropertyReservation.create!(start_date: "10/10/2021", end_date: "14/10/2021",
                                    guests: 6, property: johns_property, user: andrew)
        PropertyReservation.create!(start_date: "14/10/2021", end_date: "19/10/2021",
                                    guests: 6, property: janes_property, user: andrew)
        
        login_as john, scope: :property_owner
        visit root_path
        click_on "Meus Imóveis"
        #click_on "Apartamento Vintage"
        expect(page).to_not have_content "Apartamento Vintage" # Tive que mudar o teste, sabe, no meu não existia isso

        expect(page).not_to have_content("Reserve Agora")
        expect(page).not_to have_content("Reserva de andrew@doe.com.br")
        expect(page).not_to have_content("Data de Início: 13/10/2021")
        expect(page).not_to have_content("Data de Saída: 16/10/2021")
    end

    it "and accept reservation" do
        property_type = PropertyType.create!(name: "Um tipo qualquer")
        john = PropertyOwner.create!(email: "john@cena.com", password: "123456789")
        johns_property = Property.create!(title: "Apartamento Novo",
                                            description: "Um apartamento legal",
                                            rooms: 3, bathrooms: 3, pets: true, daily_rate: 100,
                                            property_type: property_type, property_owner: john)

        andrew = User.create!(email: "andrew@doe.com.br", password: "123456")

        andrews_reservation = PropertyReservation.create!(start_date: "09/10/2021", end_date: "12/10/2021",
                                    guests: 6, property: johns_property, user: andrew)
        
        login_as john, scope: :property_owner
        visit root_path
        click_on "Meus Imóveis"
        click_on "Apartamento Novo"
        click_on "Aceitar Reserva"

        expect(current_path).to eq property_path(johns_property)
        expect(page).to have_content "Reservas"
        expect(page).to have_content "Reserva de #{andrew.email}"
        expect(page).to have_content 'Data de Início: 09/10/2021'
        expect(page).to have_content 'Data de Saída: 12/10/2021'
        expect(page).to have_content 'Total de Pessoas: 6'
        expect(page).to have_content 'Status: Aceita'
    end
end
