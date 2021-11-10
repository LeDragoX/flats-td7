require 'rails_helper'

describe 'Property API' do
  context 'GET /api/v1/properties' do
    it 'should get properties' do
      property = create(:property, title: 'Apartamento com churrasqueira')
      other_property = create(:property, title: 'Casa com piscina')

      get '/api/v1/properties', params: { page: 3 }

      expect(response).to have_http_status(200)
      expect(parsed_body.first[:title]).to eq('Apartamento com churrasqueira')
      expect(parsed_body.second[:title]).to eq('Casa com piscina')
      expect(parsed_body.count).to eq(2)
    end

    it "returns no properties" do
      get '/api/v1/properties'

      expect(response).to have_http_status(200)
      expect(parsed_body).to be_empty
    end
  end

  context 'GET /api/v1/properties/:id' do
    it 'should return a property' do
      property = create(:property, title: 'Apartamento legal', bathrooms: 5,
                        daily_rate: 200, pets: true)

      get "/api/v1/properties/#{property.id}"

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:title]).to eq('Apartamento legal')
      expect(parsed_body[:bathrooms]).to eq(5)
      expect(parsed_body[:daily_rate]).to eq('200.0')
      expect(parsed_body[:pets]).to eq(true)
    end

    it 'should return 404 if property does not exist' do
      get '/api/v1/properties/999'

      expect(response).to have_http_status(404)
      expect(parsed_body[:message]).to eq('Objeto não encontrado')
    end
    
    it 'should return 500 if database is not available' do
      property = create(:property, title: 'Apartamento legal', bathrooms: 5,
                                   daily_rate: 200, pets: true)

      allow(Property).to receive(:find).with(property.id.to_s)
                                       .and_raise(ActiveRecord::ActiveRecordError)

      get "/api/v1/properties/#{property.id}"

      expect(response).to have_http_status(500)
      expect(parsed_body[:message]).to eq('Falha ao consultar Banco de Dados')
    end
  end

  context 'POST /api/v1/properties' do
    it 'create a new property' do
      property_type = create(:property_type)
      property_owner = create(:property_owner)      

      property_params = { property: { title: 'Apartamento legal',
                                      description: 'Um ap. legal',
                                      rooms: 5, bathrooms: 1,
                                      daily_rate: 100, pets: true,
                                      property_type_id: property_type.id,
                                      property_owner_id: property_owner.id } }
      post '/api/v1/properties', params: property_params

      expect(response).to have_http_status(201) 
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:id]).to eq(Property.last.id)
      expect(parsed_body[:title]).to eq('Apartamento legal')
      expect(parsed_body[:rooms]).to eq(5)
      expect(parsed_body[:bathrooms]).to eq(1)
      expect(parsed_body[:daily_rate]).to eq('100.0')
      expect(parsed_body[:pets]).to eq(true)
    end
  end
  
end
