require 'rails_helper'

describe "Property Owner authentication" do
    it "cannot create a property if not authenticated" do
        # ACT
        # post '/properties' # Somente usar rota quando for uma integração externa
        post properties_path
        
        # ASSERT
        expect(response).to redirect_to(new_property_owner_session_path) 
    end

    it "cannot open new property form unless authenticated" do
        # ACT
        get new_property_path

        # ASSERT
        expect(response).to redirect_to(new_property_owner_session_path) 
    end
    
end
