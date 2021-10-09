require 'rails_helper'

RSpec.describe PropertyReservation, type: :model do
    include ActiveSupport::Testing::TimeHelpers
    describe "#valid?" do
        it "start date greater than end date" do
            # ARRANGE
            property_type = PropertyType.create!(name: 'Casa')
            property_owner = PropertyOwner.create!(email: 'john@doe.com', password: '123456789')
            property = Property.create!({ title: 'Casa com quintal em Copacabana',
                                            description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                                            rooms: 3, bathrooms: 3, daily_rate: 100, pets: true,
                                            property_type: property_type, property_owner: property_owner
                                        })
            user = User.create!(email: 'keanu@reeves.com', password: '123456789')
            reservation = PropertyReservation.new(start_date: 5.days.from_now ,
                                                    end_date: 2.days.from_now,
                                                    guests: 2,
                                                    property: property,
                                                    user: user)

            # ACT
            reservation.valid?
            # ASSERT
            expect(reservation.errors[:end_date]).to include('deve ser maior que a Data de Início')
        end

        it "end date equal to start date" do
            property_type = PropertyType.create!(name: 'Casa')
            property_owner = PropertyOwner.create!(email: 'john@doe.com', password: '123456789')
            property = Property.create!({ title: 'Casa com quintal em Copacabana',
                                            description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                                            rooms: 3, bathrooms: 3, daily_rate: 100, pets: true,
                                            property_type: property_type, property_owner: property_owner
                                        })
            user = User.create!(email: 'keanu@reeves.com', password: '123456789')
            reservation = PropertyReservation.new(start_date: 5.days.from_now ,
                                                    end_date: 5.days.from_now,
                                                    guests: 2,
                                                    property: property,
                                                    user: user
                                                )

            expect(reservation.valid?).to eq false
        end

        it "start date is in the past" do
            property_type = PropertyType.create!(name: 'Casa')
            property_owner = PropertyOwner.create!(email: 'john@doe.com', password: '123456789')
            property = Property.create!({ title: 'Casa com quintal em Copacabana',
                                            description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                                            rooms: 3, bathrooms: 3, daily_rate: 100, pets: true,
                                            property_type: property_type, property_owner: property_owner
                                        })
            user = User.create!(email: 'keanu@reeves.com', password: '123456789')
            reservation = PropertyReservation.new(guests: 2, property: property, user: user)

            travel_to 1.month.ago do
                reservation.start_date = Date.today
                reservation.end_date = 1.day.from_now
            end

            expect(reservation.valid?).to eq false
        end
    end
end
