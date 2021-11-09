require 'rails_helper'

RSpec.describe PropertyReservationMailer, type: :mailer do
  context "new reservation" do
    it "should notify property owner" do
      john = PropertyOwner.create!(email: "john@cena.com", password: "123456789")
      johns_property = create(:property, title: "Apartamento Novo",
                                          description: "Um apartamento legal",
                                          rooms: 3, bathrooms: 3, pets: true, daily_rate: 100,
                                          property_owner: john)

      andrew = User.create!(email: "andrew@doe.com.br", password: "123456")

      andrew_reservation = PropertyReservation.create!(start_date: 5.days.from_now.to_date, end_date: 10.days.from_now.to_date,
                                  guests: 6, property: johns_property, user: andrew)

      mail = PropertyReservationMailer.with(reservation: andrew_reservation).notify_new_reservation()

      expect(mail.to).to eq ['john@cena.com']
      expect(mail.from).to eq ['nao-responda@flats.com.br']
      expect(mail.subject).to eq 'Nova reserva para seu imóvel'
      expect(mail.body).to include "Seu imóvel <strong>'Apartamento Novo'</strong> foi reservado por andrew@doe.com.br"
    end
  end
end